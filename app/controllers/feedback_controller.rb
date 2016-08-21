require 'rack-flash'

class FeedbackController < ApplicationController

  use Rack::Flash

  get '/feedback/:id/new' do
    if logged_in?
      allowed_keys = SubwayLine.all.collect {|line| line.line}
      if !allowed_keys.include?(params[:id])
        flash[:message] = "There is no #{params[:id]} line currently in operation!"
        erb :error
      else
        @line = SubwayLine.find_by(:line => params[:id])
        erb :'/feedback/new'
      end
    else
      flash[:message] = "You need to login to post feedback."
      redirect '/login'
    end
  end

 post '/feedback' do
   if !logged_in?
     flash[:message] = "You need to login to post feedback."
     redirect '/login'
   else
     fb = RideFeedback.create(:content => params[:feedback][:content], :rating => params[:feedback][:rating].to_i)
     fb.subway_line = SubwayLine.find_by(params[:line])
     fb.passenger = Passenger.find(session[:id])
     if fb.save
       flash[:message] = "Successfully added feedback!"
       redirect "/subwaylines/#{params[:line][:line]}"
     else
       flash[:message] = fb.errors.messages.values.join(" ")
       redirect "/feedback/#{params[:line][:line]}/new"
     end
   end
 end

end
