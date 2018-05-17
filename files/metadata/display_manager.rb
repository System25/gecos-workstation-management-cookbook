# Display manager policy structure


display_manager_js = {
  title: "Display Manager",
  title_es: "Gestor de inicio de sesión",
  type: "object",
  is_mergeable: false,
  autoreversible: false,
  properties:
  {
    dm: {
      type: "string",
      title: "Select a Display Manager",
      title_es: "Seleccione un Display Manager",
      enum: ["MDM", "LightDM"],
      description: "Autologin timeout in MDM can not be less than 5 seconds. For a kiosk workstation LightDM is recommended because it has got no minimum timeout",
      description_es: "MDM tiene un tiempo de espera de login automático no inferior a 5 segundos. Para un kiosco se recomienda LightDM al no tener tiempo de espera mínimo"
    },
    autologin: {
      type:"boolean",
      title: "Check this box to enable automatic login",
      title_es: "Si activa la casilla, habilitará el login automático"
    },
    autologin_options: {
        type: "object",
        required: ["username","timeout"],
        properties: {
           username: {
             title: "Username",
             title_es: "Usuario",
             type: "string",
             default: ""
           },
           timeout: {
             title: "Autologin user timeout ",
             title_es: "Timeout de autologin",
             type: "integer",
             default: 15
           }
        }
    },
    support_os: $support_os_js.clone,
    updated_by: $updated_js
  },
  dependencies: {
    autologin: ["autologin_options"]
  },
  customFormItems: {
    autologin: {
      inlinetitle: "Si activa la casilla, habilitará el login automático",
      toggleNext: 1
    }
  }
}

display_manager_js[:properties][:support_os][:default]=["GECOS Kiosk"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:software_mgmt][:required] << "display_manager_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:software_mgmt][:properties][:display_manager_res] = display_manager_js


