class AddRecurringEventColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :next_date, :datetime
    add_column :events, :occurrence, :string, default: "none"
  end
end
