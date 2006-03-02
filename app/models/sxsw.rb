class Sxsw < ActiveRecord::Base
  set_table_name("sxsw")
  belongs_to :venue, :class_name => "Location", :foreign_key => "venue_id"
end
