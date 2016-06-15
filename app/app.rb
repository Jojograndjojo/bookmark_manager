ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require './app/models/link'
require_relative 'data_mapper_setup'
class BookmarkManager < Sinatra::Base
  enable :sessions
  get '/' do
    'Hello BookmarkManager!'
  end
  get '/links' do
    @links = Link.all
    erb :links
  end
  get '/links/new' do
    erb :'links/new'
  end

  post '/add' do
    link = Link.create(url: params[:url], title: params[:title])
    tag =Tag.first_or_create(name: params[:tags])
    link.tags << tag
    link.save
    redirect ('/links')
  end
  # start the server if ruby file executed directly
  run! if app_file == $0
end
