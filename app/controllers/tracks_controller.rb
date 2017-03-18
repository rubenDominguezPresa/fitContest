class TracksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_track, only: [:show, :edit, :update, :destroy, :like, :ranking]
  before_action :owned_track, only: [:edit, :update, :destroy]
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
    @track = Track.new
  end

  def ranking 
    @ranking = @challenge.ranking
    render partial: 'layouts/ranking'
  end

  def create
    @track = Track.new(track_params)
    @track.user=current_user

    if (params[:challenge_id]!=nil)
      @track.challenge=Challenge.find(params[:challenge_id])
    end
    
    if @track.save
      post = Post.new
      post.image = @track.image
      post.caption = @track.comments
      post.challenge =@track.challenge
      post.user = current_user
      post.save
      flash[:success] = "Your track has been created!"
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

  def track_params
    params.require(:track).permit(:image, :tittle, :category, :date, :comments, :duration, :quantity)
  end

  def set_track
    @track = Track.find(params[:id])
  end

  def owned_track
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
    @challenge.ranking.users.push(current_user)
  end

  def unfollow(challenge_id)
    following_relationships.find_by(following_id: challenge_id).destroy
    @challenge.ranking.users.delete(current_user)
  end 

end
