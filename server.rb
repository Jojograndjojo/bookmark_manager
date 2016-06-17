class BookmarkManager < Sinatra::Base

  register Sinatra::Flash
  register Sinatra::Partial
  use Rack::MethodOverride

  enable :sessions

  set :root, File.join(File.dirname(__FILE__), 'app')
  set :views, Proc.new{ File.join(root, "views") } 
  set :session_secret, 'super secret'
  set :partial_template_engine, :erb


  enable :partial_underscores

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end

    def user
      @user ? @user : User.new
    end
  end

  run! if app_file == $0

end