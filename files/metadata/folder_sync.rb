# Folder sync policy structure


folder_sync_js = {
  title: "Folder to sync",
  title_es: "Carpeta para sincronizar",
  type: "object",
  required: ["users"],
  is_mergeable: false,
  autoreverse: false,
  properties:
  {users: {
    title: "Users", 
    title_es: "Usuarios",
    type: "object",
    patternProperties: {
      ".*" => { type: "object", title: "Username", title_es: "Nombre de usuario",
        properties: {
          owncloud_url: {title: "Owncloud URL", title_es: "URL de Owncloud", type: "string"},
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

folder_sync_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:required] << "folder_sync_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:properties][:folder_sync_res] = folder_sync_js
