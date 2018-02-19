class HomeController < ApplicationController
  def index
    @gamedig = Schmooze::Gamedig.new(__dir__)
    @status  = @gamedig.get_all
  end
end
