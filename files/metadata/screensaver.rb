# Screen saver policy structure


screensaver_js = {
  title: "Screensaver",
  title_es: "Salvapantallas",
  type: "object",
  required: ["users"],
  is_mergeable: false,
  autoreverse: false,
  properties: {
    users: {
      title: "Users",
      title_es: "Usuarios",
      type: "object",
      patternProperties: {
        ".*" => { type: "object", title: "Username", title_es: "Nombre de usuario",
          required: ["idle_enabled", "lock_enabled"],
          order: ["lock_enabled", "lock_delay", "idle_enabled", "idle_delay"],
          properties: {
            idle_enabled: {
              type: "boolean",
              title: "Dim screen",
              title_es: "Oscurecer pantalla"
            },
            idle_delay: {
              type: "string",
              description: "Time to dim screen in seconds",
              description_es: "Tiempo hasta el oscurecimiento en segundos",
              title: "Idle delay",
              title_es: "Retraso de inactividad"              
            },
            lock_enabled: {
              type: "boolean",
              title: "Allow screen lock",
              title_es: "Permitir bloqueo de pantalla"
            },
            lock_delay: {
              type: "string",
              description: "Time to lock the screen in seconds",
              description_es: " Tiempo hasta el bloqueo de la pantalla en segundos",
              title: "Time to lock",
              title_es: "Tiempo hasta el bloqueo"              
            }, 
            updated_by: $updated_js
          }
        }
      }
    },
    support_os: $support_os_js.clone,
    job_ids: {
      type: "array",
      minItems: 0,
      uniqueItems: true,
      items: {
        type: "string"
      }
    }
  }
}



screensaver_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:required] << "screensaver_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:properties][:screensaver_res] = screensaver_js




