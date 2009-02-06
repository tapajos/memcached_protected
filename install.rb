require 'fileutils'
FileUtils.cp(File.expand_path(File.dirname(__FILE__) + "/lib/cache_override.rb"), File.expand_path(File.dirname(__FILE__) + "/../../../config/initializers/cache_override.rb"))