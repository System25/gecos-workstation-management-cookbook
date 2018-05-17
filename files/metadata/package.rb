# mobile_broadband policy structure


package_js = {
  title: "Packages management",
  title_es: "Administración de paquetes",
  type: "object",
  order:["package_list"],
  is_mergeable: true,
  autoreverse: false,
  properties:
  {
    package_list: {
      type:"array",
      title: "Package list",
      title_es: "Lista de paquetes",
      minItems: 0,
      uniqueItems: true,
      items: {
        type: "object",
        required: ["name", "version", "action"],
        order: ["name", "version", "action"],
        mergeIdField: ["name"],
        mergeActionField: "action",
        properties: {
          name: {title: "Name", title_es: "Nombre", type: "string"},
          version: {title: "Version", title_es: "Versión", type: "string"},
          action: {title: "Action", title_es: "Acción", type: "string", enum: ["add", "remove"]}
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


package_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2","Ubuntu 14.04.1 LTS",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:software_mgmt][:required] << "package_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:software_mgmt][:properties][:package_res] = package_js

