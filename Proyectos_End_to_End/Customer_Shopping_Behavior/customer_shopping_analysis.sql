/* ============================================================================
   PROYECTO   : Customer Shopping Behavior — Análisis end-to-end
   MOTOR      : Microsoft SQL Server 2022 (16.0.1200.5) · SSMS
   BASE       : shopping_analysis
   TABLA      : dbo.customer_shopping   (3,900 filas · 19 columnas)
   ORIGEN     : cargada desde Python (pandas → SQLAlchemy + pyodbc) ya limpia
                y con las columnas derivadas age_group y purchase_frequency_days
   AUTOR      : Eric Salinas Cajaleón — Ing. Industrial y de Sistemas, UDEP
   ----------------------------------------------------------------------------
   GRANO DE LA TABLA: 1 fila = 1 cliente = su ÚLTIMA compra.
   No es un histórico transaccional. Todo SUM(purchase_amount) de este script
   es "ingreso de la última compra de cada cliente", no la facturación de la
   empresa. Las 10 consultas están escritas sabiendo eso.
   ========================================================================== */


-- ============================================================================
-- P1. ¿Cuáles son los ingresos totales generados por clientes masculinos vs. femeninos?
-- Técnica: agregación simple con GROUP BY.
-- Cuidado al leer: el resultado (157,890 vs 75,191) NO dice que los hombres
-- gasten más. La base es 2,652 hombres vs 1,248 mujeres. Ver nota en el README.
-- ============================================================================
select gender, SUM(purchase_amount) as revenue
from customer_shopping
group by gender;


-- ============================================================================
-- P2. ¿Qué clientes utilizaron un descuento pero aún así gastaron más que el
--     monto de compra promedio?
-- Técnica: subconsulta escalar no correlacionada en el WHERE.
-- Se evalúa una sola vez contra toda la tabla, no fila por fila.
-- ============================================================================
select customer_id, purchase_amount
from customer_shopping
where discount_applied = 'Yes' and purchase_amount >= (select AVG(purchase_amount) from customer_shopping);


-- ============================================================================
-- P3. ¿Cuáles son los 5 productos principales con la calificación de reseña
--     promedio más alta?
-- Técnica: TOP + GROUP BY + ORDER BY sobre una agregación.
-- El CAST a numeric(10,2) fuerza aritmética decimal exacta antes de ROUND;
-- sin él, AVG sobre float devuelve un redondeo dependiente de la
-- representación binaria del motor.
-- ============================================================================
select top 5 item_purchased, round(avg(cast(review_rating as numeric(10,2))),2) as "Average Product Rating"
from customer_shopping
group by item_purchased
order by avg(cast(review_rating as numeric(10,2))) desc;


-- ============================================================================
-- P4. Compara los montos de compra promedio entre el envío Estándar y el Exprés.
-- Técnica: filtro con IN + agregación.
-- ============================================================================
select shipping_type,
ROUND(AVG(purchase_amount),2)
from customer_shopping
where shipping_type in ('Standard','Express')
group by shipping_type;


-- ============================================================================
-- P5. ¿Los clientes suscritos gastan más? Compara el gasto promedio y los
--     ingresos totales entre suscriptores y no suscriptores.
-- Técnica: agregación multi-métrica (conteo + promedio + suma) en una pasada.
-- Es la consulta más importante del set: responde si el programa de
-- suscripción mueve el ticket o solo mueve el conteo.
-- ============================================================================
SELECT subscription_status,
       COUNT(customer_id) AS total_customers,
       ROUND(AVG(purchase_amount),2) AS avg_spend,
       ROUND(SUM(purchase_amount),2) AS total_revenue
FROM customer_shopping
GROUP BY subscription_status
ORDER BY total_revenue,avg_spend DESC;


-- ============================================================================
-- P6. ¿Cuáles son los 5 productos con el porcentaje más alto de compras con
--     descuentos aplicados?
-- Técnica: agregación condicional (SUM de un CASE) sobre COUNT(*).
-- El 100.0 (no 100) fuerza división decimal: con enteros, SQL Server truncaría
-- el cociente a 0 antes de multiplicar.
-- Mide TASA, no volumen: responde "qué productos dependen del descuento
-- para venderse", que es una pregunta de margen, no de ventas.
-- ============================================================================
SELECT TOP 5 item_purchased,
       ROUND(100.0 * SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS discount_rate
FROM customer_shopping
GROUP BY item_purchased
ORDER BY discount_rate DESC;


-- ============================================================================
-- P7. Segmenta a los clientes en Nuevos, Recurrentes y Leales según su número
--     total de compras anteriores, y muestra el conteo de cada segmento.
-- Técnica: CTE + CASE para clasificar, luego agregar sobre la clasificación.
-- Los cortes (1 / 2-10 / >10) son una regla de negocio, no un resultado del
-- dato. El README documenta por qué esa regla discrimina poco en este dataset.
-- ============================================================================
with customer_type as (
SELECT customer_id, previous_purchases,
CASE
    WHEN previous_purchases = 1 THEN 'New'
    WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
    ELSE 'Loyal'
    END AS customer_segment
FROM customer_shopping)

select customer_segment,count(*) AS "Number of Customers"
from customer_type
group by customer_segment;


-- ============================================================================
-- P8. ¿Cuáles son los 3 productos más comprados dentro de cada categoría?
-- Técnica: función de ventana ROW_NUMBER() con PARTITION BY + CTE.
--
-- POR QUÉ ROW_NUMBER Y NO RANK / DENSE_RANK:
-- hay empates reales en los datos (Blouse = 171 y Pants = 171 en Clothing).
-- RANK y DENSE_RANK asignarían el mismo número a ambos y el filtro
-- "item_rank <= 3" devolvería 4 filas en esa categoría. ROW_NUMBER garantiza
-- exactamente 3 por categoría, que es lo que pide la pregunta de negocio.
-- El costo: ante un empate, cuál queda arriba es arbitrario.
-- ============================================================================
WITH item_counts AS (
    SELECT category,
           item_purchased,
           COUNT(customer_id) AS total_orders,
           ROW_NUMBER() OVER (PARTITION BY category ORDER BY COUNT(customer_id) DESC) AS item_rank
    FROM customer_shopping
    GROUP BY category, item_purchased
)
SELECT item_rank,category, item_purchased, total_orders
FROM item_counts
WHERE item_rank <=3;


-- ============================================================================
-- P9. ¿Es probable que los clientes que son compradores recurrentes
--     (más de 5 compras anteriores) también se suscriban?
-- Técnica: filtro + agregación.
-- Se compara contra la penetración de la base general (P5) para saber si ser
-- recurrente PREDICE suscribirse o si es independiente.
-- ============================================================================
SELECT subscription_status,
       COUNT(customer_id) AS repeat_buyers
FROM customer_shopping
WHERE previous_purchases > 5
GROUP BY subscription_status;


-- ============================================================================
-- P10. ¿Cuál es la contribución de ingresos de cada grupo de edad?
-- Técnica: agregación sobre age_group, columna derivada en Python con
-- pd.qcut(q=4) → los cuatro grupos tienen ~975 clientes cada uno.
-- Ese detalle es lo que hace interpretable el resultado: como los grupos son
-- del mismo tamaño, diferencias de ingreso = diferencias de ticket promedio.
-- ============================================================================
SELECT
    age_group,
    SUM(purchase_amount) AS total_revenue
FROM customer_shopping
GROUP BY age_group
ORDER BY total_revenue desc;
