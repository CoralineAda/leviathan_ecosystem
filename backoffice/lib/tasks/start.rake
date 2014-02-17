task :start => :environment do
  puts "Starting application on port #{ENV['PORT']}"
  system "rails s -p #{ENV['PORT']}"
end
