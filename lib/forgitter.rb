require 'forgitter/version'

require 'forgitter/runner'

module Forgitter
  class Generator
    def self.generate(types)
      types.each do |type|
        print "Fetching #{type} .gitignore..."
        STDOUT.flush

        # do stuff

        puts "done!"
      end

      print "Generating combined .gitignore..."
      STDOUT.flush

      # do stuff

      puts "done!"
    end
  end
end
