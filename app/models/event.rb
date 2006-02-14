class Event < ActiveRecord::Base
  belongs_to :venue, :class_name => "Location"
end
