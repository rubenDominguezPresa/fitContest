class ChallengesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_challenge, only: [:show, :edit, :update, :destroy, :like, :ranking, :posts, :track, :calendar]
  before_action :owned_challenge, only: [:edit ,:update, :destroy]
  respond_to :html, :js

  def edit
    
  end

  def index  
    #@posts = Post.of_followed_users(current_user.following).order('created_at DESC').page params[:page]
    @challenges = Challenge.order('created_at DESC').page params[:page]
    @challenge = Challenge.new
  end

  def show
    @post = Post.new
    @track = Track.new
    @post.challenge=@challenge
    @creator = User.find(@challenge.creator)
    @posts = @challenge.posts.order('created_at DESC').page params[:page]
  end

  def new
    @challenge = Challenge.new
  end

  def ranking 
    puts "ranking"
    @users = @challenge.users
    tracks = @challenge.tracks
    duration=0
    distance=0
    quantity=0
    @result=[]
    @users.each do |user|
      user.tracks.each do |track|
        if tracks.include?(track)
          if duration=0 
            duration=track.duration
          else
            duration= duration.to_time + (track.duration.to_time.hour).hour
            duration= duration.to_time + (track.duration.to_time.min).minutes
            duration= duration.to_time + (track.duration.to_time.sec).seconds
          end 
          if (track.distance !=nil)
            distance=distance+track.distance
          end
          if (track.quantity !=nil)
            quantity=quantity+track.quantity
          end
        end
      end
      @result<<{:user=>user, :duration=>duration.strftime("%H:%M:%S"), :distance=>distance, :quantity=>quantity }
    end
    render partial: 'layouts/ranking'
  end

  def track 
    puts "track"
    @track = Track.new
    @track.challenge=@challenge
    @track.user=current_user
    render partial: 'tracks/form', challenge: @challenge
  end

  def calendar 
    puts "calendar"
    tracks = @challenge.tracks
    @events = []
    tracks.each do |track|
      @events << {id: track.id, :title => track.user.user_name+" registro: "+track.duration.strftime("%H:%M:%S")+" hr", :start => track.date, :icon => track.user.avatar.url,:textColor => '#757770', :backgroundColor =>'#e8e8e8'}
    end
      
    #@task = current_user.tasks
    
    #@task.each do |task|
    #@events << {:id => "1", :title => "prueba running", :start => "2017-03-13",:end => "2017-03-15", :color => 'red'}
    #end
    #render :text => events.to_json
    render partial: 'layouts/calendar', events: @events
  end

  def posts
    puts "posts"
    @post = Post.new
    @post.challenge=@challenge
    @posts = @challenge.posts.order('created_at DESC').page params[:page]
    render partial: 'posts/posts', posts: @posts
  end

  def create
    @challenge = Challenge.new(challenge_params)
    #@challenge.start_date=params[:start_date].to_date
    #@challenge.end_date=params[:end_date].to_date
    @challenge.ranking=Ranking.new
    @challenge.users.push(current_user)
    @challenge.creator=current_user.id
    if @challenge.save
      flash[:success] = "Your challenge has been created!"
      redirect_to challenges_path
    else
      flash[:alert] = "Your new challenge couldn't be created!  Please check the form."
      render :new
    end
  end

  def update
    
    if @challenge.update(challenge_params)
      #@challenge.start_date=params[:start_date].to_date
      #@challenge.end_date=params[:end_date].to_date
      flash[:success] = "Reto actualizado."
      redirect_to challenges_path
    else
      flash[:alert] = "Update failed.  Please check the form."
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Your challenge has been deleted."
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
    params.require(:challenge).permit(:image, :name, :category, :timing, :description, :rules, :start_date, :end_date)
  end

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  def owned_challenge
    unless current_user.id == @challenge.creator
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end
  
  def browse 
    @challenges = Post.all.order('created_at DESC').page params[:page]
  end

  def follow(challenge_id)  
    #.create(following_id: challenge_id)
    @challenge.users.push=current_user
    current_user.challenges.push=@challenge

  end

  def unfollow(challenge_id)
    @challenge.users.delete=current_user
    current_user.challenges.delete=@challenge
  end 

end
