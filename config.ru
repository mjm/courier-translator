#\ -p 5000

$LOAD_PATH.unshift(__dir__)
require 'app'

use Courier::Middleware::Documentation, __dir__
run App
