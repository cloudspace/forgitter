require 'forgitter/options'
require 'forgitter/types'
require 'forgitter/runner'
require 'forgitter/version'

module Forgitter
  DATA_PATH = File.realpath(File.join(File.dirname(__FILE__), '..', 'data'))
end
