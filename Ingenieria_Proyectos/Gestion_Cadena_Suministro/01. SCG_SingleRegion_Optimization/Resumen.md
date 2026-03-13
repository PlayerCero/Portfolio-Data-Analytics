# OptiChain Tactical: Optimización de Suministro en Región Única 🏭📦

## 📋 Problemática de Negocio
Gestión de una cadena de suministro con **demanda altamente estacional**, presentando picos críticos en los trimestres 2 y 3. El desafío principal consistió en operar una fábrica con capacidad limitada, donde el riesgo de quiebre de stock (*stockout*) en temporada alta debía equilibrarse con la necesidad de no inmovilizar excesivo efectivo en temporadas de baja demanda (T1 y T4).

## 🛠️ Metodología y Cálculos Aplicados
* **Modelado de Inventario Dinámico**: Implementación de modelos **EOQ** (Cantidad Económica de Pedido) y **ROP** (Punto de Reorden) calculados de forma trimestral para adaptarse a la varianza de la demanda estacional.
* **Análisis Crítico de Lead Time**: Evaluación comparativa de tiempos de entrega: **7 días (Camión)** frente a **1 día (Correo)**. Se determinó que la reducción del tiempo de transporte permite una compresión drástica del inventario de seguridad (*Safety Stock*).
* **Cálculo de Capacidad**: Análisis de balanceo de línea para determinar el nivel óptimo de producción diaria para satisfacer los pedidos acumulados.

## 🚀 Solución Implementada: Estrategia de Anticipación
* **Colchón de Inventario (Buffer)**: Durante la temporada baja, se programó la producción para saturar el almacén hasta un máximo histórico de **3,575 bidones** (alcanzado en el día 1167). Esta reserva permitió absorber la demanda del T2 y T3 sin exceder la capacidad de planta.
* **Logística Híbrida**: Se estableció el **Camión** como medio de abastecimiento base por su bajo costo unitario, reservando el **Correo** como herramienta de respuesta ágil para cubrir brechas de stock inesperadas o pedidos prioritarios.

## 📈 Impacto y Resultados
* **Maximización de Cash Flow**: Se optimizó el balance de efectivo final al minimizar el costo de oportunidad por ventas perdidas y reducir los costos de mantenimiento de inventario excesivo.
* **Resiliencia Operativa**: Se mantuvo el nivel de servicio deseado incluso durante el periodo de cierre anual de fábrica mediante una planificación de stock previa.

---
*Simulación desarrollada con el software Supply Chain Game (UDEP).*
