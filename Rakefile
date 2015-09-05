require 'dotenv'
Dotenv.load('.env.test')

require_relative './lib/all'

desc "Run the updater"
task :run do
  Runner.new.run
end

desc "You need a valid key so that we can send stuff to trello"
task :init do
  api_key = Configs.fetch('TRELLO_API_KEY')
  puts "Visit the following URL in your browser:"
  puts "https://trello.com/1/authorize?key=#{api_key}&scope=read,write&response_type=token&expiration=never"
  puts "And save the resulting token in .env as TRELLO_MEMBER_TOKEN"
end

desc "Run the console"
task :console do
  require 'irb'
  require 'irb/completion'
  ARGV.clear
  IRB.start
end
