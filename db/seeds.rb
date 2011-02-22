StackOverflowSearch.create :title => "Rails", :prefix => "[ruby-on-rails]"
StackOverflowSearch.create :title => "Ruby", :prefix => "[ruby]"
StackOverflowSearch.create :title => "Active Record", :prefix => "[activerecord]"

Link.create :title => "Rails API", :url => "http://api.rubyonrails.org/"
Link.create :title => "Migrations", :url => "http://api.rubyonrails.org/classes/ActiveRecord/Migration.html"
Link.create :title => "Paperclip", :url => "http://thewebfellas.com/blog/2008/11/2/goodbye-attachment_fu-hello-paperclip"
Link.create :title => "Observer", :url => "http://stackoverflow.com/questions/2242173/how-do-i-create-a-facebook-style-news-feed-in-ruby-on-rails/2247395#2247395"

Snippet.create :title => "ActiveRecord SQL to STDOUT", :content => <<-END
ActiveRecord::Base.logger = Logger.new(STDOUT)
END