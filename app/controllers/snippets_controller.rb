class SnippetsController < ApplicationController

  def index
    @snippets = Snippet.all
  end

  def show
    @snippet = Snippet.find(params[:id])
  end

  def new
    @snippet = Snippet.new
  end

  def edit
    @snippet = Snippet.find(params[:id])
  end

  def create
    @snippet = Snippet.new(params[:snippet])
    if @snippet.save
      redirect_to(:root, :notice => 'Snippet was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @snippet = Snippet.find(params[:id])
    if @snippet.update_attributes(params[:snippet])
      redirect_to(:root, :notice => 'Snippet was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @snippet = Snippet.find(params[:id])
    @snippet.destroy

    redirect_to(snippets_url)
  end
end
