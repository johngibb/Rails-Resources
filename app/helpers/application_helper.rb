module ApplicationHelper
  
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