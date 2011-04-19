class HomeController < ApplicationController
  skip_before_filter :verify_admin, :only => :myip
  
  def index
    @searches = StackOverflowSearch.all
    @snippets = Snippet.all
    @links = Link.all
  end
  
  def myip
    render :text => request.env["REMOTE_ADDR"]
  end
end
