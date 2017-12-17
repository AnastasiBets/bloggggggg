class ImagesController < ApplicationController
before_action :authenticate_user!
before_action :image_set, only:[:destroy, :vote]

	def index
    	@images = Image.all
    	@like = {}
    	@images.each do |image|
      		@voteforphotos = VoteForPhoto.where(image_id: image.id).sum(:like)
      		@like[image.id] = @voteforphotos
    	end
  	end

	def new

	end

	def create
		@user = current_user

		if params[:images]
			params[:images].each {|image|
				@files = @user.images.create(image: image)}
		end
		redirect_to images_path
	end

	def destroy
    	@image.destroy
    	redirect_to images_path
    end

    def voteforphoto
    @image = Image.find(params[:id])
    @voteforphoto = VoteForPhoto.where(user_id: current_user.id, image_id: @image.id).first
    if @voteforphoto == nil
       @like = 1
       VoteForPhoto.create(user_id: current_user.id, image_id: @image.id, like: @like)
     elsif @voteforphoto.like == 0
       @voteforphoto.update(like: @voteforphoto.like + 1)
     else
       @voteforphoto.update(like: @voteforphoto.like - 1)
    end
    redirect_to images_path
  end

private

def image_params
	params.require(:images).permit(:user_id, :image)
end

def image_set
    pp @image = Image.find(params[:id])
end

end