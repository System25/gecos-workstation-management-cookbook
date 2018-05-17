# Power configuration policy structure


power_conf_js = {
  title: "Power management",
  title_es: "Administración de energía",
  type: "object",
#  required: ["cpu_freq_gov","auto_shutdown","usb_autosuspend"],
  order: ["cpu_freq_gov", "usb_autosuspend", "auto_shutdown"],
  is_mergeable: false,
  autoreverse: false,
  properties:
    {cpu_freq_gov: {
       title: "CPU frequency governor",
       title_es: "Control de la frecuencia de la CPU", 
       type: "string",
       enum: ["userspace","powersave","conservative","ondemand","performance",""]
       },
    usb_autosuspend: 
      {
       title: "USB autosuspend",
       title_es: "Suspensión automática de USB",
       type: "string",  
       enum: ["enable","disable", ""]
       },
     auto_shutdown: {
       type: "object",
       order: ["hour", "minute"],
       properties: {
         hour: {
           title: "Hour",
           title_es: "Hora",
           description:"Time when the computer is shutdown",
           description_es: "Hora en que se apagará el equipo",
           type: "integer",
           maximum: 23
           },
         minute: {
           title: "Minute",
           title_es: "Minuto",
           description:"Minute the computer will shutdown",
           description_es: "Minuto en que se apagará el equipo",
           type: "integer",
           maximum: 59
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


power_conf_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:required] << "power_conf_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:properties][:power_conf_res] = power_conf_js



