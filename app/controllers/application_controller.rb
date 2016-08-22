require 'rack-flash'

class ApplicationController < Sinatra::Base

  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "tietoturvaa_junille"
  end

  get '/' do
    @lines = SubwayLine.all
    erb :index
  end

  get '/subwaylines' do
    @lines = SubwayLine.all
    erb :'/subwaylines/lines'
  end

  get '/subwaylines/:id' do
    allowed_keys = SubwayLine.all.collect {|line| line.line}
    if !allowed_keys.include?(params[:id])
      flash[:message] = "There is no #{params[:id]} line currently in operation!"
      erb :error
    else
      @line = SubwayLine.find_by(:line => params[:id])
      erb :'/subwaylines/show'
    end
  end

  get '/signup' do
    if logged_in?
      flash[:message] = "You are already logged in!"
      redirect '/subwaylines'
    else
      erb :'/passengers/signup'
    end
  end

  post '/signup' do
    new_passenger = Passenger.create(params)
    if new_passenger.errors.present?
      err = new_passenger.errors.messages
      message = ""
      new_passenger.errors.messages.keys.each_with_object(message) do |cause, message|
          message << cause.to_s.capitalize + ": "
          message << err[cause].collect {|issue| issue}.join(", ")
          message << "<br>"
      end
      flash[:message] = message
      erb :'/passengers/signup'
    else
      session[:id] = new_passenger.id
      redirect '/subwaylines'
    end
  end

  get '/login' do
    if logged_in?
      flash[:message] = "You are already logged in!"
      redirect '/subwaylines'
    else
      erb :'passengers/login'
    end
  end

  post '/login' do
    passenger = Passenger.find_by(:alias => params[:alias])
    if passenger && passenger.authenticate(params[:password])
      session[:id] = passenger.id
      redirect '/subwaylines'
    else
      flash[:message] = "Unknown user or wrong password."
      redirect "/login"
    end
  end


  get '/logout' do
    session.clear
    flash[:message] = "Successfully logged out."
    redirect "/login"
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_passenger
      Passenger.find(session[:id])
    end
  end

end
