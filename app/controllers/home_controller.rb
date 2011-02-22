class HomeController < ApplicationController
  def index
    @searches = StackOverflowSearch.all
    @snippets = Snippet.all
    @links = Link.all
  end
end
