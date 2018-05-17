# mobile_broadband policy structure


mobile_broadband_js = {
  title: "Mobile broadband connections",
  title_es: "Conexiones de banda ancha móvil",
  type: "object",
  required: ["connections"],
  is_mergeable: true,
  autoreverse: false,
  properties: {
    connections: {
      title: "Connections",
      title_es: "Conexiones",
      type: "array",
      minItems: 0,
      uniqueItems: true,
      items: {
        type: "object",
        title: "Provider",
        title_es: "Proveedor",
        required: ["provider", "country"],
        order: ["provider","country"],
        properties: { 
          provider: {
            type: "string",
            title: "Provider",
            title_es: "Proveedor",
            enum: ['Euskaltel','Másmovil','móbil R (Mundo-R)','moviData','ONO','Pepephone','Orange','Simyo/Blau','Telecable','Movistar (Telefónica)','Vodafone (Airtel)','Yoigo','Jazztel','Carrefour Móvil','Eroski Móvil'], 
          },
          country: {
            type: "string",
            title: "Country code",
            title_es: "Código de país",
            enum: ["es"]
          }
            
        }
      }
    },
    updated_by: $updated_js,
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

mobile_broadband_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:network_mgmt][:required] << "mobile_broadband_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:network_mgmt][:properties][:mobile_broadband_res] = mobile_broadband_js


