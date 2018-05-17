# Printers policy structure


printers_js = {
  title: "Printers",
  title_es: "Impresoras",
  type: "object",
  required: ["printers_list"],
  is_mergeable: true,
  autoreverse: true,
  properties:
  {
    printers_list: {
      type:"array",
      title: "Printer list to enable",
      title_es: "Lista de impresoras para activar",
      items: {
        type:"object",
        required: [ "name", "manufacturer", "model", "uri"],
        properties:{
          name: { type: "string", title: "Name", title_es: "Nombre"},
          manufacturer: { type: "string", title: "Manufacturer", title_es: "Manufactura" },
          model: { type: "string" , title: "Model", title_es: "Modelo"},
          uri: { type: "string", title: "Uri", title_es: "Uri"},
          ppd_uri: { type: "string", title: "Uri PPD", title_es: "Uri PPD", default: "", pattern: "(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]"},
          ppd: { type: "string", title: "PPD Name", title_es: "Nombre PPD"},
          oppolicy: {enum: ["default","authenticated","kerberos-ad"], default:"default", type: "string", title: "Operation Policy", title_es: "Politica de Autenticación"}
        }
      }
    },
    job_ids: {
      type: "array",
      minItems: 0,
      uniqueItems: true,
      items: {
        type: "string"
      }
    }, 
    support_os: $support_os_js.clone,
    updated_by: $updated_js
  }
}


printers_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:printers_mgmt][:required] << "printers_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:printers_mgmt][:properties][:printers_res] = printers_js
