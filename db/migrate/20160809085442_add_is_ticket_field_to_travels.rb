class AddIsTicketFieldToTravels < ActiveRecord::Migration
  def change
    add_column :travels, :is_ticket, :boolean
  end
end
