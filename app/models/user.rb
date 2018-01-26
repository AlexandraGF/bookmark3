require './app/data_mapper_setup.rb'

class User

  include DataMapper::Resource

  property :id, Serial
  property :email, String
  property :password, String

  has n, :bookmarks, through: Resource

end
