class ChangePostDateToRequirementsInJobs < ActiveRecord::Migration
  def change
  	remove_column :jobs, :post_date
	  add_column :jobs, :min_age, :string
	  add_column :jobs, :max_age, :string
	  add_column :jobs, :requirements, :text
  end
end
