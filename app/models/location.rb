class Location < ActiveRecord::Base
  has_many :events, :order => 'date DESC'
end
