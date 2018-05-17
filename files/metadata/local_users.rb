# Local users policy structure


local_users_js = {
  title: "Users",
  title_es: "Usuarios",
  type: "object",
  required: ["users_list"],
  is_mergeable: true,
  autoreverse: false,
  properties:
  {users_list: {
      type:"array",
      title: "User list to manage",
      title_es: "Lista de usuarios para gestionar",
      items: {
        type:"object",
        required: ["user","actiontorun"],
        order:["actiontorun", "user", "password", "name"],
        mergeIdField: ['user'],
        mergeActionField: 'actiontorun',
        additionalProperties: false,
        properties:{
          actiontorun: {enum: ["add","remove"],type: "string", title: "Action", title_es: "Acción"},
          user: { title: "User", title_es: "Usuario", type: "string" },
          name: { title: "Full Name", title_es: "Nombre Completo", type: "string" },
          password: { title: "Password", title_es: "Contraseña", type: "string"}
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


local_users_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:required] << "local_users_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:properties][:local_users_res] = local_users_js

