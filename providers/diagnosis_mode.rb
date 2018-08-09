#
# Cookbook Name:: gecos-ws-mgmt
# Provider:: debug_mode
#
# Copyright 2018, Junta de Andalucia
# http://www.juntadeandalucia.es/
#
# All rights reserved - EUPL License V 1.1
# http://www.osor.eu/eupl
#
require 'json'
require 'time'

action :setup do

  begin

    # Checking OS 
    if new_resource.support_os.include?($gecos_os)

      # Read /etc/gcc.control file
      file = ::File.read('/etc/gcc.control')
      gcc_control = JSON.parse(file)
      Chef::Log.debug("debug_mode.rb ::: gcc_control => #{gcc_control}")      
      
      enable_debug = new_resource.enable_debug
      if new_resource.expire_datetime == '' or Time.parse(new_resource.expire_datetime) < Time.now
        enable_debug = false
      end
      
      # Set debug mode flag
      template "/etc/gcc.control" do
          source 'gcc.control.erb'
          owner "root"
          group "root"
          mode 00755
          variables({
            :uri_gcc => gcc_control['uri_gcc'],
            :gcc_username => gcc_control['gcc_username'],
            :gcc_nodename => gcc_control['gcc_nodename'],
            :debug_mode => enable_debug
          })
      end     

    else
      Chef::Log.info("This resource is not support into your OS")
    end
   
    # save current job ids (new_resource.job_ids) as "ok"
    job_ids = new_resource.job_ids
    job_ids.each do |jid|
      node.normal['job_status'][jid]['status'] = 0
    end

  rescue Exception => e
    # just save current job ids as "failed"
    # save_failed_job_ids
    Chef::Log.error(e.message)
    Chef::Log.error(e.backtrace)

    job_ids = new_resource.job_ids
    job_ids.each do |jid|
      node.normal['job_status'][jid]['status'] = 1
      if not e.message.frozen?
        node.normal['job_status'][jid]['message'] = e.message.force_encoding("utf-8")
      else
        node.normal['job_status'][jid]['message'] = e.message
      end
    end
  ensure
    
    gecos_ws_mgmt_jobids "debug_mode_res" do
       recipe "single_node"
    end.run_action(:reset)
    
  end
end
