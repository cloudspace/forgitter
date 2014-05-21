require 'forgitter/version'

module Forgitter
  class Generator
    def generate(types)
      types.each do |type|
        puts "Fetching #{type} .gitignore..."
      end
      print "Generating combined .gitignore..."
      STDOUT.flush
      puts "done!"
    end
  end
end
