require 'debugger'
module Forgitter
  ##
  # Strip unnecessary characters and downcase the given string.
  #
  # @param [String] any string
  # @return [String] the "parameterized" string
  #
  def self.parameterize(str)
    str.gsub(/[^a-z0-9+]+/i, '').downcase
  end

  ##
  # Filter types by tags.
  #
  # If tags is empty, this will return all types.
  #
  # @param [Array] the array of type names and/or tag strings
  # @return [Array] the array of filtered types
  #
  def self.filter_types(tags = [])
    types.select do |type|
      tags.empty? || (tags - type[:tags]).empty? || tags.include?(type[:name])
    end
  end

  ##
  # Fetch all available type paths, relative to the DATA_PATH.
  #
  # @return [Array] the array of available type paths
  #
  def self.paths
    @@paths ||= Dir["#{DATA_PATH}/**/*.gitignore"].map do |path|
      path.sub("#{DATA_PATH}/", '')
    end
  end

  ##
  # Pull a parameterized type out of the given path.
  #
  # @param [String] the path to a .gitignore file
  # @return [String] the type
  #
  def self.type(path)
    parameterize(File.basename(path).sub('.gitignore', ''))
  end

  ##
  # Pull parameterized tags out of the given path.
  #
  # If path does not contain a /, this returns an empty array.
  #
  # @param [String] the path to a .gitignore file
  # @return [Array] the tags
  #
  def self.tags(path)
    tags = []
    if path =~ /\//
      tags = path.sub("/#{File.basename(path)}", '').split('/')
      tags.map! do |tag|
        parameterize(tag)
      end
    end
    tags
  end

  ##
  # Fetch all available types.
  #
  # @return [Array] the array of available types
  #
  def self.types
    unless defined?(@@types) && !@@types.empty?
      @@types = []

      paths.each do |path|
        @@types << {
          :path => path,
          :name => type(path),
          :tags => tags(path)
        }
      end
    end
    @@types
  end

  def self.list_types(tags = [])
    types = filter_types(tags)
    if types.empty?
      puts 'No types found!'
    else
      lines = []
      col1size = 0

      types.each do |type|
        col1size = type[:name].length if type[:name].length > col1size
        lines << [type[:name], type[:path]]
      end

      lines.sort_by { |line| line[0] }.each do |line|
        printf("%-#{col1size}s\t%s\n", line[0], line[1])
      end
    end
  end
end
