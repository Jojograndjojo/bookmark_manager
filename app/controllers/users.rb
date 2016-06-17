class BookmarkManager < Sinatra::Base

  register Sinatra::Partial

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

end