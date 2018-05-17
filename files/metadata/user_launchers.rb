# User launchers policy structure


user_launchers_js = {
  title: "User Launchers",
  title_es: "Acceso directo en el escritorio",
  type: "object",
  required: ["users"],
  is_mergeable: true,
  autoreverse: false,
  properties: {
    users: {
      title: "Users",
      title_es: "Usuarios",
      type: "object",
      patternProperties: {
        ".*" => { type: "object", title: "Username", title_es: "Nombre de usuario",
          required: ["launchers"],
          properties: {
            launchers: {
              type: "array",
              title: "Shortcut",
              title_es: "Acceso directo",
              description: "Enter the name of a .desktop file describing the application", 
              description_es: "Introduzca el nombre del fichero .desktop que describe la aplicación",
              minItems: 0,
              uniqueItems: true,
              items: {
                type: "object",
                required: ["name", "action"],
                order: ["name", "action"],
                mergeIdField: ["name"],
                mergeActionField: "action",
                properties: {
                  name: {title: "Name", title_es: "Nombre", type: "string"},
                  action: {title: "Action", title_es: "Acción", type: "string", enum: ["add", "remove"]}
                }
              }
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


user_launchers_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:required] << "user_launchers_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:properties][:user_launchers_res] = user_launchers_js


