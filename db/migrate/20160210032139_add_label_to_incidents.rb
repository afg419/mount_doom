class AddLabelToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :label, :string
  end
end
