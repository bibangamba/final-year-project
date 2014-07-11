class JobsController < ApplicationController
  def new
	  @title="Post job"
	  @job = current_user.build_job
  end

  def create
  #build holds the entered details but does not save to the database.
		@job = current_user.build_job(params[:job])
		
		if @job.save
			flash[:success]="job posted"
			redirect_to root_path
		else
			render 'new'
		end
		
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
