ActionController::Routing::Routes.draw do |map|
  # Add your own custom routes here.
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Here's a sample route:
  map.connect 'wifi', :controller => 'map', :action => 'wifi'
  map.connedt 'event/markers/:date', :controller => 'event', :action => 'markers'
  # map.connect 'event/markers/:date', :controller => 'event', :action => 'markers', :defaults => { :date => Date.today}, :requirements => { :date => /(19|20)\d\d\-[01]\d\-[0-3]\d/}
  # Keep in mind you can assign values other than :controller and :action

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  map.connect '', :controller => "map"
  map.connect ':date', :controller => "map"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id'
end
