# require 'dm-migrations'
# require 'data_mapper'
# require 'dm-postgres-adapter'
#
# require './app/models/tag.rb'

require './app/data_mapper_setup.rb'

class Bookmark

  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :url, String

  has n, :tags, through: Resource

  has 1, :user, :required => true

end

# DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
# DataMapper.finalize
# DataMapper.auto_upgrade!
