class EventController < ApplicationController
  def markers
    @headers["Content-Type"] = "application/xml"
    date = params[:date] || Date.today
    @markers = Event.find(:all, :conditions => ["date = ?", date], :order => "id ASC" ).locate!  
  end
  
  def marker
    @headers["Content-Type"] = "application/xml"
    @marker = Event.find(params[:id])
  end
end