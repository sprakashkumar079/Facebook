#home controller for first page 
class StaticPagesController < ApplicationController
	#if user is login than the micropost create
	#root_path
	def home
		if sign_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
	end
end
