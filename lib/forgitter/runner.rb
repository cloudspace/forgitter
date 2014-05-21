require 'octokit'

module Forgitter
  class Runner
    def initialize(options = Forgitter::DEFAULT_OPTIONS)
      @types = convert_to_filenames(options[:types])
      @editors = convert_to_filenames(options[:editors])
      @stdout = options[:stdout]

      @client = Octokit
      @client = Octokit::Client.new(:access_token => options[:access_token]) unless options[:access_token].empty?
    end

    def run
      output = ""
      @types.each do |type|
        output += "# Information from #{type}\n"
        output += get_ignore_file(type)
      end
      @editors.each do |editor|
        output += "# Information from #{editor}\n"
        output += get_ignore_file(editor)
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
      puts "Getting #{filename}"
      api_response = @client.contents('github/gitignore', :ref => 'master', :path => filename)
      Base64.decode64( api_response.content )
    end

    # converts "rails" or "Rails" into "Rails.gitignore"
    def convert_to_filenames(names)
      names.map do |name|
        conversion_table[name.downcase.gsub(/[^+a-z]/i, '')]
      end.compact
    end

    def conversion_table
      @conversion_table ||= Forgitter::TYPES.merge(Forgitter::EDITORS)
    end
  end
end
