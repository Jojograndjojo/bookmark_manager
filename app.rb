require 'sinatra/base'
require './app/models/link'

ENV['RACK_ENV'] ||= 'development'

class BookmarkManager < Sinatra::Base

  get '/links' do
    @links = Link.all
    erb :index
  end

  get '/links/new' do
    erb :new_link
  end

  post '/links' do
    Link.create(title: params[:title] , url:params[:url])
    redirect '/links'
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
