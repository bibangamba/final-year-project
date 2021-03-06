class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :employer_id
      t.string :title
      t.string :job_description
      t.string :category
      t.string :location
      t.integer :vacancies
      t.string :company
      t.string :contact_phone
      t.string :contact_email
      t.date :post_date
      t.datetime :deadline
      t.string :job_type
      t.integer :experience
      t.string :qualification
      t.text :details

      t.timestamps
    end
  end
end
