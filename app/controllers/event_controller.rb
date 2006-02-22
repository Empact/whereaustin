class EventController < ApplicationController
  def markers
    #@headers["Content-Type"] = "application/xml"
    @markers = Event.find(:all, :conditions => ["date = ?", Date.today], :order => "id ASC", :readonly => true ).locate!
  end
end