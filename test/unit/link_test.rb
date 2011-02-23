require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  test "domain" do
    l = links :rails
    assert_equal "api.rubyonrails.org", l.domain
  end
  
  test "secure domain" do
    l = links :devise
    assert_equal "github.com", l.domain
  end
end
