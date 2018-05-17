# mobile_broadband policy structure


cert_js = {
  title: "Certificate Management",
  title_es: "Gestion de Certificados",
  type: "object",
  is_mergeable: true,
  autoreverse: false,
  properties:{
    java_keystores: {
      title: "Java Keystores",
      title_es: "Almacenes de claves de Java",
      description: "Path of java keystore: e.g. /etc/java/cacerts-gcj",
      description_es: "Ruta del almacén de claves: p.ej. /etc/java/cacerts-gcj",
      type: "array",
      minItems: 0,
      uniqueItems: true,
      items: {
        type: "string"
      }
    },
    ca_root_certs:{
      title: "CA root certificates",
      title_es: "Certificados raices de Autoridades de Certificación (CA)",
      type:"array",
      minItems: 0,
      uniqueItems: true,
      items: {
        type: "object",
        properties:{
          name: {
            title: "Name",
            title_es: "Nombre",
            type: "string"
          },
          uri: {
            title: "Uri certificate",
            title_es: "Uri del certificado",
            type: "string"
          }
        }
      }
    },
    support_os: $support_os_js.clone,
    updated_by: $updated_js,
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

cert_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:required] << "cert_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:properties][:cert_res] = cert_js


