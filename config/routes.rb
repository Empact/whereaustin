ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  map.connect ':date',
              :controller   => "map",
              :action       => 'music',
              :defaults     => {:date => Date.today.to_s},
              :requirements => {:date => /(19|20)\d\d\-[01]\d\-[0-3]\d/}
  map.connect 'wifi/',
              :controller => 'map',
              :action     => 'wifi'
  map.connect 'sxsw/:date',
              :controller => "map",
              :action => 'sxsw',
              :defaults => { :date => Date.civil(2006, 3, 15).to_s},
              :requirements => {:date => /(19|20)\d\d\-[01]\d\-[0-3]\d/}

  map.connect 'event/markers/:date', :controller => 'marker', :action => 'events'
  map.connect 'sxsw/markers/:date',  :controller => "marker", :action => 'sxsws'
  map.connect 'wifi/markers/',       :controller => "marker", :action => 'wifis'

  # map.connect 'event/markers/:date', :controller => 'event', :action => 'markers', :defaults => { :date => Date.today}, :requirements => { :date => /(19|20)\d\d\-[01]\d\-[0-3]\d/}
  # Keep in mind you can assign values other than :controller and :action

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id'
end
