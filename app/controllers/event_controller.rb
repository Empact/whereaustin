class EventController < ApplicationController
  def markers
    date = params[:date] || Date.today
    @headers["Content-Type"] = "application/xml"
    @markers = Event.find(:all, :conditions => ["date = ?", date], :order => "id ASC" ).locate!
  end
end