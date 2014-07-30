class ChangeEmpoyerIdToInteger < ActiveRecord::Migration
  def change
	  change_column :jobs, :employer_id, :integer#'integer USING CAST(employer_id AS integer)'
	  change_column :jobs, :deadline, :date
  end
end
