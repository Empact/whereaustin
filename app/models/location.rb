class Location < ActiveRecord::Base
  has_many :events, :order => 'date DESC'
  has_many :sxsw,   :order => 'location ASC'
end
