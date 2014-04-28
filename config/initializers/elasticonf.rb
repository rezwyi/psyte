ElastiConf.configure do |config|
  config.config_root = Rails.root.join('config')
  config.config_file = 'settings'
  config.const_name = 'Settings'
end

ElastiConf.load! Rails.env