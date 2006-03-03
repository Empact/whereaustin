class EventController < ApplicationController
  caches_page :markers
  def markers
    @headers["Content-Type"] = "application/xml"
    date = params[:date] || Date.today
    @markers = Event.find(:all, :conditions => ["date = ?", date],
                                :include => :venue)
  end
  
  def marker
    @headers["Content-Type"] = "application/xml"
    @marker = Event.find(params[:id], :include => :venue)
  end
end
