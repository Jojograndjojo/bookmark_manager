ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'
require 'sinatra/partial' 

require_relative 'controllers/links'
require_relative 'controllers/tags'
require_relative 'controllers/users'

require './server'