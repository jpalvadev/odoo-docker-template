FROM odoo:18.0

USER root

# Instalar dependencias adicionales
RUN apt-get update && apt-get install -y \
    postgresql-client \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Copiar archivos de configuración
COPY ./config/odoo.conf /etc/odoo/
COPY ./set_odoo_conf.sh /usr/local/bin/
COPY ./addons /mnt/extra-addons/

# Dar permisos de ejecución al script
RUN chmod +x /usr/local/bin/set_odoo_conf.sh

# Establecer permisos correctos
RUN chown -R odoo:odoo /etc/odoo/odoo.conf \
    && chown -R odoo:odoo /mnt/extra-addons \
    && chown -R odoo:odoo /var/lib/odoo

USER odoo

# Puerto web y websocket
EXPOSE 8069 8072

ENTRYPOINT ["bash", "/usr/local/bin/set_odoo_conf.sh", "/usr/bin/odoo", "-c", "/etc/odoo/odoo.conf"]