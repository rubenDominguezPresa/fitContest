class RelationshipsController < ApplicationController
  def follow_user
    @user = User.find_by! user_name: params[:user_name]
    if current_user.follow @user.id
      respond_to do |format|
  	  format.js {render inline: "location.reload();" }
       end
    end
  end

  def unfollow_user
    @user = User.find_by! user_name: params[:user_name]
    if current_user.unfollow @user.id
      respond_to do |format|
  	  format.js {render inline: "location.reload();" }
       end
    end
  end

  def follow_challenge
    puts params
    @challenge = Challenge.find_by! id: params[:id]

    if current_user.follow_challenge @challenge.id
      respond_to do |format|
      format.js {render inline: "location.reload();" }
       end
    end
  end

  def unfollow_challenge
    @Challenge = Challenge.find_by! id: params[:id]
    if current_user.unfollow_challenge @Challenge.id
      respond_to do |format|
      format.js {render inline: "location.reload();" }
       end
    end
  end
end
