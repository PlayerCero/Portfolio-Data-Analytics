# 📊 SQL Portfolio: Data Engineering & Business Intelligence
Este repositorio contiene una colección de proyectos y soluciones avanzadas en SQL, abarcando desde el diseño de arquitecturas relacionales hasta el análisis predictivo y descriptivo para la toma de decisiones.

## 🚀 Proyectos Incluidos

| Proyecto | Tecnologías | Enfoque Principal |
| :--- | :--- | :--- |
| **Sistema "La Tienda"** | MySQL / MariaDB | Normalización (3FN), Diseño DDL y KPIs de Ventas. |
| **Health Analytics** | PostgreSQL | Análisis estadístico de Salud Mental en estudiantes. |
| **Solucionario Académico (UDEP)** | SQL Standard | Modelado de eventos y consultas complejas (Joins/Subqueries). |

---

## 🛠️ Detalle de los Proyectos

### 1. Sistema Integrado de Gestión "La Tienda" & Almacén
**Contexto:** Diseño de una base de datos para el control de inventarios, compras y ventas, optimizando la integridad de los datos en un entorno retail.

* **Arquitectura:** Aplicación de **Tercera Forma Normal (3FN)** para eliminar redundancias, gestionando entidades multivaluadas (teléfonos de representantes).
* **Business Intelligence (KPIs):**
    * Identificación de **Top Performers** (Ranking de productividad por personal).
    * Análisis de **Demanda Crítica** (Top 5 productos con mayor rotación).
    * Auditoría de carga laboral mediante cláusulas `HAVING`.
    * Detección de inactividad operativa con **Data Mining** (subconsultas `NOT IN`).

### 2. Análisis de Salud Mental en Estudiantes Internacionales
**Contexto:** Proyecto de análisis de datos enfocado en métricas de bienestar psicológico basadas en la duración de la estancia.

* **Métricas Analizadas:** Promedios de depresión (PHQ-9), conexión social (SCS) y estrés aculturativo (ASISS).
* **Resultados:** El script procesa conjuntos de datos para encontrar correlaciones entre el tiempo de permanencia y la mejora en los indicadores de salud mental.

### 3. Diseño y Consultas Avanzadas (Casos UDEP)
**Contexto:** Resolución de casos complejos de negocio que incluyen gestión de eventos universitarios y retail de moda.

* **Modelado Relacional:** Creación de un sistema de captación de alumnos (Colegios, Facultades y Expositores).
* **Manipulación de Datos:**
    * Uso de `LEFT JOIN` para auditoría de pedidos sin boleta.
    * Análisis de **Clientes VIP** con filtrado de montos agregados (`SUM` > 10,000).
    * Operaciones de limpieza selectiva mediante lógica de filtrado por fechas y patrones de texto.

---

## 💡 Skills Técnicas Demostradas
* **DDL (Data Definition Language):** Creación de esquemas, llaves primarias/foráneas y restricciones de integridad.
* **DQL (Data Query Language):** Consultas multitable (Joins), Agregaciones (`GROUP BY`, `HAVING`) y Subconsultas.
* **Optimización:** Aplicación de lógica booleana y filtrado temporal eficiente.
* **Normalización:** Reducción de anomalías de inserción y actualización de datos.

---

## 📂 Cómo utilizar este repositorio
1. Clona el repositorio: `git clone https://github.com/TU_USUARIO/nombre-repo.git`
2. Los archivos `.sql` están listos para ser importados en cualquier entorno compatible con MySQL o PostgreSQL según corresponda.

---
**Autor:** [Eric Salinas](https://github.com/TU_USUARIO)
* Estudiante de **Ingeniería Industrial** | Universidad de Piura (UDEP)
* Interesado en Data Science, Business Intelligence y Finanzas.

