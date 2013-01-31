require 'sinatra'
require 'haml'
require 'datamapper'
require 'pg'
require 'do_postgres'

class Item
  include DataMapper::Resource

  property :text, String,:key => true
end

configure do
  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/demo.db")
  DataMapper.finalize
  DataMapper.auto_migrate!

  Item.create(:text => "Hi")
  Item.create(:text => "there!")
end

get '/' do
  @demo = Item.all
  p @demo

  haml :view
end

