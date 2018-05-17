# User shared folders policy structure


user_shared_folders_js = {
  title: "Shared Folders",
  title_es: "Carpetas Compartidas",
  type: "object",
  required: ["users"],
  is_mergeable: false,
  autoreverse: true,
  properties: {
    users: {
      title: "Users",
      title_es: "Usuarios",
      type: "object",
      patternProperties: {
        ".*" => { type: "object", title: "Username", title_es: "Nombre de usuario",
          required: ["gtkbookmarks"],
          properties: {
            gtkbookmarks: {
              type: "array",
              title: "Bookmarks",
              title_es: "Marcadores", 
              minItems: 0,
              uniqueItems: true,
              items: {
                type: "object",
                required: ["name", "uri"],
                properties: {
                  name: {title: "Name", title_es: "Nombre", type: "string"},
                  uri: {title: "Uri", title_es: "Uri", type: "string"}
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


user_shared_folders_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2"]


$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:required] << "user_shared_folders_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:properties][:user_shared_folders_res] = user_shared_folders_js




