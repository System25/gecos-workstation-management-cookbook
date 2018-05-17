# System proxy policy structure


system_proxy_js = {
  title: "Proxy Configuration",
  title_es: "Configuración de Proxy",
  type: "object",
  required: ["global_config","mozilla_config"],
  order: ["global_config","mozilla_config"],
  is_mergeable: false,
  autoreverse: false,
  properties: {
    global_config: {
      title: "Global Proxy Configuration",
      title_es: "Configuración General del Proxy",
      type: "object",
      order: ["http_proxy","http_proxy_port","https_proxy","https_proxy_port","proxy_autoconfig_url","disable_proxy"],
      properties: {  
        http_proxy: {
          title: "HTTP Proxy",
          title_es: "Proxy HTTP",
          type: "string"
        },
        http_proxy_port: {
          title: "HTTP Proxy Port",
          title_es: "Puerto del Proxy HTTP",
           type: "number",
          default: 80
        },
        https_proxy: {
          title: "HTTPS Proxy",
          title_es: "Proxy HTTPS",
          type: "string"
        },
        https_proxy_port: {
          title: "HTTPS Proxy Port",
          title_es: "Puerto del Proxy HTTPS",
           type: "number",
          default: 443
        },
        proxy_autoconfig_url: {
          title: "Proxy Autoconfiguration URL",
          title_es: "Url de Autoconfiguración del Proxy",
           type: "string"
        },
        disable_proxy: {
          title: "Disable proxy configuration?",
          title_es: "¿Desactivar proxy?",
          description_es: "Si activa la casilla, desactiva la configuración del proxy",
          type: "boolean",
          default: false
        }
      }
    },
    mozilla_config: {
      title:"Mozilla Proxy Configuration (Firefox/Thunderbird)",
      title_es:"Configuración del Proxy en Mozilla (Firefox/Thunderbird)",
      type: "object",
      order: ["mode","http_proxy","http_proxy_port","https_proxy","https_proxy_port","proxy_autoconfig_url","no_proxies_on"],
      properties: {
        mode: {
          type: "string",
          title: "Configuration Mode",  
          title_es:"Forma de Configurarlo",
          enum: [ "NO PROXY", "AUTODETECT", "SYSTEM", "MANUAL","AUTOMATIC" ]
        },
        http_proxy: {
          title: "HTTP Proxy",
          title_es: "Proxy HTTP",
          type:"string"
        },
        http_proxy_port: {
          title: "HTTP Proxy Port",
          title_es: "Puerto del Proxy HTTP",
          type:"number",
          default: 80
        },
        https_proxy: {
          title: "HTTPS Proxy",
          title_es: "Proxy HTTPS",
          type:"string"
        },
        https_proxy_port: {
          title: "HTTPS Proxy Port",
          title_es: "Puerto del Proxy HTTPS",
          type:"number",
          default: 443
        },
        proxy_autoconfig_url: {
          title: "Proxy Autoconfiguration URL",
          title_es: "URL de Autoconfiguración Proxy",
          type:"string"
        },
        no_proxies_on: {
          title: "Ignore proxy for",
          title_es: "No usar proxy para",
          type:"string"
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


system_proxy_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:required] << "system_proxy_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:properties][:system_proxy_res] = system_proxy_js


