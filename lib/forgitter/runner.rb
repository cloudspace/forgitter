require 'forgitter'

module Forgitter
  class Runner
    def initialize(options = Forgitter::DEFAULT_OPTIONS)
      @ignorefiles = Forgitter.filter(options)
    end

    def run
      failcnt = 0
      output = ''
      @ignorefiles.each do |ignorefile|
        ignore_file = get_ignore_file(ignorefile[:path])
        if ignore_file
          output += "# #{ignorefile[:path]}\n"
          output += ignore_file
        else
          failcnt += 1
        end
      end
      exit(1) if failcnt == @ignorefiles.length

      puts output
    end

    private

    # Given a filename on the gitignore repo, return a string with the contents of the file
    def get_ignore_file(filename)
      begin
        IO.read(File.join(DATA_PATH, filename))
      rescue Errno::ENOENT
        STDERR.puts "#{filename} does not exist!"
        false
      end
    end
  end
end
