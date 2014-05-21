require 'forgitter'
require 'octokit'

module Forgitter
  class Runner
    def initialize(options = Forgitter::DEFAULT_OPTIONS)
      @types = convert_to_filenames(options[:types])
      @stdout = options[:stdout]

      @client = Octokit
      @client = Octokit::Client.new(:access_token => options[:access_token]) unless options[:access_token].empty?
    end

    def run
      output = ""
      @types.each do |type|
        ignore_file = get_ignore_file(type)
        if ignore_file
          output += "# Information from #{type}\n"
          output += ignore_file
        end
      end

      if @stdout
        puts output
      else
        File.open('.gitignore', 'w') do |file|
          file.write(output)
        end
      end
    end

    private

    # Given a filename on the gitignore repo, return a string with the contents of the file
    def get_ignore_file(filename)
      puts "Fetching #{filename}"
      begin
        api_response = @client.contents('github/gitignore', :ref => 'master', :path => filename)
        Base64.decode64( api_response.content )
      rescue Octokit::TooManyRequests
        puts "You are being rate limited! Failed to fetch #{filename}."
      end
    end

    # converts "rails" or "Rails" into "Rails.gitignore"
    def convert_to_filenames(names)
      names.map do |name|
        conversion_table[name.downcase.gsub(/[^+a-z]/i, '')]
      end.compact
    end

    def conversion_table
      Forgitter::TYPES
    end
  end
end
