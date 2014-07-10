# == Schema Information
#
# Table name: jobs
#
#  id              :integer          not null, primary key
#  employer_id     :string(255)
#  title           :string(255)
#  job_description :string(255)
#  category        :string(255)
#  location        :string(255)
#  vacancies       :integer
#  company         :string(255)
#  contact_phone   :string(255)
#  contact_email   :string(255)
#  post_date       :date
#  deadline        :datetime
#  job_type        :string(255)
#  experience      :integer
#  qualification   :string(255)
#  details         :text
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe Job do
  pending "add some examples to (or delete) #{__FILE__}"
end
