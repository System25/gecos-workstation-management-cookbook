# Network policy structure


network_resource_js = {
  type: "object",
  title: "Network Manager",
  title_es: "Administrador de red",
  required: ["connections"],
  is_mergeable: false,
  autoreverse: false,
  properties:
  {
    connections: {
      type: "array",
      minItems: 0,
      uniqueItems: true,
      items: {
        type: "object",
        required: ["name", "mac_address", "use_dhcp", "net_type"],
        properties: {
          fixed_con: {
            title: "DHCP Disabled properties", 
            title_es: "Propiedades desactivadas de DHCP",
            description: "Only if DHCP is disabled",
            description_es: "Solo si el DHCP esta desactivado",
            type: "object",
            properties:{
              addresses: {
                type: "array",
                uniqueItems: true,
                minItems: 0,
                description: "This field is only used if DHCP is disabled",
                description_es: "Este campo solo se usará si el DHCP está desactivado",
                title: "IP addresses",
                title_es: "Dirección IP",
                items: {
                  type: "object",
                  #required: [ "ip_addr","netmask"],
                  properties:{
                    ip_addr: {
                      type: "string",
                      title: "IP address",
                      title_es: "Dirección IP",
                      description: "ipv4 format",
                      description_es: "Formato IPV4",
                      format: "ipv4"
                    },
                    netmask: {
                      type: "string",
                      title: "Netmask",
                      title_es: "Máscara de red",
                      description: "ipv4 format",
                      description_es: "Formato IPV4",
                      format: "ipv4"
                    }
                  }
                } 
              },
              gateway: {
                type: "string",
                title: "Gateway",
                title_es: "Puerta de enlace",
                description: "ipv4 format",
                description_es: "Formato ipv4",
                format: "ipv4"
              },
              dns_servers: {
                type: "array",
                title: "DNS Servers",
                title_es: "Servidor DNS",
                description: "With DHCP disable",
                description_es: "Con DHCP desactivado",
                minItems: 0,
                uniqueItems: true,
                items: {
                  type: "string",
                  title: "DNS",
                  title_es: "DNS",
                  description: "ipv4 format",
                  description_es: "Formato ipv4",
                  format: "ipv4"
                }
              }
            }
          },
          name: {type: "string", title: "Network name", title_es: "Nombre de la red"},
          mac_address: {pattern: "^([0-9A-Fa-f]{2}[:]){5}([0-9A-Fa-f]{2})$", type: "string", title: "MAC address", title_es: "Dirección MAC"},
          use_dhcp: {type: "boolean", enum: [true,false], default:true, title: "DHCP", title_es: "DHCP"},
          net_type:{
            enum: ["wired", "wireless"], title: "Connection type", title_es: "Tipo de conexión", type: "string"
          },
          wireless_conn:{
            type:"object",
            title: "Wireless Configuration",
            title_es: "Configuración Wireless",
            properties:{
              essid: { type: "string", title: "ESSID", title_es: "ESSID" },
              security: { 
                type: "object", 
                title: "Security Configuration",
                title_es: "Configuración de Seguridad",
                required: ["sec_type"],
                order: ["sec_type", "auth_type", "enc_pass", "auth_user", "auth_password"],
                properties:{
                  sec_type: { enum: [ "none", "WEP", "Leap", "WPA_PSK"], default:"none", title: "Security type", title_es: "Tipo de seguridad", type:"string"},
                  enc_pass: { type: "string", 
                              description: "WEP, WPA_PSK security",
                              description_es: "WEP, seguridad WPA_PSK ",
                              title: "Password",
                              title_es: "Contraseña"                   
                            },
                  auth_type: { enum: ["OpenSystem", "SharedKey"], 
                               title: "Authentication type",
                               title_es: "Tipo de autenticación",
                               description: "WEP security",
                               description_es: "Seguridad WEP",
                               type: "string", 
                               default: "OpenSystem"},
                  auth_user: { type: "string",
                               description: "Leap security",
                               description_es: "Seguridad Leap",
                               title: "Username",
                               title_es: "Nombre de usuario"                                
                               },
                  auth_password: { type: "string",
                                   description: "Leap security",
                                   description_es: "Seguridad Leap",
                                   title: "Password",
                                   title_es: "Contraseña"
                                 }

                }
              }
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


network_resource_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:single_node][:required] << "network_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:single_node][:properties][:network_res] = network_resource_js





