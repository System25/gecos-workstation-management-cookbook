# Desktop menu policy structure


desktop_menu_js = {
  title: "Application Menu",
  title_es: "Menú de aplicaciones",
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
          required: ["desktop_files_include", "desktop_files_exclude"],
          properties: {
            desktop_files_include: {
              type: "array",
              title: "Add application menu",
              title_es: "Añadir aplicación al menú",
              minItems: 0,
              uniqueItems: true,
              items: {
                type: "string"
              }
            },
            desktop_files_exclude: {
              type: "array",
              title: "Remove application menu",
              title_es: "Quitar aplicación del menú",
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


desktop_menu_js[:properties][:support_os][:default]=[]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:required] << "desktop_menu_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:properties][:desktop_menu_res] = desktop_menu_js



