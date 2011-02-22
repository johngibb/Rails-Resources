module LinksHelper
  def domain(url)
    url.gsub! /^http:\/\//, ''
    url.gsub! /\/.*$/, ''
  end
end
