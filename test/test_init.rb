ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_COLOR'] ||= 'on'

if ENV['LOG_LEVEL']
  ENV['LOGGER'] ||= 'on'
else
  ENV['LOG_LEVEL'] ||= 'trace'
end

ENV['LOGGER'] ||= 'off'
ENV['LOG_OPTIONAL'] ||= 'on'

puts RUBY_DESCRIPTION

require_relative '../init.rb'
require 'event_source/postgres/controls'

require 'test_bench'; TestBench.activate

Telemetry::Logger::AdHoc.activate
require 'pp'

include EventSource
include EventSource::Postgres
