FROM odoo:18.0

USER root

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    postgresql-client \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Crear directorios necesarios
RUN mkdir -p /etc/odoo \
    && mkdir -p /mnt/extra-addons \
    && mkdir -p /var/lib/odoo

# Copiar archivos de configuración
COPY ./config/odoo.conf /etc/odoo/
COPY ./set_odoo_conf.sh /usr/local/bin/
COPY ./addons /mnt/extra-addons/

# Dar permisos de ejecución y propiedad
RUN chmod +x /usr/local/bin/set_odoo_conf.sh \
    && chown -R odoo:odoo /etc/odoo \
    && chown -R odoo:odoo /mnt/extra-addons \
    && chown -R odoo:odoo /var/lib/odoo \
    && chmod 774 /etc/odoo/odoo.conf

# Cambiar al usuario odoo para mayor seguridad
USER odoo

# Exponer puertos
EXPOSE 8069 8072

ENTRYPOINT ["bash", "/usr/local/bin/set_odoo_conf.sh"]
CMD ["odoo"]