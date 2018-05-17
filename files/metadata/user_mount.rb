# User mounts policy structure


user_mount_js = {
  title: "User mount external units",
  title_es: "Montaje de unidades externas",
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
          required: ["can_mount"],
          properties: {
            can_mount: {type: "boolean", title: "Can Mount?", title_es: "¿Puede montar?", description: "User can mount external units", description_es: "El usuario podra montar unidades externas"}, 
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


user_mount_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:required] << "user_mount_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:properties][:user_mount_res] = user_mount_js

