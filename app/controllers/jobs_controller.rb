class JobsController < ApplicationController
  
	def index
		@title="Posted jobs"
		@jobs=Job.paginate(:page => params[:page])
	end
  
  def show
  	
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
end
