Ruby Nagios API Client
========

A ruby gem used to interact with the nagios-api (REST interface to Nagios) server:

https://github.com/xb95/nagios-api

Install
-------

    gem install nagios-api-client

If you are using bundler, add this to your Gemfile:

    gem "nagios-api-client", require: 'nagios/api'

If not using bundler:

    require 'rubygems'
    require 'nagios/api'

Examples
------

    # Create a new client to interact with the nagios-api server.
    client = Nagios::API::Client.new("http://nagios-server:8181")
    
    # Optionally set authentication credentials
    client = Nagios::API::Client.new("http://nagios-server:8181", user: 'user', password: 'password')
    
    # Find a host
    host = client.hosts.find("hostname")
    
    # Find a service on the host
    service = host.services.find("servicename")
    
    # Check the status
    puts service.status
    
    # Check the status details
    puts service.status_details
    
    # Schedule downtime
    service.schedule_downtime(
      author: "User 1", 
      comment: "This is flexible downtime", 
      start_time: Time.now, 
      fixed: false, 
      duration: 3600, 
      end_time: Time.now + 14400
    )
  
Author
------

Philippe Green <phil@greenviewdata.com>
Greenview Data, Inc.
	
License
-------

The MIT License (MIT)

Copyright (c) 2014 Greenview Data, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.