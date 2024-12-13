class AddDefaultStatusToUser < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :status, from: nil, to: 1
  end
end
