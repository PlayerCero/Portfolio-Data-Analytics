# 📊 Análisis Gerencial y Control Presupuestario (2018-2019)

---

## 🎯 Objetivo de Negocio y Alcance
Este proyecto desarrolla un **Dashboard Integral de Inteligencia de Negocios** diseñado para monitorear, controlar y analizar los KPIs financieros clave de una organización durante un periodo de dos años.

El objetivo principal es proporcionar a la alta gerencia una herramienta de toma de decisiones estratégicas que permita:
* Evaluar el cumplimiento de **metas de ingresos** y márgenes de utilidad.
* Controlar desviaciones críticas en el **presupuesto de gastos**.
* Asegurar la **liquidez mensual** mediante alertas tempranas en el flujo de caja.

---

## 📋 Resumen Ejecutivo y Vitrina Visual

> ***Takeaway Clave:*** Como se evidencia en el análisis consolidado, la organización logró un desempeño sobresaliente en rentabilidad (alcanzando un **108% de la utilidad esperada total**). Esto fue impulsado por un control efectivo de costos fijos y un sobrecumplimiento en la cuota de ingresos de segmentos clave. Sin embargo, el análisis de flujo de caja detectó alertas críticas de liquidez en periodos específicos que requieren atención operativa.

---

### 1. Vista de Resumen Gerencial ("El Pulso")
<img src="IMAGENES/1773258466503_page-0001.jpg" alt="Dashboard Principal - Resumen Gerencial" width="800">

* **Insight:** Se observa una **utilidad estelar del 133%** en el periodo filtrado, logrando $13,609 mil sobre una meta de $10,2 mil.

### 2. Vista de Alerta de Liquidez ("La Alerta")
<img src="IMAGENES/1773258466503_page-0008.jpg" alt="Alerta de Cuota Saldo Mensual" width="800">

* **Insight Crítico:** En Junio '19, el saldo actual fue de solo $82 mil sobre un esperado de $122.4 mil (**67% de cumplimiento**).

---

## 🧠 Arquitectura de Medidas DAX (Lógica de Ingeniería)

Para garantizar la precisión de los indicadores, estructuré el código en capas modulares:

### 1. Capa de Lógica de Negocio (Filtrado Dinámico)
Utilicé `CALCULATE` para segmentar los datos reales y proyectados:
```dax
Ingresos = CALCULATE(SUM(Finanzas[Cantidad]), Finanzas[Tipos] = "Ingresos")
Gastos = CALCULATE(SUM(Finanzas[Cantidad]), Finanzas[Tipos] = "Gastos")
Meta = CALCULATE(SUM(Expectativas[Cantidad]), Expectativas[Tipo] = "Metas")
