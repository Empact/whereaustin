class MarkerController < ApplicationController
  caches_page :events, :event,
              :sxsws,  :sxsw,
              :wifis
  
  def events
    @headers["Content-Type"] = "application/xml"
    date = params[:date] || Date.today
    @markers = Event.find(:all, :conditions => ["date = ?", date],
                                :include => :venue)
  end
  
  def event
    @headers["Content-Type"] = "application/xml"
    @marker = Event.find(params[:id], :include => :venue)
  end
  
  def sxsws
    @headers["Content-Type"] = "application/xml"
    date = @params[:date] or Date.civil 2006, 3, 18
    sxsw = Sxsw.find(:all, :conditions => ["performancedate = ?", date], :include => :venue)
    @markers = {}
    for event in sxsw
      if @markers[event.venue.name].nil?
        @markers[event.venue.name] = [event]
      else
        @markers[event.venue.name] << event
      end
    end
  end
  
  def sxsw
    @headers["Content-Type"] = "application/xml"
    @marker = Sxsw.find(params[:id], :include => :venue)
  end
  
  def wifis
    @headers["Content-Type"] = "application/xml"
    @markers = Wifi.find(:all) 
  end
end
