class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :owned_profile, only: [:edit, :update]

  def show
    @posts = @user.posts.order('created_at DESC')
  end

  def edit
  end

  def update
    if @user.update(profile_params)
      flash[:success] = 'Your profile has been updated.'
      redirect_to profile_path(@user.user_name)
    else
      @user.errors.full_messages
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end

  def track 
    puts "track"
    @track = Track.new
    @track.user=@user
    render partial: 'tracks/form', challenge: @challenge
  end

  def calendar 
    puts "calendar"
    tracks = @user.tracks
    @events = []
    tracks.each do |track|
      @events << {id: track.id, :title => track.user.user_name+" registro: "+track.duration+" hr", :start => track.date, :icon => track.user.avatar.url,:textColor => '#757770', :backgroundColor =>'#e8e8e8'}
    end
      
    #@task = current_user.tasks
    
    #@task.each do |task|
    #@events << {:id => "1", :title => "prueba running", :start => "2017-03-13",:end => "2017-03-15", :color => 'red'}
    #end
    #render :text => events.to_json
    render partial: 'layouts/calendar', events: @events
  end

  def sessions
    @posts=@user.tracks
  end
  private

  def profile_params
    params.require(:user).permit(:avatar, :bio)
  end

  def owned_profile
    unless current_user == @user
      flash[:alert] = "That profile doesn't belong to you!"
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find_by(user_name: params[:user_name])
  end

  def follow(user_id)  
    following_relationships.create(following_id: user_id)
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end
end
