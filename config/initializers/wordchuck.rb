pwd = YAML.load_file("config/pwd.yml")
Wordchuck.configure do |config|
  config.project_key = pwd['wordchuck']
end