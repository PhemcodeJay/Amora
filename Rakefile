# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

# Custom tasks
namespace :app do
  desc "Setup the application"
  task setup: :environment do
    puts "Creating database..."
    Rake::Task["db:create"].invoke
    
    puts "Running migrations..."
    Rake::Task["db:migrate"].invoke
    
    puts "Seeding database..."
    Rake::Task["db:seed"].invoke
    
    puts "Setup complete!"
  end
  
  desc "Clean up expired sessions and old notifications"
  task cleanup: :environment do
    puts "Cleaning up old notifications..."
    Notification.where('created_at < ?', 30.days.ago).destroy_all
    
    puts "Cleaning up expired sessions..."
    Session.where('updated_at < ?', 30.days.ago).destroy_all
    
    puts "Cleanup complete!"
  end
end