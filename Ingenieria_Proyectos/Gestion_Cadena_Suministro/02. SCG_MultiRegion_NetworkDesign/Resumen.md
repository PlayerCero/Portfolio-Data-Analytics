# MultiNet Global: Diseño de Red Logística Multi-Regional 🌍🚛

## 📋 Problemática de Negocio
Configuración estratégica de una red de suministro distribuida en 5 regiones (Calopeia, Sorange, Tyran, Entworpe y Fardo). El proyecto enfrentó una estructura de costos compleja con un **CAPEX de $500,000** por construcción de fábrica y altos costos variables de transporte internacional. El reto central fue resolver el *Trade-off* entre **centralizar la producción** (economías de escala) o **descentralizarla** (proximidad al cliente).

## 🛠️ Metodología y Simulación
* **Evaluación de Escenarios de Red**: Análisis de rentabilidad comparando configuraciones de **1, 2 y 3 fábricas**. Se utilizaron proyecciones de demanda anuales (Calopeia: ~25,600; Sorange: ~51,000) para justificar la inversión en infraestructura.
* **Cálculo de Costos Ponderados**: Implementación de modelos de costos variables ponderados para determinar la rentabilidad real de los envíos interregionales desde el centro de producción principal en Sorange.
* **Análisis de Sensibilidad**: Evaluación de márgenes netos frente a variaciones en los costos de fletes y tarifas de correo internacional.

## 🚀 Solución Aplicada: Red Logística Flexible
* **Estrategia de Hubs Regionales**: Se seleccionaron **Calopeia y Sorange** como nodos principales de fabricación para maximizar el margen de utilidad en los mercados de mayor volumen.
* **Agilidad sobre Volumen (Lean Logistics)**: Para regiones con demanda volátil o distantes (Tyran y Fardo), se evitó el gasto fijo de construcción. En su lugar, se implementó una política de **reposición bajo demanda (Pull)** mediante envío por Correo, eliminando el efectivo inmovilizado en almacenes regionales ineficientes.

## 📈 Impacto y Resultados
* **Optimización del Beneficio Neto**: La estrategia del grupo  priorizó la rentabilidad total sobre el nivel de servicio absoluto, logrando el mayor balance de efectivo posible mediante la reducción de costos fijos innecesarios.
* **Mitigación de Riesgo Financiero**: Estructura de costos flexible que permitió a la empresa adaptarse a cambios bruscos en la demanda regional sin comprometer la liquidez.

---
*Simulación avanzada desarrollada con Supply Chain Game - Multi Region (UDEP).*
