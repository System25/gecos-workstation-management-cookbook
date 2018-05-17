# Java configuration policy structure


appconfig_java_js = {
  title: "Java Config",
  title_es: "Configuración de Java",
  type: "object",
  required: ["config_java"],
  is_mergeable: false,
  autoreverse: false,
  properties: {
   config_java: {
      title: "Java Configuration",
      title_es: "Configuración de Java",
      type: "object",
      order: ["version", "plug_version", "sec", "crl", "warn_cert", "mix_code", "ocsp", "tls", "array_attrs"],
      properties: {
        version: {
          title: "Java Version",
          title_es: "Versión de Java",
          description: "Path to an installed Java version, example: /usr/lib/jvm/java-7-oracle",
          description_es: "Path a una versión instalada de Java, ej.: /usr/lib/jvm/java-7-oracle",
          type: "string"
        },
        plug_version: {
          title: "Plugins Java version",
          title_es: "Plugins versión de Java",
          description: "Path to an installed Java version, example: /usr/lib/jvm/java-7-oracle",
          description_es: "Path a una versión instalada de Java, ej.: /usr/lib/jvm/java-7-oracle",
          type: "string"
        },
        sec: {
          title: "Security Level",
          title_es: "Nivel de Seguridad",
          type: "string",
          enum: ["MEDIUM", "HIGH", "VERY_HIGH"],
          default: "MEDIUM"
        },
        crl: {
          title: "Use Certificate Revocation List",
          title_es: "Utilizar lista de revocación de certificados",
          type: "boolean",
          enum: [true,false],
          default: false
        },
        ocsp: {
          title: "Enable or disable Online Certificate Status Protocol",
          title_es: "Activar o desactivar el protocolo de estado de certificados en linea",
          type: "boolean",
          enum: [true,false],
          default: false
        },
        warn_cert: {
          title: "Show host-mismatch warning for certificate?",
          title_es: "¿Mostrar advertencia de incompatibilidad de host para el certificado?",
          type: "boolean",
          enum: [true,false],
          default: false
        },
        mix_code: {
          title: "Security verification of mix code",
          title_es: "Verificación de la seguridad de la combinación de código",
          type: "string",
          enum: ["ENABLE", "HIDE_RUN", "HIDE_CANCEL", "DISABLED"],
          default: "ENABLE"
        },
        tls: {
          title: "Check validity of TLS certificate",
          title_es: "Realizar comprobaciones derevocación de certificado TLS",
          type: "string",
          enum: ["SERVER_CERTIFICATE_ONLY", "NO_CHECK", ""],
          default: "" 
        },
        array_attrs: {
          type: "array",
          minItems: 0,
          title: "Another configuration properties",
          title_es: "Otras propiedades de configuración",
          uniqueItems: true,
          items:{
            type: "object",
            required: ["key", "value"],
            properties: {
              key: {type: "string", title: "Key", title_es: "Clave"},
              value: {type: "string", title: "Value", title_es: "Valor"}
            }
          }
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



appconfig_java_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:software_mgmt][:required] << "appconfig_java_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:software_mgmt][:properties][:appconfig_java_res] = appconfig_java_js


