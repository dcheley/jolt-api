class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false

      t.references :offer, foreign_key: true
    end
  end
end
