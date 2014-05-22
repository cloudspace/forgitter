module Forgitter
  def self.parameterize(name)
    name.gsub(/[^a-z0-9+]+/i, '').downcase
  end

  def self.types
    unless defined?(@@types) && !@@types.empty?
      @@types = []

      paths = Dir["#{DATA_PATH}/**/*.gitignore"].map { |f| f.sub("#{DATA_PATH}/", '') }
      paths.each do |path|
        type = parameterize(File.basename(path).sub('.gitignore', ''))
        tags = []
        tags = path.sub("/#{File.basename(path)}", '').split('/').map { |tag| parameterize(tag) } if path =~ /\//

        @@types << {
          :path => path,
          :name => type,
          :tags => tags
        }
      end
    end
    @@types
  end

  def self.list_types(tags = [])
    types = self.types.select { |type| tags.empty? || (tags - type[:tags]).empty? }

    if types.empty?
      puts 'No types found!'
    else
      lines = []
      col1size = 0
      types.each do |type|
        col1size = type[:name].length if type[:name].length > col1size
        lines << [type[:name], "https://github.com/github/gitignore/blob/master/#{type[:path]}"]
      end

      puts 'Available types:'
      puts
      lines.sort_by { |line| line[0] }.each do |line|
        printf("%-#{col1size}s\t%s\n", line[0], line[1])
      end
    end
  end
end
