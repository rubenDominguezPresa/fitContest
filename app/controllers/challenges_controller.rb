class ChallengesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_challenge, only: [:show, :edit, :update, :destroy, :like]
  before_action :owned_challenge, only: [:edit, :update, :destroy]

  def index  
    #@posts = Post.of_followed_users(current_user.following).order('created_at DESC').page params[:page]
    @challenges = Challenge.order('created_at DESC').page params[:page]
    puts @challenges.last
    @challenge = Challenge.new
  end

  def show
    @post = Post.new
    @post.challenge=Challenge.find(params[:id])
    @posts=Post.find_by(challenge: params[:id])
  end

  def new
    @challenge = Challenge.new
  end

  def create
    @challenge = Challenge.new(challenge_params)
    @challenge.user=current_user
    puts @challenge
    if @challenge.save
      flash[:success] = "Your challenge has been created!"
      redirect_to root_path
    else
      flash[:alert] = "Your new challenge couldn't be created!  Please check the form."
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

  def challenge_params
    params.require(:challenge).permit(:image, :name)
  end

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  def owned_challenge
    unless current_user == @challenge.user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end
  
  def browse 
    
    @challenges = Post.all.order('created_at DESC').page params[:page]

  end  

end
