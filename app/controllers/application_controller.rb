class ApplicationController < ActionController::Base
  def hello
    render html: "Bye, world!"
  end
end
