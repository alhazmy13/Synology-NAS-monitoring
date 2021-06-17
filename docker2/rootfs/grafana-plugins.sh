#!/bin/bash

grafana_install_plugin_command="/usr/sbin/grafana-cli"
grafana_install_plugin_args=("--pluginsDir" "/var/lib/grafana/plugins" "plugins" "install")
grafana_plugin_list=(
  "grafana-image-renderer"
  "andig-darksky-datasource"
)

for plugin in "${grafana_plugin_list[@]}"; do
  echo Installing "$plugin"
  "${grafana_install_plugin_command[@]}" "${grafana_install_plugin_args[@]}" "${plugin}"
done

chmod g+rwX /var/lib/grafana/plugins
