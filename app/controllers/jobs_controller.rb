class JobsController < ApplicationController

  protect_from_forgery :except => [:mobile_post, :mobile_get]#excludes them from csrf
  
  
	def index
		@title="Posted jobs"		
		#@jobs = Job.find_all_by_employer_id(current_user.id)#deprecated?basically heroku returns an error on running it like this
		@jobs = Job.where(:employer_id => current_user.id)		
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
  
  def mobile_post
  	@employer = params[:Employer_id]
  	@title = params[:Job_Tittle]
  	@desc = params[:Description]
  	@category = params[:Category]
  	@location = params[:Location]
  	@job_type = params[:Job_Type]
  	@vacancies = params[:Vacancies]
  	@deadline = params[:DeadLine]
  	@contact_phone = params[:Contact_phone]
  	@contact_email = params[:Contact_email]
  	@company = params[:Company]
  	@qualification = params[:Qualification]
  	@experience = params[:Experience]
  	@max_age = params[:Max]
  	@min_age = params[:Min]
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
  								:company=>@company,
  								:qualification=>@qualification,
  								:experience=>@experience,
  								:min_age=>@min_age.to_i,
  								:max_age=>@max_age.to_i,
  								:requirements=>@requirements,
  								:details=>@details
  	)
		
		if @job.save!
			response = {"Success" => "New Job Successfully Posted!!" }
			response = {"info" => "New Job Successfully Posted!!" }
		else
			response = {"error" => true, "Error" => "Failed to Post Job!"}
			response = {"info" => "Failed to Post Job!" }
		end
		
		render :json => response
  end
  
  
  
  def mobile_get
  	@last = params[:Last_job]
  	@post_id = params[:Jobseeker]
  	
  	#get jobs for specific user  	
  	jobseeker = Jobseeker.find_by_user_id(@post_id)
		preferred_field = jobseeker.field#if no profile created yet, should have 'none' in the table(field column) so all or no jobs comes since there is no preferred job field
		@jobs = Job.where('category LIKE ?', preferred_field)
		
  	if @last.to_i < 1
  		@select = @jobs.all
  		status = {"info" => @select}
  	elsif @last.to_i < @jobs.last.id
  		@select = @jobs.where("id >= ?", @post_id)
  		status = {"info" => @select}
  	elsif @last.to_i >= @jobs.last.id
  		status = {"info" => "No updates"}
  	end
  	
  	render :json => status
  	
  	
  	
  end
  
end
