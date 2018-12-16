class Bid < ApplicationRecord
  belongs_to :slot
  belongs_to :organiser, class_name: 'User'
end
