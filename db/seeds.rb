
#######################################################################################################
#                                     Roles Data
#######################################################################################################

Role.agent
Role.provider
Role.organiser

######################################################################################################
#                                     Organiser Data
#######################################################################################################
organiser = Role.find_by(label: 'organiser')
for i in 1..5
  first_name = Faker::Name.first_name
  user = User.new()
  user.username = first_name+i.to_s
  user.first_name = first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user.role_id = organiser.id
  user.password = first_name+i.to_s
  user.organisation = Faker::Company.name
  user.save
end

#######################################################################################################
#                                     Agent Data
#######################################################################################################
agent = Role.find_by(label: 'agent')
for i in 1..5
  first_name = Faker::Name.first_name
  user = User.new()
  user.username = first_name+i.to_s
  user.first_name = first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user.role_id = agent.id
  user.password = first_name+i.to_s
  user.organisation = Faker::Company.name
  user.save
end


#######################################################################################################
#                                     Agent Data
#######################################################################################################
provider = Role.find_by(label: 'provider')
for i in 1..5
  first_name = Faker::Name.first_name
  user = User.new()
  user.username = first_name + i.to_s
  user.first_name = first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user.role_id = provider.id
  user.password = first_name+i.to_s
  user.organisation = Faker::Company.name
  user.save
end


#######################################################################################################
#                                      AdvSpace Data
#######################################################################################################
User.where(role_id: provider.id).all.each do |provider|
  AdvSpace.create(name: user.organisation+" space", provider_id: provider.id)
end

#######################################################################################################
#                                      Slot Data
#######################################################################################################
AdvSpace.all.each do |space|
  2.times do |i|
    Slot.create(
      name: space.name+i.to_s,
      status: "draft",
      price: 100 * i,
      provider_id: space.provider_id,
      adv_space_id: space.id
      )
  end
end

#######################################################################################################
#                                      Bid Data
#######################################################################################################
Slot.all.each do |slot|
  2.times do |i|
    Bid.create(
      price: 200 * i,
      organiser_id: i,
      slot_id: slot.id
      )
  end
end
