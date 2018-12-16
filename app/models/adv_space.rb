class AdvSpace < ApplicationRecord
  belongs_to :adv_provider, class_name: 'User'
  has_many :slots
end
