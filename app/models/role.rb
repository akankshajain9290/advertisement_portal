class Role < ApplicationRecord
  has_many :users

  enum label: {
    agent: 'agent',
    provider: 'provider',
    organiser: 'organiser'
  }

  def self.agent
    self.find_or_create_by(label: :agent)
  end

  def self.provider
    self.find_or_create_by(label: :provider)
  end

  def self.organiser
    self.find_or_create_by(label: :organiser)
  end
end
