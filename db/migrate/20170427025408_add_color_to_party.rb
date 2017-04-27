class AddColorToParty < ActiveRecord::Migration[5.0]
  def change
    add_column :parties, :color, :string
  end
end
