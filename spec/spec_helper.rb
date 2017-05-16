require 'webmock/rspec'
require 'nokogiri'

require_relative '../lib/lopic'

WebMock.disable_net_connect!(allow_localhost: true)
