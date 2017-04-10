class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index  
    @posts = Post.of_followed_users(current_user.following).order('created_at DESC').page params[:page]
    @posts = @posts+(current_user.posts.order('created_at DESC').page params[:page])
    challenges = current_user.challenges
    challenge_posts=[]
    challenges.each do |challenge|
      challenge_posts=challenge_posts+(challenge.posts.order('created_at DESC').page params[:page])
    end
    @posts=@posts+challenge_posts
    @posts.sort {|a,b| a.created_at <=> b.created_at}
    @posts=Kaminari.paginate_array(@posts).page(params[:page])
    @post = current_user.posts.build
    @users = User.all
  end

  def show
    
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Your post has been created!"
      if @post.challenge==nil
        redirect_to root_path
      else
        redirect_to(:back)
      end
    else
      flash[:alert] = "Your new post couldn't be created!  Please check the form."
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated."
      redirect_to root_path
    else
      flash[:alert] = "Update failed.  Please check the form."
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Your post has been deleted."
    redirect_to root_path
  end

  def like
    if @post.liked_by current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption, :challenge_id)
  end

  def set_post
    @post = Post.find(params[:id])
    if params[:challenge_id]!=nil
      @post.challenge=Challenge.find(params[:id])
      params.delete :challenge_id
    end
  end

  def owned_post
    unless current_user == @post.user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end
  
  def browse 
    @posts = Post.all.order('created_at DESC').page params[:page]
  end  

end
