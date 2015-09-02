class RemovePrereqIdFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :pre_req_id
  end
end
