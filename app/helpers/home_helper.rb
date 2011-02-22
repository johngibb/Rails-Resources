module HomeHelper
  
  def section(model_class, options={}, &block)
    locals = { :title    => model_class.to_s.pluralize, 
               :link     => index_path(model_class),
               :new_link => new_path(model_class),
               :body     => capture(&block)
             }
             
    locals.merge! options

    render :shared => :section, :locals => locals
  end
  
  private
  
  def index_path(model_class)
    plural = model_class.to_s.underscore.pluralize
    function = "#{plural}_path"
    send function.to_sym
  end
  
  def new_path(model_class)
    singular = model_class.to_s.underscore
    function = "new_#{singular}_path"
    send function.to_sym
  end
end
