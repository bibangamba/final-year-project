class JobsController < ApplicationController
  
	def index
		@title="Posted jobs"		
		@jobs = Job.find_all_by_employer_id(current_user.id)		
		#@jobs.paginate(:page => params[:page])
	end
  
  def show
  	@job = Job.find(params[:id])
  	@title = @job.title  	
  end
  
  def new
	  @title="Post job"
	  @job = current_user.job.build
  end

  def create
  #build holds the entered details but does not save to the database.
		@job = current_user.job.build(params[:job])
		
		if @job.save
			flash[:success]="Job posted"
			redirect_to jobs_path
		else
			render 'new'
		end
		
  end

  def edit
  @title = "Edit job"
  @job = Job.find(params[:id])
  end

  def update
  	@job = Job.find(params[:id])
  	
  	if @job.update_attributes(params[:job])
  		flash[:success]="updated the job"
  		redirect_to jobs_path
  	else
  		@title="Edit job"
  		render 'edit'
  	end
  end

  def destroy
  	@job = Job.find(params[:id])
  	@job.destroy
  	flash[:success]="Job deleted!"
  	redirect_to jobs_path
  end
  
  def mobile
  	@employer = params[:user]
  	@title = params[:Job_Tittle]
  	@desc = params[:Job_desc]
  	@category = params[:Category]
  	@location = params[:Location]
  	@job_type = params[:Job_Type]
  	@vacancies = params[:Vacancies]
  	@deadline = params[:Deadline]
  	@contact_phone = params[:Contact_phone]
  	@contact_email = params[:Contact_email]
  	@company = params[:Company]
  	@qualification = params[:Qualification]
  	@experience = params[:Experience]
  	@max_age = params[:Max_age]
  	@min_age = params[:Min_age]
  	@requirements = params[:Requirements]
  	@details = params[:Details]
  	
  	
  	user = User.find(@employer.to_i)
  	
  	#load data from mobile, to be saved under employer_id of logged in user.
  	@job = user.job.build(
  								:title=>@title,
  								:job_description=>@desc,
  								:category=>@category,
  								:location=>@location,
  								:job_type=>@job_type,
  								:vacancies=>@vacancies,
  								:deadline=>@deadline,
  								:contact_phone=>@contact_phone,
  								:contact_email=>@contact_email,
  								:company=>@@company,
  								:qualification=>@qualification,
  								:experience=>@experience,
  								:min_age=>@min_age,
  								:max_age=>@max_age,
  								:requirements=>@requirements,
  								:details=>@details
  	)
		
		if @job.save
			response = {"Success" => "New Job Successfully Posted!!" }
		else
			response = {"error" => true, "Error" => "Failed to Post Job!"}
		end
		
		render :json => response
  end
  
end
