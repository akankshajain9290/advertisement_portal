
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

user = User.create(
  username: 'organiser',
  first_name: 'organiser',
  last_name: 'organiser',
  email: 'organiser@abc.com',
  password: '123',
  organisation: 'Organisation',
  role_id: organiser.id
  )

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

user = User.create(
        username: 'agent',
        first_name: 'agent',
        last_name: 'agent',
        email: 'agent@abc.com',
        password: '123',
        organisation: 'Agent Organisation',
        role_id: agent.id
        )


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
user = User.create(
        username: 'provider',
        first_name: 'provider',
        last_name: 'provider',
        email: 'provider@abc.com',
        password: '123',
        organisation: 'Provider Organisation',
        role_id: provider.id
        )

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
  AdvSpace.create(name: provider.organisation+" Space A", provider_id: provider.id)
  AdvSpace.create(name: provider.organisation+" Space B", provider_id: provider.id)
end

#######################################################################################################
#                                      Slot Data
#######################################################################################################
AdvSpace.all.each do |space|
  slot = Slot.create(
        status: "draft",
        price: 100 ,
        start_time: '2019-01-01 12:00:00',
        end_time: '2019-01-01 13:00:00',
        adv_space_id: space.id
        )

  slot = Slot.create(
          status: "draft",
          price: 150 ,
          start_time: '2019-01-01 13:00:00',
          end_time: '2019-01-01 15:00:00',
          adv_space_id: space.id
          )
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
