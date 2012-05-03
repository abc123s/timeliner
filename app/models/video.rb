class Video < ActiveRecord::Base
  attr_accessible :title
  belongs_to :event
end
