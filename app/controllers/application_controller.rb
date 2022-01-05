#appliction controller for project
class ApplicationController < ActionController::Base
	def hello
      render html: "hello, world!"
    end
end
