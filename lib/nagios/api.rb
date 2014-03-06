require 'nagios/api/version'

module Nagios
  module API
    autoload :Interface, 'nagios/api/interface'
    autoload :Client, 'nagios/api/client'
    autoload :Service, 'nagios/api/service'
    autoload :Services, 'nagios/api/service'
    autoload :State, 'nagios/api/state'
    autoload :Host, 'nagios/api/host'
    autoload :Hosts, 'nagios/api/host'
    autoload :Resource, 'nagios/api/resource'
    autoload :Downtime, 'nagios/api/downtime'
  end
end