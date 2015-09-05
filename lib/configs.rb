class Configs
  def self.fetch(key)
    ENV[key.to_s] || raise("`ENV['#{key}']` has not been set")
  end
end
