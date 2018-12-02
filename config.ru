require './config/environment'

use Rack::MethodOverride

use UsersController
use FoodsController
run ApplicationController
