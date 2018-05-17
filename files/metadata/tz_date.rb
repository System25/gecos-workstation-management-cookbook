# NTP server policy structure


tz_date_js = {
  title: "Administration Date/Time",
  title_es: "Administración fecha/hora",
  type: "object",
  required: ["server"],
  is_mergeable: false,
  autoreverse: false,
  properties: {
    server: {
      type: "string",
      title: "Server NTP",
      title_es: "Servidor NTP",
      description: "Enter the URI of an NTP server",
      description_es: "Introduzca la URI de un servidor NTP"
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

tz_date_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:required] << "tz_date_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:properties][:tz_date_res] = tz_date_js
