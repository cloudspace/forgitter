require 'forgitter/types'
require 'forgitter/editors'

module Forgitter
  DEFAULT_OPTIONS = {
    :types => Forgitter::DEFAULT_TYPES,
    :editors => Forgitter::DEFAULT_EDITORS,
    :stdout => false,
    :access_token => ''
  }
end
