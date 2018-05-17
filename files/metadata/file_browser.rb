# file browser policy structure


file_browser_js = {
  title: "File Browser",
  title_es: "Explorador de archivos",
  type: "object",
  required: ["users"],
  is_mergeable: false,
  autoreverse: false,
  properties:{
    users: {
      title: "Users",
      title_es: "Usuarios",
      type: "object",
      patternProperties: {
        ".*" => { type: "object", title: "Username", title_es: "Nombre de usuario",
          required: ["default_folder_viewer", "show_hidden_files", "show_search_icon_toolbar", "click_policy", "confirm_trash"],
          order: ["click_policy", "show_hidden_files", "default_folder_viewer", "show_search_icon_toolbar", "confirm_trash"],
          properties: {
            default_folder_viewer: {type: "string", title: "files viewer", title_es: "Visualización de archivos", enum: ["icon-view", "compact-view", "list-view"], default: "icon-view"},
            show_hidden_files: {type: "string", title: "Show hidden files?", title_es: "Mostrar archivos ocultos", enum: ["true","false"], default: "false"},
            show_search_icon_toolbar: {type: "string", title: "Show search icon on toolbar?", title_es: "Mostrar el icono de búsqueda en la barra de herramientas", enum: ["true", "false"], default: "true"},
            confirm_trash: {type: "string", title: "Confirm trash?", title_es: "Confirmar al vaciar la papelera", enum: ["true","false"], default: "true"},
            click_policy: {type: "string", title: "Click policy", title_es: "Política de click", enum: ["single", "double"], default: "double"}, 
            updated_by: $updated_js
          }
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
    }
  }
}


file_browser_js[:properties][:support_os][:default]=["GECOS V3", "GECOS V2"]

$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:required] << "file_browser_res"
$complete_js[:properties][:gecos_ws_mgmt][:properties][:users_mgmt][:properties][:file_browser_res] = file_browser_js


