namespace :colorbox_helper do
  PLUGIN_ROOT = File.dirname(__FILE__) + '/../'
  desc 'Installs required javascript and css files in the public directory.'
  task :install do
    FileUtils.cp_r Dir[PLUGIN_ROOT + '/assets/stylesheets/*.css'], RAILS_ROOT + '/public/stylesheets'
    FileUtils.cp_r Dir[PLUGIN_ROOT + '/assets/javascripts/*.js'], RAILS_ROOT + '/public/javascripts'
    FileUtils.cp_r Dir[PLUGIN_ROOT + '/assets/javascripts/*'], RAILS_ROOT + '/public/images'
  end
end