# IoT-ClimateGuard: Monitoreo Inteligente para la Conservación de Activos Críticos 🎹🌡️

## 📋 Problemática Institucional
El **Clavecín de la Universidad de Piura (UDEP)**, un instrumento de alto valor histórico y artístico, presentaba daños estructurales (grietas y desajustes en las cuerdas) debido a las fluctuaciones extremas de temperatura y humedad en el aula "Olaya 03". El sistema de mitigación anterior falló, poniendo en riesgo la integridad del instrumento al no contar con un monitoreo preciso y automatizado que alertara sobre condiciones ambientales fuera de los rangos de seguridad.

## 🛠️ Metodología e Ingeniería Aplicada
Se diseñó un sistema de **Internet de las Cosas (IoT)** enfocado en la telemetría ambiental de alta precisión, utilizando:

* **Arquitectura IoT**: Implementación de un nodo sensor basado en el microcontrolador **ESP32**, seleccionado por su capacidad de procesamiento dual-core y conectividad Wi-Fi integrada.
* **Sensores de Alta Precisión**: Uso de sensores **DHT22** estratégicamente ubicados para capturar datos de temperatura (-40°C a +80°C) y humedad (0-100% RH) con resoluciones de 0.1, permitiendo un mapeo térmico del entorno del instrumento.
* **Análisis de Microclima**: Estudio estadístico de los datos para identificar el impacto de la apertura de puertas y el flujo de aire en la estabilidad higrotérmica del aula.



## 🚀 Solución Implementada: Optimización de Microclima
La solución no solo se limitó al monitoreo, sino a la creación de un sistema de soporte de ingeniería para la preservación:

* **Monitoreo Multinodo**: Despliegue de sensores en puntos críticos (cerca del instrumento, áreas de puertas y zonas alejadas) para detectar gradientes térmicos que causan la expansión/contracción de la madera.
* **Integración de Datos**: Configuración de un bus de datos digital de un solo cable (One-Wire) para centralizar la información en tiempo real, permitiendo futuras integraciones con sistemas de climatización automatizados.
* **Gestión de Activos**: Creación de una ficha técnica de control que define los límites operativos seguros para el mantenimiento preventivo del clavecín.



## 📈 Impacto y Resultados
* **Preservación Patrimonial**: Mitigación del deterioro físico del clavecín, evitando reparaciones costosas y la pérdida de valor institucional.
* **Gestión Científica del Campus**: Transformación de la gestión de ambientes de la universidad hacia un modelo basado en datos reales, no en suposiciones.
* **Escalabilidad**: El prototipo diseñado es replicable para la protección de otros activos sensibles en laboratorios o bibliotecas de la universidad.

---
*Proyecto desarrollado para la asignatura: Electrotecnia Aplicada y Automatización (UDEP).*
