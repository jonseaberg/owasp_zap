# OwaspZap (Logan Carmody Clone)


A ruby client to access the HTTP API from Zap Proxy (http://code.google.com/p/zaproxy)

if you need a rpm, check it here: https://build.opensuse.org/package/show/home:vpereirabr/owasp-zap

[![Build Status](https://travis-ci.org/vpereira/owasp_zap.png?branch=master)](https://travis-ci.org/vpereira/owasp_zap)
[![Code Climate](https://codeclimate.com/github/vpereira/owasp_zap.png)](https://codeclimate.com/github/vpereira/owasp_zap)

## Features

* Added ability to scan as user
* Updated security with API Key
* Additional methods to communicate with ZAP 


## Installation

Add this line to your application's Gemfile:

    gem 'owasp_zap', git: 'https://github.com/logancarmody/owasp_zap/'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install owasp_zap, git: 'https://github.com/logancarmody/owasp_zap/'

## Usage

    require 'owasp_zap'
    
    include OwaspZap 

    z = Zap.new :target=>'http://xxx.xxx.xxx' # create new Zap instance with default params
    z = Zap.new :target=>'http://yyy.yyy.yyy', :zap=>"/usr/share/owasp-zap/zap.sh" # if you got my obs package
    z = Zap.new :output=>'logfile.txt' # it will log the stdout log from Zap Proxy to a file
    z.start # start interactive
    # TODO
    # document it further :) 
    z.start :daemon=>true # start in daemon mode
    z.scan # to run active scan
    z.alerts.view # you can specify one format JSON, XML or HTML.. default JSON.
    z.shutdown # stop the proxy

    # to disable a specific test
    to_be_disabled = JSON.load(z.policy.all)["policies"].select { |p| p["name"] == "Information gathering" }.first
 
    unless to_be_disabled.nil?
        z.scanner.disable([to_be_disabled["id"]])
    end

    # to print the XML report
    z.xml_report

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
