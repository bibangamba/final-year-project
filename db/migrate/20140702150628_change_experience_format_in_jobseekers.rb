class ChangeExperienceFormatInJobseekers < ActiveRecord::Migration
  def change
  	    change_column :jobseekers, :experience, :string
  end
end
