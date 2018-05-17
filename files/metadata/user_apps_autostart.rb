# Auto start applications policy structure


user_apps_autostart_js = {
  title: "Applications that will run at the start of the system",
  title_es: "Aplicaciones que se ejecutarán al inicio",
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
        order: ["desktops", "desktops_to_remove"],        
          properties: {
              desktops: {
                title: "Applications",
                title_es: "Aplicaciones",
                description: ".desktop file must exist in /usr/share/applications",
                description_es: "Es necesario que exista el .desktop en /usr/share/applications",
                type: "array",
                minItems: 0,
                uniqueItems: true,
                items: {type: "string"}
                               
                                             
                                          
                                       
                                           
                             
              },
              desktops_to_remove: {
                title: "Applications to remove from autostart",
                title_es: "Aplicaciones a eliminar del inicio",
                description: "Applications will not be run at session start anymore",
                description_es: "Las aplicaciones ya no se ejecutarán al inicio de sesión",
                type: "array",
                minItems: 0,
                uniqueItems: true,
                items: {type: "string"}
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


user_apps_autostart_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:required] << "user_apps_autostart_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:properties][:user_apps_autostart_res] = user_apps_autostart_js





