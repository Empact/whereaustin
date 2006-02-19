class Event < ActiveRecord::Base
  belongs_to :venue, :class_name => "Location"
    
  def locate!
    self.venue ||= Location.find(:first, :conditions => ["name = ?", self.location])
  end
end

class Array
  def locate!
    self.each do |item|
      item.locate! if item.respond_to?(:locate!)
    end
  end
end