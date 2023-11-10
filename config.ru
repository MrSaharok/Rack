require 'rack'
require './run_time'

ROUTES = {
  '/time' => RunTime.new
}

use Rack::Reloader, 0
use Rack::ContentType, 'text/plain'

run Rack::URLMap.new(ROUTES)
