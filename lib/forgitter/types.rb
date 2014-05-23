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
  # Filter types by tags, then by name.
  #
  # If tags is empty, this will return all types.
  #
  # @param [Hash] the hash of options containing tag strings
  # @return [Array] the array of filtered types
  #
  def self.filter_types(options = {})
    return types if options[:tags].empty?

    types.select do |type|
      selected = true
      options[:tags].uniq.each do |tag|
        selected &&= type[:tags].count(tag) >= options[:tags].count(tag)
      end
      selected
    end
  end

  ##
  # Fetch all available type paths, relative to the DATA_PATH.
  #
  # .gitignore files placed directly under DATA_PATH are ignored.
  #
  # @return [Array] the array of available type paths
  #
  def self.paths
    @@paths ||= Dir["#{DATA_PATH}/**/*.gitignore"].map do |path|
      path.sub("#{DATA_PATH}/", '')
    end.select do |path|
      path =~ /\//
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
  # If path does not contain a /, this just returns the type name in an array.
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
    tags << type(path)
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
    types = filter_types({ :tags => tags })
    if types.empty?
      puts 'No types found!'
    else
      lines = []
      col1size = 0

      types.each do |type|
        id = type[:tags].join(' ')
        col1size = id.length if id.length > col1size
        lines << [id, type[:path]]
      end

      lines.sort_by { |line| line[0] }.each do |line|
        printf("%-#{col1size}s\t%s\n", line[0], line[1])
      end
    end
  end
end
