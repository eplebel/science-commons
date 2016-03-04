require 'rubygems'
require 'sinatra'

set :public_folder, './'

get '/' do
  "Hello World!"
end
