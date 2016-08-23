require 'rack-flash'

class FeedbackController < ApplicationController

  use Rack::Flash

  get '/feedback' do
    @passenger = Passenger.find(session[:id])
    @feedbacks = RideFeedback.order(:subway_line_id).where(:passenger_id => @passenger.id)
    erb :'/feedback/index'
  end

  get '/feedback/new' do
    allowed_keys = SubwayLine.all.collect {|line| line.line}
    if !allowed_keys.include?(params[:line][:line])
      flash[:message] = "There is no #{params[:line][:line]} line currently in operation!"
      erb :error
    else
      if logged_in?
        @line = SubwayLine.find_by(:line => params[:line][:line])
        erb :'/feedback/new'
      else
        flash[:message] = "You need to login to post feedback."
        redirect '/login'
      end
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
       redirect "/subwaylines/#{params[:line][:line]}"
     end
   end
 end

  get '/feedback/:id/edit' do
    fb = RideFeedback.find(params[:id])
    if !logged_in?
      flash[:message] = "You need to login to edit your comments."
      redirect '/login'
    elsif  fb.passenger_id != session[:id].to_i
      flash[:message] = "You can only edit your own comments."
      redirect '/subwaylines'
    else
      @feedback = RideFeedback.find(params[:id])
      erb :'/feedback/edit'
    end
  end

  patch '/feedback/:id/edit' do
    fb = RideFeedback.find(params[:id])
    if !logged_in?
      flash[:message] = "You need to login to edit your comments."
      redirect '/login'
    elsif fb.passenger_id != session[:id].to_i
      flash[:message] = "You can only edit your own comments."
      redirect '/subwaylines'
    else
      fb = RideFeedback.update(params[:id], :content => params[:feedback][:content], :rating => params[:feedback][:rating].to_i)
      if fb.errors.present?
        flash[:message] = fb.errors.messages.values.join(" ")
        redirect "/feedback/#{params[:id]}/edit"
      else
        flash[:message] = "Successfully edited feedback!"
        redirect "/subwaylines/#{params[:line][:line]}"
      end
    end
  end

  delete '/feedback/:id/delete' do
    fb = RideFeedback.find(params[:id])
    if !logged_in?
      flash[:message] = "You need to login to delete your comments."
      redirect '/login'
    elsif fb.passenger_id != session[:id].to_i
      flash[:message] = "You can only delete your own comments."
      redirect '/subwaylines'
    else
      fb = RideFeedback.destroy(params[:id])
      flash[:message] = "Successfully deleted feedback!"
      redirect "/subwaylines"
    end
  end

end
