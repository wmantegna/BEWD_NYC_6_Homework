class Beer < ActiveRecord::Base
	validates :name, :beer_style_id, :dateBrewed, presence: true
	belongs_to :beer_style
end