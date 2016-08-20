# require './config/environment'
# require 'rack-flash'

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

  get '/subwaylines/lines' do
    @lines = SubwayLine.all
    erb :'/subwaylines/lines'
  end

  get '/subwaylines/show/:id' do
    @line = SubwayLine.find(params[:id])
    erb :"/subwaylines/show/#{params[:id]}"
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
