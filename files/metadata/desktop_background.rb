# Desktop background policy structure


desktop_background_js = {
  type: "object",
  title: "Desktop Background",
  title_es: "Fondo de escritorio",
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
          required: ["desktop_file"],
          properties: {
            desktop_file: {type: "string", title: "Image", title_es: "Imagen", description: "Fill with the absolute path to the image file", description_es: "Introduzca la ruta absoluta al archivo de imagen"},
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
          type: "string",
        }
    }
  }
}


desktop_background_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:required] << "desktop_background_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:properties][:desktop_background_res] = desktop_background_js

