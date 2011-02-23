class StackOverflowSearchesController < ApplicationController

  def index
    @stack_overflow_searches = StackOverflowSearch.all
  end
  
  def show
    @stack_overflow_search = StackOverflowSearch.find(params[:id])
  end

  def new
    @stack_overflow_search = StackOverflowSearch.new
  end

  def edit
    @stack_overflow_search = StackOverflowSearch.find(params[:id])
  end

  def create
    @stack_overflow_search = StackOverflowSearch.new(params[:stack_overflow_search])

    if @stack_overflow_search.save
      redirect_to(:root, :notice => 'Stack overflow search was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @stack_overflow_search = StackOverflowSearch.find(params[:id])

    if @stack_overflow_search.update_attributes(params[:stack_overflow_search])
      redirect_to(:root, :notice => 'Stack overflow search was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @stack_overflow_search = StackOverflowSearch.find(params[:id])
    @stack_overflow_search.destroy

    redirect_to(stack_overflow_searches_url)
  end
end
