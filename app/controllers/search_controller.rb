class SearchController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :js

  def find
  	@challenges=Challenge.search(params[:search][:text]).order("created_at DESC")
  	@users=User.search(params[:search][:text]).order("created_at DESC") 
  	@results=@challenges+@users
  	@results.sort {|a,b| a.created_at <=> b.created_at}
  	puts @results.count
  	#@results=@challenges
  end

  private

  def search_params
    params.require(:search).permit(:text)
  end
end