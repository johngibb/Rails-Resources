module HomeHelper
  def section(header, options={}, &block)
    options.merge! :header => header, :body => capture(&block)
    
    render :shared => :section, :locals => options
  end
end
