#
# Cookbook Name:: gecos-ws-mgmt
# Resource:: folder_sharing
#
# Copyright 2013, Junta de Andalucia
# http://www.juntadeandalucia.es/
#
# All rights reserved - EUPL License V 1.1
# http://www.osor.eu/eupl
#
actions :setup
default_action :setup

attribute :users, kind_of: Hash
attribute :job_ids, kind_of: Array
attribute :support_os, kind_of: Array
