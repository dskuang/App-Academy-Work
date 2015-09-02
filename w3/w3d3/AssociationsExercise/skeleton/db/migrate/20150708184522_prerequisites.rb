class Prerequisites < ActiveRecord::Migration
  def change
    add_column :courses, :pre_req_id, :integer
  end
end
