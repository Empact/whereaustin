class Event < ActiveRecord::Base
  belongs_to :venue, :class_name => "Location"
  
  def find(*args)
    results = super.find(*args)
    result.each.each do |field|
      field = Iconv.iconv('UTF-8', 'windows-1252', field)
    end
    results
  end
    
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