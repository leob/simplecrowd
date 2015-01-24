# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

# See: http://robots.thoughtbot.com/content-compression-with-rack-deflater
# see: https://github.com/lockitron/selfstarter/blob/master/config.ru
use Rack::Deflater

run Rails.application
