class MapController < ApplicationController
  Type  = Struct.new(:id, :name)
  TYPES = [Type.new("recommended", "Top Events"),
           Type.new("roadshow",    "Road Show Events"),
           Type.new("music",       "Live Music Events"),
           Type.new("dj",          "DJ Events"),
           Type.new("mic",         "Open Mic Events"),
           Type.new("karaoke",     "Karaoke Events")]
  
  def index
    list
    render :action => 'list'
  end

  def list
    @events = {}
    for type in TYPES
      @events[type.id] = Event.find(:all, :conditions => ["icon = ? AND date = ?", type.id, Date.today ]).locate!
    end
    @types = TYPES
    markers
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
