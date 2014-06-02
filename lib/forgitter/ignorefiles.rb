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
  # Filter ignorefiles by tags.
  #
  # If tags is empty, this will return all ignorefiles.
  #
  # @param [Hash] the hash of options containing tag strings
  # @return [Array] the array of filtered ignorefiles
  #
  def self.filter(options = {})
    return ignorefiles if options[:tags].empty?

    ignorefiles.select do |ignorefile|
      selected = true
      options[:tags].uniq.each do |tag|
        selected &&= ignorefile[:tags].count(tag) >= options[:tags].count(tag)
      end
      selected
    end
  end

  ##
  # Fetch all available ignorefile paths, relative to the DATA_PATH.
  #
  # .gitignore files placed directly under DATA_PATH are ignored.
  #
  # @return [Array] the array of available ignorefile paths
  #
  def self.paths
    @@paths ||= Dir["#{DATA_PATH}/**/*.gitignore"].map do |path|
      path.sub("#{DATA_PATH}/", '')
    end.select do |path|
      path =~ /\//
    end
  end

  ##
  # Pull a parameterized ignorefile out of the given path.
  #
  # @param [String] the path to a .gitignore file
  # @return [String] the ignorefile
  #
  def self.ignorefile(path)
    parameterize(File.basename(path).sub('.gitignore', ''))
  end

  ##
  # Pull parameterized tags out of the given path.
  #
  # If path does not contain a /, this just returns the ignorefile name in an array.
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
    tags << ignorefile(path)
    tags
  end

  ##
  # Fetch all available ignorefiles.
  #
  # @return [Array] the array of available ignorefiles
  #
  def self.ignorefiles
    unless defined?(@@ignorefiles) && !@@ignorefiles.empty?
      @@ignorefiles = []

      paths.each do |path|
        @@ignorefiles << {
          :path => path,
          :name => ignorefile(path),
          :tags => tags(path)
        }
      end
    end
    @@ignorefiles
  end

  ##
  # Output a list of ignorefile tags along with the relative path to the gitignore,
  # formatted into columns.
  #
  # @param [Array] tags The list of tags to filter.
  #
  def self.list(tags = [])
    ignorefiles = filter({ :tags => tags })
    if ignorefiles.empty?
      puts 'No ignorefiles found!'
    else
      lines = []
      col1size = 0

      ignorefiles.each do |ignorefile|
        id = ignorefile[:tags].join(' ')
        col1size = id.length if id.length > col1size
        lines << [id, ignorefile[:path]]
      end

      lines.sort_by { |line| line[0] }.each do |line|
        printf("%-#{col1size}s\t%s\n", line[0], line[1])
      end
    end
  end
end
