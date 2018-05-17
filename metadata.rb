#encoding:UTF-8
name              "gecos_ws_mgmt"
maintainer        "GECOS Team"
maintainer_email  "gecos@guadalinex.org"
license           "Apache 2.0"
description       "Cookbook for GECOS Workstations management"
version           "0.6.0"

depends "apt"
depends "chef-client"

%w{ ubuntu debian }.each do |os|
  supports os
end

# better fields definition via json-schemas:

$updated_js = {
  title: "Updated by",
  title_es: "Actualizado por",
  type: "object",
  properties: {
    group: {title: "Groups", title_es: "Grupos", type: "array", items: {type:"string"}},
    user: {type:"string"},
    computer: {type:"string"},
    ou: {title: "Ous", title_es: "Ous", type: "array", items: {type:"string"}}
  }
}

$support_os_js = {
  title: "Supported OS",
  title_es: "Sistemas operativos compatibles",
  type: "array",
  minItems: 0,
  uniqueItems: true,
  items: {
    type: "string"
  }

}


$complete_js = {
  description: "GECOS workstation management LWRPs json-schema",
  description_es: "Estación de trabajo de gestión GECOS LWRPs json-schema",
  id: "http://gecos-server/cookbooks/#{name}/#{version}/network-schema#",
  required: ["gecos_ws_mgmt"],
  type: "object",
  properties: {
    gecos_ws_mgmt: {
      type: "object",
      required: ["network_mgmt","software_mgmt", "printers_mgmt", "misc_mgmt", "users_mgmt","single_node"],
      properties: {
        network_mgmt: {
          type: "object",
          required: [],
          properties: {
          }
        },
        single_node: {
          type: "object",
          required: [],
          properties: {
          }
        },
        misc_mgmt: {
          type: "object",
          required: [],
          properties: {
          }
        },
        software_mgmt: {
          type: "object",
          required: [],
          properties: {
          }
        },
        printers_mgmt: {
          type: "object",
          required: [],
          properties: {
          }
        },
        users_mgmt: {
          type: "object",
          required: [],          
          properties: {
          }
        }
      }
    }
  }
}


# Include files from metadata directory
Dir["#{File.dirname(__FILE__)}/files/metadata/*.rb"].each {|file| require file }





attribute 'json_schema',
  :display_name => "json-schema",
  :description  => "Special attribute to include json-schema for defining cookbook's input",
  :type         => "hash",
  :object       => $complete_js

