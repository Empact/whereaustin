class Location < ActiveRecord::Base
  has_many :events, :order => 'date DESC'
  
  def find(*args)
    results = super.find(*args)
    result.each.each do |field|
      field = Iconv.iconv('UTF-8', 'windows-1252', field)
    end
    results
  end
end
