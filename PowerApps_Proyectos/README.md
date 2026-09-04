# ⚡ Power Apps & Power Automate

### **Eric Salinas Cajaleón** | Ingeniería Industrial y de Sistemas — **Universidad de Piura (UDEP)**

`Power Apps (Canvas)` · `Power Fx` · `Power Automate` · `SharePoint Online` · `Microsoft Forms` · `Outlook 365`

> Aplicaciones internas de bajo código sobre Microsoft Power Platform: captura de datos en
> Power Apps, almacenamiento en listas de SharePoint y automatización de lo repetitivo en
> Power Automate.

[⬅️ Volver al portafolio principal](../README.md)

---

## Proyectos

### 1️⃣ CRM de Ventas sobre SharePoint

<a href="CRM_Ventas_PowerApps">
<img src="CRM_Ventas_PowerApps/IMAGENES/02-app-registrar-venta.jpg" width="100%">
</a>

Aplicación canvas de **8 pantallas** (registro y consulta de contactos, productos, empleados y
ventas) sobre **5 listas de SharePoint**, más **4 flujos de Power Automate** con cuatro
disparadores distintos: creación de elemento, llamada desde la propia app, respuesta de
Microsoft Forms y ejecución programada.

| Qué demuestra | Cómo |
| :--- | :--- |
| Modelo relacional real, no una hoja plana | `Ventas` guarda **IDs** de contacto, producto y empleado; la galería los resuelve con `LookUp` |
| Cálculo derivado en lugar de captura manual | El precio total sale de `Value(txtCantidad.Text) * CbProducto.Selected.Precio` |
| Patrón de guardado consistente | `Patch` → `Notify` → `Reset` → `Navigate`, idéntico en las cuatro pantallas de registro |
| Automatización auditable | Los flujos de correo terminan en **Actualizar elemento**, dejando la bitácora dentro del propio registro de SharePoint |

📁 **[Ver el caso completo: modelo de datos, fórmulas Power Fx, los 4 flujos y 21 capturas →](CRM_Ventas_PowerApps)**

---

## 🎓 Formación asociada

| Certificación | Entidad | Fecha |
| :--- | :--- | :--- |
| **Microsoft Power Apps y Power Automate** | Datux Perú · Microsoft Partner Network | Agosto 2026 |

---

<div align="center">

[⬅️ Volver al portafolio principal](../README.md)

</div>
