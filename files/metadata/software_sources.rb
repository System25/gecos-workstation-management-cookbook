# Software sources policy structure


software_sources_js = {
  title: "Software Sources",
  title_es: "Fuentes de software",
  type: "object",
  required: ["repo_list"],
  is_mergeable: true,
  autoreverse: true,
  properties:{
    repo_list: {
      type:"array",
      items: {
        type:"object",
        required: ["repo_name","uri","deb_src","repo_key","key_server"],
        properties:{
          components: { title: "Components", title_es: "Componentes", type: "array",items: { type: "string" } },
          deb_src: { title: "Sources", title_es: "Fuentes", type: "boolean", default: false },
          repo_key: { title: "Repository key", title_es: "Clave del repositorio", type: "string", default: ""},
          key_server: { title: "Server key", title_es: "Clave del servidor", type: "string", default: ""},
          distribution: { title: "Distribution", title_es: "Distribución", type: "string"},
          repo_name: { title: "Repository name", title_es: "Nombre del repositorio", type: "string"},
          uri: { title: "Uri", title_es: "Uri", type: "string" }
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


software_sources_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:software_mgmt][:required] << "software_sources_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:software_mgmt][:properties][:software_sources_res] = software_sources_js

