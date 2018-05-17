# Forticlient VPN policy structure


forticlientvpn_js = {
  title: "FortiClient VPN connections",
  title_es: "Conexiones VPN de FortiClient",
  type: "object",
  required: ["connections"],
  is_mergeable: false,
  autoreverse: false,
  order: ["connections", "proxyserver", "proxyport", "proxyuser", "autostart", "keepalive"],
  properties: {
    connections: {
      title: "Connections",
      title_es: "Conexiones",
      type: "array",
      minItems: 0,
      uniqueItems: true,
      items: {
        type: "object",
        required: ["name", "server", "port"],
        order: ["name", "server", "port"],
        properties: {
          server: {
            type: "string",
            title: "Server",
            title_es: "Servidor"
          },
          port: {
            type: "string",
            title: "Port",
            title_es: "Puerto"
          },
          name: {
            type: "string",
            title: "Name",
            title_es: "Nombre"
          }
        }
      }
    },
    proxyserver:{ 
      type: "string",
      title: "Proxy Server",
      title_es: "Servidor Proxy"
    },
    proxyport: {
      type: "string",
      title: "Proxy Port",
      title_es: "Puerto del Proxy"
    },
    proxyuser: {
      type: "string",
      title: "Proxy user",
      title_es: "Usuario del Proxy"
    },
    autostart: {
      type: "boolean",
      title: "Proxy user",
      default: false,
      title_es: "Arranque automatico"
    },
    keepalive:{ 
      title: "Keepalive frequency",
      title_es: "Frecuencia del keepalive",
      type: "integer"
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


forticlientvpn_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:network_mgmt][:required] << "forticlientvpn_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:network_mgmt][:properties][:forticlientvpn_res] = forticlientvpn_js



