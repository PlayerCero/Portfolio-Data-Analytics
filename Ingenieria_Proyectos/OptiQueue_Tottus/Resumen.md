# OptiQueue: Optimización del Sistema de Colas en Buffet Tottus 🛒🥗

## 📋 Resumen del Proyecto
Este proyecto analiza el sistema de servicio "Buffet al Peso" de la cadena de supermercados **Tottus S.A.** El objetivo principal fue evaluar el desempeño actual de las estaciones de servicio (Begonias y San Isidro) y proponer una configuración óptima de servidores para minimizar los tiempos de espera y maximizar la rentabilidad operativa.

## 🎯 Retos y Análisis Realizado
* **Toma de Datos en Campo**: Recolección de tiempos de llegada y tiempos de servicio durante horas pico.
* **Validación Estadística**: Aplicación de pruebas de **Bondad de Ajuste (Chi-Cuadrado)** para determinar las distribuciones de probabilidad (Poisson para llegadas y Exponencial para servicios).
* **Modelado Matemático**: Evaluación del sistema mediante modelos de colas **M/M/s**.
* **Impacto Económico**: Cálculo de pérdidas por tiempo de espera y análisis de rentabilidad mensual (aprox. S/ 300,000 mensuales sin mermas).

## 🏗️ Metodología de Optimización
Se evaluaron dos escenarios críticos:
1.  **Estado Actual (4 servidores)**: Identificación de cuellos de botella y probabilidad de espera excesiva.
2.  **Estado Propuesto (5 servidores)**: Simulación de mejora donde se logró reducir significativamente el tiempo en cola y mejorar la tasa de utilización de los empleados.

## 🛠️ Herramientas Utilizadas
* **Modelado Probabilístico**: Teoría de Colas (Little's Law, Erlang-C).
* **Análisis Estadístico**: Pruebas de hipótesis y ajuste de distribuciones en Excel/CSV.
* **Gestión de Datos**: Procesamiento de boletas y tiempos reales de operación.

## 🎓 Conclusiones de Negocio
La investigación determinó que aumentar un servidor adicional en horas críticas no solo mejora la experiencia del cliente, sino que optimiza el flujo de caja al reducir la tasa de abandono y mejorar la rotación de mesas en el área de comida.

---
*Proyecto desarrollado para la asignatura: Modelización Probabilística para la Investigación de Operaciones (UDEP).*
