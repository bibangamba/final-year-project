class ChangePhoneFormatInJobseekers < ActiveRecord::Migration
  def change
  	    change_column :jobseekers, :phone, :string
  end
end
