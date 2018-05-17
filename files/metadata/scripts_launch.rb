# scripts launcher policy structure


scripts_launch_js = {
  title: "Scripts Launcher",
  title_es: "Lanzador de scripts",
  type: "object",
  required: ["on_startup","on_shutdown"],
  is_mergeable: true,
  autoreverse: true,
  order: ["on_startup", "on_shutdown"],
  properties:
  {
    on_startup: {
      type: "array",
      title: "Script to run on startup",
      title_es: "Script para ejecutar al inicio",
      description: "Enter the absolute path to the script",
      description_es: "Introduzca la ruta absoluta al script",
      minItems: 0,
      uniqueItems: false,
      items: {
        type: "string",
        }
    },
    on_shutdown: {
      type: "array",
      title: "Script to run on shutdown",
      title_es: "Script para ejecutar al apagado",
      description: "Enter the absolute path to the script",
      description_es: "Introduzca la ruta absoluta al script",
      minItems: 0,
      uniqueItems: false,
      items: {
        type: "string",
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

scripts_launch_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:required] << "scripts_launch_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:properties][:scripts_launch_res] = scripts_launch_js



