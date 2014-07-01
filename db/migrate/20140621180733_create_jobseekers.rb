class CreateJobseekers < ActiveRecord::Migration
  def change
    create_table :jobseekers do |t|
      t.integer :user_id
      t.date :dob
      t.string :sex
      t.string :location
      t.integer :phone
      t.string :qualification
      t.integer :experience
      t.string :field
      t.string :cv_name
      t.text :summary

      t.timestamps
    end
    add_index :jobseekers, :user_id
  end
end
