# 📦 Gestión de la Cadena de Suministro

Dos simulaciones sobre **Supply Chain Game (UDEP)**, donde cada decisión de inventario, capacidad y transporte se paga en el balance de efectivo final.

| Proyecto | Reto | Documentación |
| :--- | :--- | :--- |
| **[01 · Optimización en región única](01.%20SCG_SingleRegion_Optimization)** | Demanda estacional con picos en T2 y T3 y una fábrica de capacidad limitada: equilibrar el riesgo de quiebre de stock contra el efectivo inmovilizado | **[Resumen](01.%20SCG_SingleRegion_Optimization/Resumen.md)** · informe y hoja de cálculo |
| **[02 · Diseño de red multi-regional](02.%20SCG_MultiRegion_NetworkDesign)** | Cinco regiones y un CAPEX de **$500,000** por fábrica: centralizar para ganar escala o descentralizar para acercarse al cliente | **[Resumen](02.%20SCG_MultiRegion_NetworkDesign/Resumen.md)** · informe y cálculos |

---

### Decisiones que vale la pena mirar

- **Región única:** se usó la temporada baja para construir un colchón de hasta **3,575 bidones**, con el camión como transporte base (barato, 7 días) y el correo (1 día) reservado para cerrar brechas imprevistas. Comprimir el *lead time* comprime el inventario de seguridad.
- **Multi-región:** en lugar de construir en las cinco regiones, se fabricó solo en **Calopeia y Sorange** —las de mayor volumen— y se abasteció a Tyran y Fardo por correo bajo demanda. Se cambió gasto fijo por flexibilidad, priorizando el beneficio neto sobre el nivel de servicio absoluto.

---
*Modelos: EOQ, ROP, análisis de lead time, evaluación de escenarios de red y análisis de sensibilidad.*
