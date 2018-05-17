# TTYs policy structure


ttys_js = {
  title: "TTYs Configuration",
  title_es: "Configuración de Consolas Virtuales",
  type: "object",
  is_mergeable: false,
  autoreversible: false,
  properties:
  {
    disable_ttys: {
      type:"boolean",
      title: "Disable ttys",
      title_es: "Deshabilitar consolas virtuales",
      description: "Checking the box will disable all ttys",
      description_es: "Si activa la casilla, deshabilitará todas las consolas virtuales del equipo",
      default: false
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

ttys_js[:properties][:support_os][:default]=["GECOS Kiosk"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:required] << "ttys_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:properties][:ttys_res] = ttys_js


