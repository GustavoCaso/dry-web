require 'yaml'

module Rodakase
  class Config
    extend Dry::Configurable

    def self.load(root, env)
      path = root.join('config').join('application.yml')

      return unless File.exist?(path)

      yaml = YAML.load_file(path)

      yaml.fetch(env.to_s).each do |key, value|
        setting key.downcase.to_sym, ENV.fetch(key, value)
      end

      config
    end
  end
end
