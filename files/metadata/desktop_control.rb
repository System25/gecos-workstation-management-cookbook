# Desktop control policy structure


desktop_control_js = {
  title: "Control panel",
  title_es: "Panel de control",
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
          required: ["desktop_files"],
          properties: {
            desktop_files: {
              type: "array",
              title: "Categories",
              title_es: "Categorias",
              description: "Deletes the control panel category",
              description_es: "Elimina la categoría del panel de control",
              minItems: 0,
              uniqueItems: true,
              items: {
                type: "string"
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

desktop_control_js[:properties][:support_os][:default]=[]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:required] << "desktop_control_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:properties][:desktop_control_res] = desktop_control_js


