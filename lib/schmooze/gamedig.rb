require 'schmooze'
module Schmooze
  class Gamedig < Schmooze::Base
    dependencies gamedig: 'gamedig'

    method :_query, 'gamedig.query'
    method :version, 'function() { return [process.version, gamedig.version]; }'

    def query(opts = {})
      _query(opts).with_indifferent_access
    end
  end
end
