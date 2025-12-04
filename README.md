# Sistema de Gestión de Biblioteca (BiblioTech) 

## Descripción
Sistema de base de datos para el control de inventario y préstamos de libros. A diferencia de sistemas transaccionales simples, este proyecto se enfoca en el manejo de **estados temporales** (préstamos activos vs. finalizados).

## Habilidades Técnicas Demostradas
* **Lógica de Fechas:** Uso de funciones como `DATEDIFF` y `GETDATE` para calcular vencimientos.
* **Manejo de NULLs:** Filtrado de datos basado en valores nulos para determinar el estado de un activo.
* **Integridad Referencial:** Relaciones entre Autores, Libros y Socios.
* **Automatización:** Stored Procedure para registrar devoluciones en tiempo real.
