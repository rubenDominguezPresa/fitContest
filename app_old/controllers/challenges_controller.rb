class ChallengesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_challenge, only: [:show, :edit, :update, :destroy, :like, :ranking]
  before_action :owned_challenge, only: [:edit, :update, :destroy]
  respond_to :html, :js

  def index  
    #@posts = Post.of_followed_users(current_user.following).order('created_at DESC').page params[:page]
    @challenges = Challenge.order('created_at DESC').page params[:page]
    @challenge = Challenge.new
  end

  def show
    @post = Post.new
    @track = Track.new
    @post.challenge=@challenge
    @posts = @challenge.posts.order('created_at DESC').page params[:page]
  end

  def new
    @challenge = Challenge.new
  end

  def ranking 
    @users = @challenge.followers
    render partial: 'layouts/ranking'
  end

  def create
    @challenge = Challenge.new(challenge_params)
    @challenge.user=current_user
    @challenge.ranking=Ranking.new
    puts @challenge
    if @challenge.save
      flash[:success] = "Your challenge has been created!"
      redirect_to(:back)
    else
      flash[:alert] = "Your new challenge couldn't be created!  Please check the form."
      render :new
    end
  end

  def edit
  end

  def update
    if @challenge.update(challenge_params)
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
    params.require(:challenge).permit(:image, :name, :category, :timing, :description, :rules)
  end

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  def owned_challenge
    unless current_user == @user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end
  
  def browse 
    @challenges = Post.all.order('created_at DESC').page params[:page]
  end

  def follow(challenge_id)  
    following_relationships.create(following_id: challenge_id)
  end

  def unfollow(challenge_id)
    following_relationships.find_by(following_id: challenge_id).destroy
  end 

end
