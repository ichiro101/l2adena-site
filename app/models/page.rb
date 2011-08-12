class Page < ActiveRecord::Base

  acts_as_list

  validates_presence_of :name
  validates_presence_of :content

end
