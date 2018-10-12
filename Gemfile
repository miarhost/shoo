source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'ruby-trello', '~> 2.1'
# is responsible for trello secrets 
gem 'figaro', '~> 1.1', '>= 1.1.1'