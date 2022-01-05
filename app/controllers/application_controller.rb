#appliction controller for project
class ApplicationController < ActionController::Base
    #this is simple action call for first time
	def hello
      render html: "hello, world!"
    end
end
