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
    @events = {}
    for type in @@music_types
      @events[type.id] = Event.find(:all, :conditions => ["icon = ? AND date = ?", type.id, @now ]).locate!
    end
    @types = @@music_types 
  end
  
  def wifi
    @events = {}
    for type in @@wifi_types
      @events[type.id] = Wifi.find(:all, :conditions => ["status = ?", type.id])
    end
    @types = @@wifi_types
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
