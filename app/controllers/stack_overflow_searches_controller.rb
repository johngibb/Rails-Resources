class StackOverflowSearchesController < ApplicationController
  # GET /stack_overflow_searches
  # GET /stack_overflow_searches.xml
  def index
    @stack_overflow_searches = StackOverflowSearch.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stack_overflow_searches }
    end
  end

  # GET /stack_overflow_searches/1
  # GET /stack_overflow_searches/1.xml
  def show
    @stack_overflow_search = StackOverflowSearch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stack_overflow_search }
    end
  end

  # GET /stack_overflow_searches/new
  # GET /stack_overflow_searches/new.xml
  def new
    @stack_overflow_search = StackOverflowSearch.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @stack_overflow_search }
    end
  end

  # GET /stack_overflow_searches/1/edit
  def edit
    @stack_overflow_search = StackOverflowSearch.find(params[:id])
  end

  # POST /stack_overflow_searches
  # POST /stack_overflow_searches.xml
  def create
    @stack_overflow_search = StackOverflowSearch.new(params[:stack_overflow_search])

    respond_to do |format|
      if @stack_overflow_search.save
        format.html { redirect_to(@stack_overflow_search, :notice => 'Stack overflow search was successfully created.') }
        format.xml  { render :xml => @stack_overflow_search, :status => :created, :location => @stack_overflow_search }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @stack_overflow_search.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stack_overflow_searches/1
  # PUT /stack_overflow_searches/1.xml
  def update
    @stack_overflow_search = StackOverflowSearch.find(params[:id])

    respond_to do |format|
      if @stack_overflow_search.update_attributes(params[:stack_overflow_search])
        format.html { redirect_to(@stack_overflow_search, :notice => 'Stack overflow search was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @stack_overflow_search.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stack_overflow_searches/1
  # DELETE /stack_overflow_searches/1.xml
  def destroy
    @stack_overflow_search = StackOverflowSearch.find(params[:id])
    @stack_overflow_search.destroy

    respond_to do |format|
      format.html { redirect_to(stack_overflow_searches_url) }
      format.xml  { head :ok }
    end
  end
end
