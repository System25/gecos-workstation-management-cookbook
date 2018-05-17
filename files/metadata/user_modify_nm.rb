# Network permissions policy structure



user_modify_nm_js = {
  title: "Give network privileges to user",
  title_es: "Conceder permisos de red al usuario",
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
          required: ["can_modify"],
          properties: {
            can_modify: {
              title: "Can modify network?",
              title_es: "¿Permisos para modificar la red?",
              type: "boolean",
              enum: [true,false],
              default:true
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


user_modify_nm_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:required] << "user_modify_nm_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:properties][:user_modify_nm_res] = user_modify_nm_js


