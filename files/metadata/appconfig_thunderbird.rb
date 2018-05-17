# Thunderbird application config policy structure


appconfig_thunderbird_js = {
  title: "Thunderbird Config",
  title_es: "Configuración de Thunderbird",
  type: "object",
  required: ["config_thunderbird"],
  is_mergeable: false,
  autoreverse: false,
  properties: {
    config_thunderbird: {
      title: "Thunderbird Configuration",
      title_es: "Configuración de Thunderbird",
      type: "object",
      properties: {
        app_update: {
          title: "Enable/Disable auto update",
          title_es: "Activar/Desactivar actualizaciones automáticas",
          type: "boolean",
          enum: [true,false],
          default: false
        }
      }
    },
    job_ids: {
        type: "array",
        minItems: 0,
        uniqueItems: true,
        items: {
          type: "string"
        }
    }, 
    support_os: $support_os_js.clone,
    updated_by: $updated_js
  }
}

appconfig_thunderbird_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:software_mgmt][:required] << "appconfig_thunderbird_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:software_mgmt][:properties][:appconfig_thunderbird_res] = appconfig_thunderbird_js

