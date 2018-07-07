$LOAD_PATH.unshift(File.expand_path('./lib'))
require 'courier/translator/app'

run Courier::Translator::App
