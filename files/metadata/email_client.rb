# Email client policy structure


email_client_js = {
  title: "Email Configuration",
  title_es: "Configuración de email",
  type: "object",
  is_mergeable: false,
  autoreverse: false,
  properties: {
    users: {
      type: "object",
      title: "Users",
      title_es: "Usuarios",
      patternProperties: {
        ".*" => { type: "object", title: "Username", title_es: "Nombre de usuario",
          required: ["identity", "imap", "smtp"],
          order: ["identity", "imap", "smtp"],
          properties: {  
            identity: {
              title: "Identity of the user",
              title_es: "Identidad del usuario",
              type: "object",
              order: ["name", "email"],
              properties: {
                name: {
                  title: "Name",
                  title_es: "Nombre",
                  type: "string"
                },
                email: {
                  title: "Email address",
                  title_es: "Dirección de correo electrónico",
                  # pattern: TODO !!!!
                  type: "string"
                }
              }
            },
            imap: {
              title: "IMAP server",
              title_es: "Servidor IMAP",
              type: "object",
              order: ["username", "hostname", "port"],
              properties: {
                hostname: {
                  title: "Hostname",
                  title_es: "Hostname",
                  # pattern: TODO !!!!
                  type: "string"
                },
                port: {
                  title: "Port",
                  title_es: "Puerto",
                  default: 143,
                  # selector: 143 / Libre TODO !!!!
                  type: "number"
                },
                username: {
                  title: "Username",
                  title_es: "Nombre de usuario",
                  type: "string"
                }
              }
            },
            smtp: {
              title: "SMTP server",
              title_es: "Servidor SMTP",
              type: "object",
              order: ["username", "hostname", "port"],
              properties: {
                hostname: {
                  title: "Hostname",
                  title_es: "Hostname",
                  # pattern: TODO !!!!
                  type: "string"
                },
                port: {
                  title: "Port",
                  title_es: "Puerto",
                  default: 25,
                  # selector: 25 / 110 / Libre TODO !!!!
                  type: "number"
                },
                username: {
                  title: "Username",
                  title_es: "Nombre de usuario",
                  type: "string"
                }
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

email_client_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]


$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:required] << "email_client_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:properties][:email_client_res] = email_client_js


