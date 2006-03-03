class MapController < ApplicationController
  caches_page :music, :new_music,
              :sxsw, :new_sxsw,
              :wifi
 
  def new_music
    music
    render :layout => false, :action => 'music'
  end
  
  def music
    @now = @params[:date]
    all_events = Event.find(:all, :conditions => ["date = ?", @now ],
                                  :include => :venue)
    @events = {}
    for type in @@music_types
      @events[type.id] = all_events.select { |it| it.icon == type.id}
    end
    @types = @@music_types
    
    today = Date.today
    @date_options = [['Today', today.to_s], ['Tomorrow', (today + 1).to_s]].concat(
                     Array.new(6).fill(0..5) {|i| [Date::DAYNAMES[(today + i+2).wday], (today + i + 2).to_s]}
                    )
    @message = "Showing music events occurring:"
    @my_action = :new_music
    @keys = MUSIC_KEYS
  end
  
  def wifi
    all_wifis = Wifi.find(:all)
    @wifis = {}
    for type in @@wifi_types
      @wifis[type.id] = all_wifis.select {|it| it.status == type.id }
    end
    @types = @@wifi_types
    @no_date = true;
    @message = "Showing free wifi hotspots"
    @keys = WIFI_KEYS
  end
  
  def new_sxsw
    sxsw
    render :layout => false, :action => 'sxsw'
  end
  
  def sxsw
    @now = Date.parse(@params[:date])
    @date_options = [['Wed, March 15th', @now.to_s],     ['Thurs, March 16th', (@now + 1).to_s],
                     ['Fri, March 17th', (@now + 2).to_s], ['Sat, March 18th', (@now + 3).to_s],
                     ['Sun, March 19th', (@now + 4).to_s]]
    @message = "Showing SXSW Music events occurring:"
    @my_action = :new_sxsw
    @keys = SXSW_KEYS
    sxsw = Sxsw.find(:all, :conditions => ["performancedate = ?", @now], :include => :venue)
    @sxsw = {}
    for event in sxsw
      if @sxsw[event.venue.name].nil?
        @sxsw[event.venue.name] = [event]
      else
        @sxsw[event.venue.name] << event
      end
    end
    render :layout => 'sxswmap'
  end
   
private
  Type  = Struct.new(:id, :name)
  @@music_types = [Type.new("recommended", "Top Events"),
                  Type.new("roadshow",    "Road Show Events"),
                  Type.new("music",       "Live Music Events"),
                  Type.new("dj",          "DJ Events"),
                  Type.new("mic",         "Open Mic Events"),
                  Type.new("karaoke",     "Karaoke Events")]
  @@wifi_types = [Type.new("Online",      "Online"),
                  Type.new("Flakey",      "Flakey"),
                  Type.new("Offline",     "Offline"),
                  Type.new("lowusage",    "Low-Usage")]

  MUSIC_KEYS = [['<img src="http://whereaustin.com/images/recommended.png" alt="Recommended Event Marker" />', 
                 '<a href="#recommended">recommended</a>'],
                ['<img src="http://whereaustin.com/images/roadshow.png" alt="Roadshow Event Marker" />', 
                 '<a href="#roadshow">roadshow</a>'],
                ['<img src="http://whereaustin.com/images/music.png" alt="Live Music Event Marker" />', 
                 '<a href="#music">live music</a>'],
                ['<img src="http://whereaustin.com/images/dj.png" alt="DJ Event Marker" />', 
                 '<a href="#dj">dj</a>'],
                ['<img src="http://whereaustin.com/images/mic.png" alt="Open Mic Event Marker" />', 
                 '<a href="#mic">open mic</a>'],
                ['<img src="http://whereaustin.com/images/karaoke.png" alt="Karaoke Event Marker" />', 
                 '<a href="#karaoke">karaoke</a>']]
  SXSW_KEYS = [['<img src="http://whereaustin.com/images/recommended.png" alt="SXSW Music Event Marker" />',
                '<a>SXSW Music Event</a>' ]]
  WIFI_KEYS = [['<img src="http://whereaustin.com/images/wifi_online.png" alt="Live Hotspot" />',
                '<a href="#online">Online</a>'],
               ['<img src="http://whereaustin.com/images/wifi_low_usage.png" alt="Low-usage Hotspot" />',
                '<a href="#lowusage">Low Usage</a>'],
               ['<img src="http://whereaustin.com/images/wifi_flakey.png" alt="Flakey Hotspot" />',
                '<a href="#flakey">Flakey</a>'],
               ['<img src="http://whereaustin.com/images/wifi_offline.png" alt="Offline Hotspot" />',
                '<a href="#offline">Offline</a>']]
end
