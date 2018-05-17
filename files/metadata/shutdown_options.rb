# Shudown options policy structure


shutdown_options_js = {
  title: "Shutdown Options",
  title_es: "Opciones de apagado",
  type: "object",
  required: ["users"],
  is_mergeable: false,
  autoreverse: false,
  properties: { 
    systemlock: { type: "boolean", title: "System-wide lockdown of the key", title_es: "Bloqueo para todo el sistema de la llave"},
    users: {
      type: "object", 
      title: "Users",
      title_es: "Usuarios",
      patternProperties: {
        ".*" => { type: "object", title: "Username", title_es: "Nombre de usuario",
          required: ["disable_log_out"],
          properties:{
            disable_log_out: {
              title: "Disable log out?",
              title_es: "¿Desactivar apagado?",
              description: "Checking the box will not allow the computer turns off",
              description_es: "Si activa la casilla no permitira el apagado del equipo",
              type: "boolean",
              default: false
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

shutdown_options_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:required] << "shutdown_options_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:properties][:shutdown_options_res] = shutdown_options_js
