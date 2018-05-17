# Idle timeout policy structure


idle_timeout_js = {
  title: "Idle session timeout",
  title_es: "Control de inactividad de sesión",
  type: "object",
  required: ["users"],
  is_mergeable: false,
  autoreverse: false,
  form: {
      type:"section",
      items: [
        "idle_enabled",
        type:"section",
        items: [
          "idle_options.timeout",
          "idle_options.command",
          {
            key:"idle_options.notification",
            type:"textarea"
          }
        ]
     ]
  },
  properties: {
    users: {
      title: "Users",
      title_es: "Usuarios",
      type: "object",
      patternProperties: {
        ".*" => { 
          type: "object",
          title: "Username",
          title_es: "Nombre de usuario",
          required: ["idle_enabled"],
          properties: {
            idle_enabled: {
              title: "Idle session enabled?",
              title_es: "¿Control de inactividad habilitado?",
              type: "boolean",
              enum: [true,false],
              default:true
            },
            idle_options: {
              type: "object",
              title: "Idle options",
              title_es: "Opciones de configuración",
              properties: {
                timeout: {title:"Idle time", title_es: "Tiempo de inactividad", type:"integer",description:"(mins)"},
                command: {title:"Command", title_es:"Comando", type:"string"},
                notification: {title:"Notification", title_es:"Notificacion", type:"string"},
              },
            },
            updated_by: $updated_js
          },
          dependencies: {
            idle_enabled: ["idle_options"]
          },
          customFormItems: {
            idle_enabled: {
              inlinetitle: "Si activa la casilla, habilitará el control de sesión",
              toggleNext: 1
            }
          },
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


idle_timeout_js[:properties][:support_os][:default]=["GECOS Kiosk"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:required] << "idle_timeout_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:properties][:idle_timeout_res] = idle_timeout_js




