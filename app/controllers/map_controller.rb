class MapController < ApplicationController
  NAMES = {"recommended" => "Top Events",
           "roadshow"    => "Road Show Events",
           "music"       => "Live Music Events",
           "dj"          => "DJ Events",
           "mic"         => "Open Mic Events",
           "karaoke"     => "Karaoke Events"}
  
  def index
    list
    render :action => 'list'
  end

  def list
    @events = {}
    for type in NAMES.keys
      @events[type] = Event.find(:all, :conditions => ["icon = ? AND date = ?", type, Date.today ])
      for event in @events[type]
        event.venue ||= Location.find(:first, :conditions => ["name = ?", event.location])
      end
    end
    @names = NAMES
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
