class WifiController < ApplicationController
  caches_page :markers

  def markers
    @headers["Content-Type"] = "application/xml"
    @markers = Wifi.find(:all) 
  end
end
