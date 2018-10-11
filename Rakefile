Dir[File.expand_path(File.dirname(__FILE__)) + "/lib/tasks/**/*.rake"].sort.each { |ext| load ext }

RedminePluginSupport::Base setup do |plugin|
	plugin.name = 'shoo'
	plugin.tasks = [:db, :setup]
end

rescue LoadError
  puts "You have to install redmine first, git pull from 'https://github.com/redmine/redmine.git'"
exit 1
end
