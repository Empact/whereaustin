class MapController < ApplicationController
  Type  = Struct.new(:id, :name)
  @@music_types = [Type.new("recommended", "Top Events"),
                  Type.new("roadshow",    "Road Show Events"),
                  Type.new("music",       "Live Music Events"),
                  Type.new("dj",          "DJ Events"),
                  Type.new("mic",         "Open Mic Events"),
                  Type.new("karaoke",     "Karaoke Events")]
  @@wifi_types = [Type.new("online",      "Online"),
                  Type.new("flakey",      "Flakey"),
                  Type.new("offline",     "Offline"),
                  Type.new("lowusage",    "Low-Usage")]


  def index
    music(Date.today)
    render :action => 'music'
  end

  def new_music
    music(@params[:date])
    render :layout => false, :action => 'music'
  end
  
  def music(date)
    @now = date.to_s
    all_events = Event.find(:all, :conditions => ["date = ?", @now ],
                                  :include => :venue)
    @events = {}
    for type in @@music_types
      @events[type.id] = all_events.select { |it| it.icon == type.id}
    end
    @types = @@music_types
    today = Date.today
    @date_options = [['Today', today], ['Tomorrow', today + 1]].concat(
                     Array.new(6).fill(0..5) {|i| [Date::DAYNAMES[(today + i+2).wday], today + i + 2]}
                    )
    @my_action = :new_music
    @keys = [['<img src="http://whereaustin.com/images/recommended.png" alt="Recommended Event Marker" />', 
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
                 '<a href="#karaoke">karaoke</a>']
            ]
    
  end
  
  def wifi
    @wifis = {}
    for type in @@wifi_types
      @wifis[type.id] = Wifi.find(:all, :conditions => ["status = ?", type.id])
    end
    @types = @@wifi_types
  end
  
  def new_sxsw
    sxsw(@params[:date])
    render :layout => false, :action => 'sxsw'
  end
  
  def sxsw(date=nil)
    start = Date.civil 2006, 3, 18
    @now = date || start
    @date_options = [['Wed, March 18th', start], ['Thurs, March 19th', start + 1],
                     ['Fri, March 20th', start + 2], ['Sat, March 21st', start + 3],
                     ['Sun, March 22nd', start + 4]]
    @my_action = :new_sxsw
    @keys = [['<img src="http://whereaustin.com/images/recommended.png" alt="SXSW Music Event Marker" />',
                   '<a>SXSW Music Event</a>' ]]
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
  
  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = 'Event was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:notice] = 'Event was successfully updated.'
      redirect_to :action => 'show', :id => @event
    else
      render :action => 'edit'
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
