require 'debugger'
module Forgitter
  def self.parameterize(name)
    name.gsub(/[^a-z0-9+]+/i, '').downcase
  end

  def self.types(filter_tags = [])
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
    @@types.select { |type| filter_tags.empty? || (filter_tags - type[:tags]).empty? }
  end

  def self.list_types(tags = [])
    types = self.types(tags)
    if types.empty?
      puts 'No types found!'
    else
      lines = []
      col1size = 0
      types.each do |type|
        col1size = type[:name].length if type[:name].length > col1size
        lines << [type[:name], type[:path]]
      end

      puts 'Available types:'
      puts
      lines.sort_by { |line| line[0] }.each do |line|
        printf("%-#{col1size}s\t%s\n", line[0], line[1])
      end
    end
  end
end
