# Mime types policy structure


mimetypes_js = {
  title: "Default aplications per (MIME) type",
  title_es: "Aplicaciones preferidas por tipo (MIME)",
  type: "object",
  is_mergeable: false,
  autoreverse: false,
  properties: {
    users: {
      type: "object",
      title: "Users",
      title_es: "Usuarios",
      patternProperties: {
        ".*" => {
          type: "object",
          title: "Username",
          title_es: "Nombre de usuario",
          properties: {
            mimetyperelationship: {
              type: "array",
              items: {
                type: "object",
                required: ["desktop_entry","mimetypes"],
                order: ["desktop_entry","mimetypes"],
                properties: {
                  desktop_entry: {
                    title: "Default Program",
                    title_es: "Programa por defecto",
                    type:"string"
                  },
                  mimetypes: {
                    title: "Mimetypes",
                    title_es: "Tipos MIME",
                    type: "array",
                    items: {
                      type: "string"
                    }
                  }
                }
              }
            }
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


mimetypes_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:required] << "mimetypes_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:properties][:mimetypes_res] = mimetypes_js


