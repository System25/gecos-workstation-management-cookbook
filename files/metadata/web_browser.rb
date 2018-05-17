# Web browser policy structure


web_browser_js = {
  title: "Web Browser",
  title_es: "Navegador Web",
  type: "object",
  required: ["users"],
  is_mergeable: true,
  autoreverse: false,
  properties: {
    users: {
      type: "object",
      title: "Users",
      title_es: "Usuarios",
      patternProperties: {
        ".*" => { type: "object", title: "Username", title_es: "Nombre de usuario",
          properties: {
            plugins: {
              type: "array",
              title: "Plugins",
              title_es: "Plugins", 
              minItems: 0,
              uniqueItems: true,
              items: {
                type: "object",
                required: ["name", "uri", "action"],
                order: ["name", "uri", "action"],
                properties: {
                  name: {title: "Name", title_es: "Nombre", type: "string"},
                  uri: {title: "Uri", title_es: "Uri", type: "string"},
                  action: {title: "Action", title_es: "Acción", type: "string", enum: ["add", "remove"]}
                }
              }
            },
            bookmarks: {
              type: "array",
              title: "Bookmarks",
              title_es: "Marcadores",
              minItems: 0,
              uniqueItems: true,
              items: {
                type: "object",
                required: ["name", "uri"],
                order: ["name", "uri"],
                properties: {
                  name: {title: "Name", title_es: "Nombre", type: "string"},
                  uri: {title: "Uri", title_es: "Uri", type: "string"}
                }
              }
            },
            config: {
              type: "array",
              title: "Configs",
              title_es: "Configuraciones",
              minItems: 0,
              uniqueItems: true,
              items: {
                type: "object",
                required: ["key"],
                order: ["key", "value_type", "value_str", "value_num", "value_bool"],
                properties: {
                  key: {type: "string", title: "Key", title_es: "Clave", description: "Enter a key to about:config", description_es: "Introduzca una clave de about:config"},
                  value_str: {type: "string",
                              description: "Only if Value Type is string",
                              description_es: "Solo si el tipo de valor es una cadena",
                              title: "Value",
                              title_es: "Valor"                              
                              },
                  value_num: {type: "number", 
                              description: "Only if Value Type is number",
                              description_es: "Solo si el tipo de valor es un numero",
                              title: "Value",
                              title_es: "Valor"                              
                              },
                  value_bool: {type: "boolean", 
                               description: "Only if Value Type is boolean",
                               description_es: "Solo si el tipo de valor es booleano",
                               title: "Value",
                               title_es: "Valor"                               
                               },
                  value_type: {title: "Value type", title_es: "Tipo de valor", type: "string", enum: ["string", "number", "boolean"]}

                }
              }
            #},
            #certs: {
            # type: "array",
            # title: "Certificates",
            # title_es: "Certificados",
            # minItems: 0,
            # uniqueItems: true,
            # items: {
            #   type: "object",
            #   required: [ "name", "uri"],
            #   properties: {
            #     name: {title: "Name", title_es: "Nombre", type: "string"},
            #     uri: {title: "Uri", 
            #           title_es: "Uri", 
            #           type: "string", 
            #           description: "Only accept CRT and PEM certificate", 
            #           description_es: "Solo acepta certificados CRT y PEM"}
            #   }
            # }
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



web_browser_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:required] << "web_browser_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:properties][:web_browser_res] = web_browser_js





