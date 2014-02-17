namespace :start do

  task :with_listeners => :environment do
    puts "Starting application on port #{ENV['PORT']} with listeners enabled"
    system "WITH_LISTENERS=true rails s -p #{ENV['PORT']}"
  end

  task :without_listeners => :environment do
    puts "Starting application with listeners disabled"
    system "WITH_LISTENERS=false rails s -p #{ENV['PORT']}"
  end

end
