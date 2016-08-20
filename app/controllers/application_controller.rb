# require './config/environment'
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

  get '/passengers/login' do
    erb :'passengers/login'
  end

  get '/passengers/signup' do
    erb :'/passengers/signup'
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
