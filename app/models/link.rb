class Link < ActiveRecord::Base
  validates_presence_of :title, :url
  
  def domain
    domain = url.clone
    domain.gsub! %r'^https?://', ''
    domain.gsub! %r'/.*$', ''
  end
end
