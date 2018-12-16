class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :label
      t.timestamps
    end

    Role.agent
    Role.provider
    Role.organiser
  end
end
