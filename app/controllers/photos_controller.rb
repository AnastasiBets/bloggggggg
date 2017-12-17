class PhotosController < ApplicationController
	before_action :authenticate_user!
 	before_action :photo_set, only:[:show, :edit, :update, :destroy, :vote]

	def index
		@photos = Photo.all	
		@like = {}
		@photos.each do |photo|
			@votes = Vote.where(photo_id: photo.id).sum(:like)
			@like[photo.id] = @votes
		end
	end

	def new
		@photo = Photo.new
	end

	def create	
		params[:photo][:category_id] = params[:category_id]
		params[:photo][:user_id] = current_user.id
		pp @photo = Photo.create(photo_params)
		redirect_to photos_path
	end

	def edit

  	end

	def update		
		params[:photo][:user_id] = @photo.user_id
    	params[:photo][:category_id] = @photo.category_id
    	@photo.update(photo_params)
    	redirect_to 'photos'
  	end

	def destroy		
 		@photo.destroy
 		redirect_to photos_path
  	end

  def vote
    @photo = Photo.find(params[:id])
    @vote = Vote.where(user_id: current_user.id, photo_id: @photo.id).first
    if @vote == nil
       @like = 1
       Vote.create(user_id: current_user.id, photo_id: @photo.id, like: @like)
    elsif @vote.like == 0
         @vote.update(like: @vote.like + 1)
    else
       @vote.update(like: @vote.like - 1)
    end
    redirect_to photos_path
  end

private

	def photo_params
		params.require(:photo).permit(:user_id, :category_id,:name, :photo)
	end

	def photo_set
		pp @photo = Photo.find(params[:id])
  		
  	end

end