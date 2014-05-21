require 'octokit'

module Forgitter
  class Runner
    DEFAULT_TYPES = ['Rails']
    DEFAULT_EDITORS = ['Eclipse', 'Emacs', 'OSX', 'Linux', 'Xcode', 'vim', 'TextMate', 'SublimeText']

    def initialize(types = DEFAULT_TYPES, text_editors = DEFAULT_EDITORS)
      @types = inflectionize_types(types)
      @editors = inflectionize_editors(text_editors)
    end

    def run
      output = ""
      @types.each do |type|
        output += get_ignore_file(type)
      end
      @editors.each do |editor|
        output += get_ignore_file(editor)
      end
      File.open('.gitignore', 'w') do |file|
        file.write(output)
      end
    end

    private

    # Given a filename on the gitignore repo, return a string with the contents of the file
    def get_ignore_file(filename)
      api_response = Octokit.contents('github/gitignore', :ref => 'master', :path => filename)
      Base64.decode64( api_response.content )
    end

    # to be writen later
    # converts "rails" or "Rails" into "Rails.gitignore"
    def inflectionize_types(types)
      types
      ['Rails.gitignore']
    end

    # Converts "vim" or "Vim" into "Global/vim.gitignore"
    # note that the capitalization is not consistent for this section
    def inflectionize_editors(editors)
      editors
      ['Global/vim.gitignore']
    end
  end
end
