# Configuración de Supabase

El proyecto de Supabase usado para Fragancias LiMar ya contiene el catálogo y los pedidos existentes.

## Tablas principales

- `products`: catálogo, precio, stock y visibilidad.
- `orders`: datos del cliente, total, estado y pago contra entrega.
- `order_items`: detalle de cada pedido.

## Seguridad

El catálogo activo puede consultarse públicamente. Los pedidos nuevos aceptan únicamente `contra_entrega`. Las operaciones privadas de administración deben ejecutarse con autenticación de Supabase; nunca se debe exponer una clave secreta en el navegador.

## Migración

La estructura está documentada en `schema.sql`. Antes de publicar cambios, probar en un entorno separado y verificar las políticas RLS.
