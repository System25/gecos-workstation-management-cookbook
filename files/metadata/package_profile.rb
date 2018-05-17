# Package profile policy structure



package_profile_js = {
  title: "Packages Profile management",
  title_es: "Administración de perfiles de software",
  type: "object",
  order:["package_list"],
  is_mergeable: true,
  autoreverse: false,
  properties:
  {
    package_list: {
      type:"array",
      title: "Package list to install",
      title_es: "Lista de paquetes para instalar",
      minItems: 0,
      uniqueItems: true,
      items: {type: "string"}
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


package_profile_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2","Ubuntu 14.04.1 LTS",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:software_mgmt][:required] << "package_profile_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:software_mgmt][:properties][:package_profile_res] = package_profile_js


