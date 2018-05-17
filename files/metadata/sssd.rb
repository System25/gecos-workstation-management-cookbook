# SSSD policy structure


sssd_js = {
  title: "Authenticate System",
  title_es: "Sistema de Autenticación",
  type: "object",
  required: ["auth_type", "enabled"],
  is_mergeable: false,
  autoreverse: false,
  properties: {
    krb_url: { type: "string" , title: "Url of Kerberos file configuration", title_es: "Archivo de configuración Url Kerberos"},
    smb_url: { type: "string" , title: "Url of Samba file configuration", title_es: "Archivo de configuración Url Samba"},
    sssd_url: { type: "string" , title: "Url of SSSD file configuration", title_es: "Archivo de configuración Url SSSD"},
    domain_list: {
      type:"array",
      items: {
        type:"object",
        required: ["domain_name"],
        properties: {
          domain_name: {pattern: "(?=^.{1,254}$)(^(?:(?!\\d+\\.)[a-zA-Z0-9_\\-]{1,63}\\.?)+(?:[a-zA-Z]{2,})$)", type: "string", title: "Domain name", title_es: "Nombre de dominio"}
        }
      }
    },
    workgroup: {
        title: "Workgroup",
        title_es: "Grupo de trabajo",
        type: "string"
    },
    enabled: {
      title: "Enabled",
      title_es: "Habilitado",
      type: "boolean", default: false
    },
    auth_type:{
      title: "Authenticate type",
      title_es: "Tipo de Autenticación",
      type: "string"
    },
    uri:{
      title: "LDAP Uri",
      title_es: "Uri LDAP",
      type: "string"
    },
    basegroup:{
      title: "Base Group",
      title_es: "Grupo de base",
      type: "string"
    },
    base:{
      title: "Search Base",
      title_es: "Grupo de búsqueda",
      type: "string"
    },
    binddn:{
      title: "BindDN",
      title_es: "BindDN",
      type: "string"
    },
    bindpwd:{
      title: "Bin Password",
      title_es: "Bin contraseña",
      type: "string"
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


