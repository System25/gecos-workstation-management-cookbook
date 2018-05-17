# Local admin users policy structure




local_admin_users_js = {
  title: "Local Administrators",
  title_es: "Administradores locales",
  type: "object",
  required: ["local_admin_list"],
  order: ["local_admin_list"],
  is_mergeable: true,
  autoreverse: false,
  properties:
   
  {local_admin_list: {
      type:"array",
      title: "users",
      title_es: "Usuarios", 
      description: "Enter a local user to grant administrator rights",
      description_es: "Escriba un usuario local para concederle permisos de administrador",
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


local_admin_users_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:required] << "local_admin_users_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:properties][:local_admin_users_res] = local_admin_users_js
