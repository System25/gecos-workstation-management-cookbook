# Firefox configuration policy structure


appconfig_firefox_js = {
  title: "Firefox Config",
  title_es: "Configuración de Firefox",
  type: "object",
  required: ["config_firefox"],
  is_mergeable: false,
  autoreverse: false,
  properties: {
    config_firefox: {
      title: "Firefox Configuration",
      title_es: "Configuración de Firefox",
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


appconfig_firefox_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:software_mgmt][:required] << "appconfig_firefox_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:software_mgmt][:properties][:appconfig_firefox_res] = appconfig_firefox_js


