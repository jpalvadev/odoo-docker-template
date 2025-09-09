#!/bin/bash
set -e

CONF_FILE="/etc/odoo/odoo.conf"

add_or_replace() {
    local key="$1"
    local value="$2"

    if grep -q "^[[:space:]]*$key[[:space:]]*=" "$CONF_FILE"; then
        sed -i "s|^[[:space:]]*$key[[:space:]]*=.*|$key = $value|" "$CONF_FILE"
    else
        echo "" >> "$CONF_FILE"
        echo "$key = $value" >> "$CONF_FILE"
    fi
}

[ -n "$DB_HOST" ]        && add_or_replace "db_host" "$DB_HOST"
[ -n "$DB_USER" ]        && add_or_replace "db_user" "$DB_USER"
[ -n "$DB_PASSWORD" ]    && add_or_replace "db_password" "$DB_PASSWORD"
[ -n "$DB_NAME" ]        && add_or_replace "db_name" "$DB_NAME"
[ -n "$ADMIN_PASSWORD" ] && add_or_replace "admin_passwd" "$ADMIN_PASSWORD"

exec "$@"