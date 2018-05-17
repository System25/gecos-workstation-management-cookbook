# User alerts policy structure


user_alerts_js = {
  title: "User alert",
  title_es: "Alertas de usuario",
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
          required: ["summary", "body"],
          order: ["summary", "body", "urgency", "icon"],
          properties: {  
            summary: {
              title: "Summary for the alert message",
              title_es: "Titulo para el mensaje de alerta",
              type: "string"
            }, 
            body: {
              title: "Body of the alert message",
              title_es: "Cuerpo del mensaje de alerta",
              type: "string"
            }, 
            urgency: {
              title: "Urgency level for the alert",
              title_es: "Nivel de urgencia de la alerta",
              type: "string",
              enum: ["low", "normal", "critical"],
              default: "normal"
            },
            icon: {
              title: "Icon filename or stock icon to display",
              title_es: "Fichero de icono o icono del stock a mostrar",
              description: "This policy will apply 5 minutes after synchronization",
              description_es: "Esta politica se aplicará 5 minutos después de la sincronización",
              type: "string",
              default: "info"
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


user_alerts_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:required] << "user_alerts_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:properties][:user_alerts_res] = user_alerts_js

