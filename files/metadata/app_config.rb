# Applications config folders policy structure


app_config_js = {
  title: "DEPRECATED: Applications Config",
  title_es: "OBSOLETA: Configuración de aplicaciones",
  type: "object",
 # required: ["citrix_config", "java_config", "firefox_config", "thunderbird_config", "loffice_config"],
  required: ["java_config", "loffice_config"],
  is_mergeable: false,
  autoreverse: false,
  properties: {
    #citrix_config: {title: "Citrix Configuration", title_es: "Configuración de Citrix", type: "object"},
    java_config: {
      title: "Java Configuration",
      title_es: "Configuración de Java",
      type: "object",
      order: ["version", "plug_version", "sec", "crl", "warn_cert", "mix_code", "ocsp", "array_attrs"],
      properties: {
        version: {
          title: "Java Version",
          title_es: "Versión de Java",
          type: "string"
        },
        plug_version: {
          title: "Plugins Java version",
          title_es: "Plugins versión de Java",
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
    firefox_config: {
      title: "Firefox Configuration",
      title_es: "Configuración de Firefox",
      type: "object",
      properties: {
        app_update:{
          title: "Enable/Disable auto update",
          title_es: "Activar/Desactivar actualizaciones automáticas",
          type: "boolean",
          enum: [true,false],
          default: false
        }
      }
    },
    thunderbird_config: {
      title: "Thunderbird Configuration",
      title_es: "Configuración de Thunderbird",
      type: "object",
      properties: {
        app_update: {
          title: "Enable/Disable auto update",
          title_es: "Activar/Desactivar actualizaciones automáticas",
          type: "boolean",
          enum: [true,false],
          default: false
        }
      }
    },
    loffice_config: {
      title: "Libre Office Configuration",
      title_es: "Configuración de Libre Office",
      type: "object",
      properties: {
        app_update: {
          title: "Enable/Disable auto update",
          title_es: "Activar/Desactivar actualizaciones automáticas",
          type: "boolean",
          enum: [true,false],
          default: false
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


app_config_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:software_mgmt][:required] << "app_config_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:software_mgmt][:properties][:app_config_res] = app_config_js


