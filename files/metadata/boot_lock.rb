# Boot lock policy structure



boot_lock_js = {
  title: "Lock boot menu",
  title_es: "Bloqueo del menú de arranque",
  type: "object",
  order:["lock_boot","unlock_user","unlock_pass"],
  is_mergeable: false,
  autoreverse: false,
  properties: {
    lock_boot: {title: "Lock boot menu?", title_es: "¿Bloquear el menú de inicio?",  type: "boolean"},
    unlock_user: {title: "Unlock user", title_es: "Usuario de desbloqueo", type: "string"},
    unlock_pass: {title: "Unlock pass", title_es: "Clave de desbloqueo", type: "string"},
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

boot_lock_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2","Ubuntu 14.04.1 LTS",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:required] << "boot_lock_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:properties][:boot_lock_res] = boot_lock_js


