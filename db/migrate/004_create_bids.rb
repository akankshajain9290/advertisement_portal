class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      t.float :price
      t.belongs_to :organiser, index: true
      t.belongs_to :slot, index: true
      t.timestamps
    end
  end
end
