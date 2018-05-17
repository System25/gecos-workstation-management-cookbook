# Local groups policy structure


local_groups_js = {
  title: "Local groups",
  title_es: "Grupos locales",
  type: "object",
  required: ["groups_list"],
  is_mergeable: true,
  autoreverse: false,
  properties:
  {groups_list: {
      type:"array",
      title: "Group to manage",
      title_es: "Grupos para gestionar",
      uniqueItems: true,
      items: {
        type:"object",
        required: ["group","user","action"],
        order:["group", "user", "action"],
        mergeIdField: ["group", "user"],
        mergeActionField: "action",
        additionalProperties: false,
        properties:{
          group: { type: "string", title: "Group", title_es: "Grupo" },
          user: { type: "string",title: "User", title_es: "Usuario" },
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


local_groups_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:required] << "local_groups_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:properties][:local_groups_res] = local_groups_js


