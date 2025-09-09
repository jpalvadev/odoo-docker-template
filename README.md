# Odoo Docker Setup

Configuración de Odoo 18.0 con PostgreSQL 15 usando Docker.

## Requisitos Previos

-   Docker Desktop
-   Docker Compose v2

## Estructura del Proyecto

```
odoo_docker/
├── .env                 # Variables de entorno
├── docker-compose.yaml  # Configuración de Docker
├── addons/             # Módulos personalizados
└── config/
    └── odoo.conf       # Configuración de Odoo
```

## Variables de Entorno

El archivo `.env` contiene la siguiente configuración:

### Odoo Web

-   `WEB_HOST`: Nombre del contenedor
-   `WEB_IMAGE_NAME`: Imagen de Odoo
-   `WEB_PORT`: Puerto para la interfaz web
-   `WEBSOCKET_PORT`: Puerto para websocket
-   `ADMIN_PASSWORD`: Contraseña maestra

### PostgreSQL

-   `DB_IMAGE`: Versión de PostgreSQL
-   `DB_HOST`: Nombre del contenedor DB
-   `DB_PORT`: Puerto de PostgreSQL
-   `DB_NAME`: Nombre de la base de datos
-   `DB_USER`: Usuario de PostgreSQL
-   `DB_PASSWORD`: Contraseña de PostgreSQL

## Instalación

1. Clona el repositorio:

```bash
git clone <url-repositorio>
cd odoo_docker
```

2. Agrega las variables al archivo las variables en el archivo `.env.template` y renombralo a `.env`

3. Crear en el root la carpeta `addons`

4. Inicia los contenedores:

```bash
docker-compose up -d
```

## Acceso a Odoo

-   **URL**: http://localhost:${WEB_PORT}
-   **Base de datos**: ${DB_NAME}
-   **Usuario**: admin
-   **Contraseña Maestra**: ${ADMIN_PASSWORD}

## Comandos Útiles

### Gestión de Contenedores

```bash
# Iniciar contenedores
docker-compose up -d

# Detener contenedores
docker-compose down

# Ver logs
docker-compose logs -f

# Reiniciar contenedores específicos
docker-compose restart ${WEB_HOST}
docker-compose restart ${DB_HOST}
```

### Backup y Restauración

```bash
# Backup de la base de datos
docker exec ${DB_HOST} pg_dump -U ${DB_USER} ${DB_NAME} > backup.sql

# Restaurar base de datos
docker exec -i ${DB_HOST} psql -U ${DB_USER} ${DB_NAME} < backup.sql
```

## Desarrollo de Módulos

1. Coloca tus módulos personalizados en la carpeta `addons/`
2. Los módulos se cargarán automáticamente en Odoo
3. Actualiza la lista de aplicaciones en Odoo:
    - Modo desarrollador > Actualizar lista de aplicaciones

## Volúmenes Persistentes

-   `odoo-web-data`: Almacena archivos de Odoo
-   `odoo-db-data`: Almacena datos de PostgreSQL

## Solución de Problemas

1. **Error de permisos en addons**:

```bash
chmod -R 777 addons/
```

2. **Error de conexión a la base de datos**:
    - Verifica que los contenedores estén corriendo
    - Comprueba las credenciales en `.env`
    - Revisa los logs con `docker-compose logs -f`

## Notas de Seguridad

-   Cambia las contraseñas predeterminadas en el archivo `.env`
-   Considera usar Docker Secrets para producción
-   Limita el acceso a los puertos expuestos según necesidad

## Mantenimiento

-   Realiza backups regulares de la base de datos
-   Mantén actualizadas las imágenes de Docker
-   Revisa los logs periódicamente
