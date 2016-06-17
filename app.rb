ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base

  use Rack::MethodOverride

  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash


  get '/links' do
    @links = Link.all
    erb(:'links/index')
  end

  get '/links/new' do
    erb(:'links/new')
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title])
    params[:tags].split.each {|tag| link.tags << Tag.first_or_create(name: tag)}
    link.save
    redirect to('/links')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    @user = User.new(email: params[:email],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect('/links')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/new'
    end
  end

  get '/users/sign_in' do
    erb :'users/sign_in'
  end

  post '/users/sign_in' do
    if @user = User.authenticate(params)
      session[:user_id] = @user.id
      redirect('/links')
    else
      flash.now[:errors] = ['There was a problem.']
      erb :'users/sign_in'
    end
  end

  delete '/users/sign_out' do
    session[:user_id] = nil
    flash.keep[:message] = 'Goodbye, alice@example.com'
    redirect '/links'
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end

    def user
      @user ? @user : User.new
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
