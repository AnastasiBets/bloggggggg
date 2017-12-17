class PostcommentsController < ApplicationController
before_action :authenticate_user!
before_action :find_post, only:[:update, :edit]
before_action :set_comment, only:[:edit, :update, :destroy]

  def create
    params[:postcomment][:post_id] = params[:post_id]
    params[:postcomment][:user_id] = current_user.id
    @comment = Postcomment.create(comment_params)
    if @comment.save
      redirect_to post_path(params[:post_id])
      else
        @comment.errors.full_messages.each do |msg|
          @msg = msg
      end
      flash[:notice] = "#{@msg}"
      redirect_to post_path(params[:post_id])
    end
  end

  def edit
    
  end

  def update
    if pp @comment.update(comment_params)
        redirect_to post_path(params[:post_id])
    else
      render 'edit'
    end
  end

  def destroy 
    @comment.destroy
    redirect_to post_path(params[:post_id])
  end

private

  def comment_params
    params.require(:postcomment).permit(:user_id, :post_id, :comment)
  end

  def set_comment  
    pp @comment = Postcomment.find(params[:id])
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end