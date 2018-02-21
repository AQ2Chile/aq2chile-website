class PlayerUpdater
  class << self
    attr_reader :all_info, :gamedig

    def run
      @gamedig  = Schmooze::Gamedig.new(__dir__)
      @all_info = @gamedig.get_all

      parse_info
      return true
    end

    private
    def parse_info
      players = all_info.collect{ |server| server[:players]}.flatten
      players.each do |p|
        player = Player.find_or_create_by(name: p[:name])

        # player.email
        # # player.verified
        player.frags           = p[:frags]
        player.last_online     = DateTime.now
        player.updates_count  += 1
        player.minutes_online += 1

        player.save
      end
    end
  end
end
