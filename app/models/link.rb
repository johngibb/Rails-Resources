class Link < ActiveRecord::Base
  validates_presence_of :title, :url
  
  def domain(url)
    url = url.gsub %r'^http://', ''
    url = url.gsub %r'/.*$', ''
  end
end
