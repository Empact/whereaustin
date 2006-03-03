class SxswController < ApplicationController
  caches_page :markers

  def markers
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
  
  def marker
    @headers["Content-Type"] = "application/xml"
    @marker = Sxsw.find(params[:id], :include => :venue)
  end
end
