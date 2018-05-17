# Local file policy structure


local_file_js = {
  title: "Local files",
  title_es: "Archivos locales",
  type: "object",
  required: ["localfiles"],
                                        
  is_mergeable: true,
  autoreverse: false,
  additionalProperties: false,
  form: {
    type: "array",            
    title: "Files list",              
    title_es: "Lista de archivos",
    items: {  
      type: "section",
      items: [
         "localfiles[].file_dest",
         {
          type: "selectfieldset",
          title: "Select an action",
          title_es: "Seleccione una acción",
          key: "localfiles[].action",
          items: [
            {
              type:"section",
              items: [
                "localfiles[].file",
                "localfiles[].user",
                "localfiles[].group",
                "localfiles[].mode",
                "localfiles[].overwrite"
              ]
            },
            {
              type:"section",
              items: [
                "localfiles[].backup"
              ]
            }
          ]
         }
      ]
    }
  },
  properties:
  {
    localfiles: {
      type:"array",
      title: "Files list",
      title_es: "Lista de archivos",
      minItems: 0,
      uniqueItems: true,
      items: {
        type:"object",
        required: ["action","file_dest"],
        order:["action","file_dest"],
        mergeIdField: ["file_dest"],
        mergeActionField: "action",
        properties:{
          action:{title: "Action", title_es: "Acción", type: "string", enum: ["add", "remove"]},
          file_dest: {type: "string", title: "File Path", title_es: "Ruta del archivo", description: "Enter the absolute path where the file is saved", description_es: "Introduzca la ruta absoluta donde se guardará el archivo"},
          user: {type: "string", title:"User", title_es: "Usuario"},
          group: {type: "string", title: "Group", title_es: "Grupo"},
          mode: {type: "string", title: "Mode", title_es: "Permisos"},
          overwrite: {type: "boolean", title: "Overwrite?", title_es: "Sobrescribir"},
          backup: { type: "boolean", title: "Create backup?", title_es: "¿Crear copia de seguridad?" },
          file: {type: "string", title: "File URL", title_es: "URL del archivo", description: "Enter the URL where the file was downloaded", description_es: "Introduzca la URL donde se descargará el archivo"},

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


local_file_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2",  "GECOS V3 Lite", "Gecos V2 Lite"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:required] << "local_file_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:misc_mgmt][:properties][:local_file_res] = local_file_js

