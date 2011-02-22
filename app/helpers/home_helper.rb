module HomeHelper
  def section(header, link, options={}, &block)
    options.merge! :header => header, :link => link, :body => capture(&block)
    
    render :shared => :section, :locals => options
  end
end
