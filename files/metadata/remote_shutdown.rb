# Remote shutdown policy structure


remote_shutdown_js = {
  title: "Remote shutdown",
  title_es: "Apagado remoto",
  type: "object",
  required: ["shutdown_mode"],
  is_mergeable: false,
  autoreverse: false,
  properties: {
    shutdown_mode: {
      title: "Shutdown mode",
      title_es: "Tipo de apagado",
      description: "This policy will apply 5 minutes after synchronization",
      description_es: "Esta politica se aplicará 5 minutos después de la sincronización",
      type: "string",
      enum: ["halt", "reboot",""],
      default: "halt"
    }, 
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


remote_shutdown_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:required] << "remote_shutdown_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:properties][:remote_shutdown_res] = remote_shutdown_js


