# Folder sharing policy structure


folder_sharing_js = {
  title: "Sharing permissions",
  title_es: "Permisos para compartir",
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
          required: ["can_share"],
          properties: {
            can_share: {title: "Can Share?", title_es: "¿Puede compartir?", description: "User can share folders", description_es: "El usuario tendrá permisos para compartir carpetas", type: "boolean"}, 
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


folder_sharing_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:required] << "folder_sharing_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:properties][:folder_sharing_res] = folder_sharing_js


