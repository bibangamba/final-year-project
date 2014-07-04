class RenameCvNameInUsers < ActiveRecord::Migration
  def change
    rename_column :jobseekers, :cv_name, :cv_type
  end
end
