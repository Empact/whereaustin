class Event < ActiveRecord::Base
  belongs_to :venue, :class_name => "Location", :foreign_key => "venue_id"
end