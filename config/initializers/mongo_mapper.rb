database_config_file = File.join(Rails.root, "/config/database.mongo.yml")
yaml_content = File.read(database_config_file)
db_config = YAML::load(yaml_content)

if ENV['MONGOHQ_URL'] then
  require 'uri'
  uri = URI.parse(ENV['MONGOHQ_URL'])
  MongoMapper.connection = Mongo::Connection.new(uri.host, uri.port)
  MongoMapper.database = uri.path.gsub(/^\//, '')
elsif db_config[Rails.env] && db_config[Rails.env]['adapter'] == 'mongodb'
  mongo = db_config[Rails.env]
  MongoMapper.connection = Mongo::Connection.new(mongo['host'])
  MongoMapper.database = mongo['database']
end
