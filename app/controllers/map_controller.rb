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
    @message = "Showing music events for:"
    @my_action = :new_music

    @keys = MUSIC_KEYS
  end
  
  def wifi
    all_wifis = Wifi.find(:all)
    @wifis = {}
    for type in @@wifi_types
      id = type.id
      id = "Low Usage" if type.id == "Lowusage"
      @wifis[type.id] = all_wifis.select {|it| it.status == id }
    end
    @types = @@wifi_types
    @no_date = true;
    @message = "Showing free wifi hotspots"
    @keys = WIFI_KEYS
  end
  
  def new_sxsw
    sxsw_vals
    render :action => :sxsw, :layout => false
  end
  
  def sxsw
    sxsw_vals
    render :layout => 'sxswmap'
  end
   
  def sxsw_vals
    @now = Date.parse(@params[:date])
    @date_options = [['Wed, March 15th', @now.to_s],     ['Thurs, March 16th', (@now + 1).to_s],
                     ['Fri, March 17th', (@now + 2).to_s], ['Sat, March 18th', (@now + 3).to_s],
                     ['Sun, March 19th', (@now + 4).to_s]]
    @message = "Showing SXSW Music events occurring:"
    @my_action = :new_sxsw
    @keys = SXSW_KEYS
    @player = true
    
    sxsw = Sxsw.find(:all, :conditions => ["performancedate = ?", @now], :include => :venue)
    @sxsw = {}
    for event in sxsw
      if @sxsw[event.venue.name].nil?
        @sxsw[event.venue.name] = [event]
      else
        @sxsw[event.venue.name] << event
      end
    end  
  end
   
private

  def gen_keys(types, events, in_keys)
    keys = []
    for type in types
      keys += in_keys[type.id] if events[type.id].length > 0
    end
    keys
  end
  

  Type  = Struct.new(:id, :name)
  @@music_types = [Type.new("recommended", "Top Events"),
                  Type.new("roadshow",    "Road Show Events"),
                  Type.new("music",       "Live Music Events"),
                  Type.new("dj",          "DJ Events"),
                  Type.new("mic",         "Open Mic Events"),
                  Type.new("karaoke",     "Karaoke Events")]
  @@wifi_types = [Type.new("Online",      "Online"),
                  Type.new("Lowusage",    "Low-Usage"),
                  Type.new("Flakey",      "Flakey"),
                  Type.new("Offline",     "Offline")]

  MUSIC_KEYS = [   ['<img src="http://whereaustin.com/images/recommended.png" alt="Recommended Event Marker" id="recommended_key" />', 
                   '<a href="#recommended" id="recommended_value">recommended</a>'],
                   ['<img src="http://whereaustin.com/images/roadshow.png" alt="Roadshow Event Marker" id="roadshow_key" />', 
                       '<a href="#roadshow" id="roadshow_value">roadshow</a>'],
                   ['<img src="http://whereaustin.com/images/music.png" alt="Live Music Event Marker" id="music_key" />', 
                       '<a href="#music" id="music_value">live music</a>'],
                   ['<img src="http://whereaustin.com/images/dj.png" alt="DJ Event Marker" id="dj_key" />', 
                       '<a href="#dj" id="dj_value">dj</a>'],
                   ['<img src="http://whereaustin.com/images/mic.png" alt="Open Mic Event Marker" id="mic_key" />', 
                       '<a href="#mic" id="mic_value">open mic</a>'],
                   ['<img src="http://whereaustin.com/images/karaoke.png" alt="Karaoke Event Marker" id="karaoke_key" />', 
                       '<a href="#karaoke" id="karaoke_value">karaoke</a>']
                 ]
                 
  SXSW_KEYS = [['<img src="http://whereaustin.com/images/recommended.png" alt="SXSW Music Event Marker" />',
                '<a>SXSW Music Event</a>' ]]
  WIFI_KEYS = [['<img src="http://whereaustin.com/images/wifi_online.png" alt="Live Hotspot" />',
                '<a href="#Online">Online</a>'],
               ['<img src="http://whereaustin.com/images/wifi_low_usage.png" alt="Low-usage Hotspot" />',
                '<a href="#Lowusage">Low Usage</a>'],
               ['<img src="http://whereaustin.com/images/wifi_flakey.png" alt="Flakey Hotspot" />',
                '<a href="#Flakey">Flakey</a>'],
               ['<img src="http://whereaustin.com/images/wifi_offline.png" alt="Offline Hotspot" />',
                '<a href="#Offline">Offline</a>']
              ]
end
