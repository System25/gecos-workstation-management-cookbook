# Automatic updates policy structure


auto_updates_js = {
  title: "Automatic Updates Repository",
  title_es: "Actualizaciones automáticas de repositorios",
  type: "object",
  required: ["auto_updates_rules"],
  is_mergeable: false,
  autoreverse: false,
  properties: {
    auto_updates_rules: {
      type: "object",
      title: "Auto Updates Rules",
      title_es: "Reglas de actualizaciones automáticas",
      required: ["onstop_update", "onstart_update", "days"],
      order: ["onstart_update", "onstop_update", "days"],
      properties: {
        onstop_update: {title: "Update on shutdown?", title_es: "Actualizar al apagado",  type: "boolean"},
        onstart_update: {title: "Update on start", title_es: "Actualizar al inicio", type: "boolean"},
        days: {
          type: "array",
          title: "Periodic dates",
          title_es: "Fechas periódicas",
          minItems: 0,
          uniqueItems: true,
          items: {
            type: "object",
            required: ["day", "hour", "minute"],
            order: ["day", "hour", "minute"],
            properties: {
              day: {
                title: "Day",
                title_es: "Día",
                type: "string",
                enum: ["monday","tuesday","wednesday","thursday","friday","saturday","sunday"]
              },
              hour: {
                title: "Hour",
                title_es: "Hora",
                type: "integer",
                maximum: 23
              },
              minute: {
                title: "Minute",
                title_es: "Minuto",
                type: "integer",
                maximum: 59
              }

            }
          }
        },
        date: {
          title: "Specific Date",
          title_es: "Fecha específica",
          type: "object",
          order: ["month", "day", "hour", "minute"],
          properties: {
            day: {title: "Day", title_es: "Día", type: "string", pattern: "^([0-9]|[0-2][0-9]|3[0-1]|\\\*)$"},
            month: {title: "Month", title_es: "Mes", type: "string",pattern: "^(0?[1-9]|1[0-2]|\\\*)$"},
            hour: {title: "Hour", title_es: "Hora", type: "string", pattern: "^((([0-1][0-9])|[0-2][0-3])|\\\*)$"},
            minute: {title: "Minute", title_es: "Minuto", type: "string",pattern: "^([0-5][0-9]|\\\*)$"},
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
    }, 
    updated_by: $updated_js
  }
}


auto_updates_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:required] << "auto_updates_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:properties][:auto_updates_res] = auto_updates_js


