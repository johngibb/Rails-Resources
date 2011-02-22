
module ApplicationHelper
  
  def header_link_to(title, url)
    link_to title, url, :class => 'bare'
  end
  
  def render_collection(items, options={})
    f = items.first
    if f
      plural = f.class.to_s.underscore.pluralize
      local = options[:as] || plural.to_sym
      render :partial => "#{plural}/#{plural}", :locals => { local => items }
    end
  end
  
  def render(*args)
    options = args.first
    if options.is_a? Hash and options.key? :shared
      options.merge! :partial => shared_partial_path(options.delete(:shared))
    end
    super *args
  end
  
  private
  
  def shared_partial_path(partial_name)
    "shared/#{partial_name}"
  end
end