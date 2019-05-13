class CreateRides < ActiveRecord::Migration[5.2]
  def change
    create_table :rides do |t|
      t.string :token, null: false, index: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
