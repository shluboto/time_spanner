module TimeSpanner

  class DurationChain
    extend Forwardable
    include Enumerable
    include TimeUnits

    attr_accessor :remaining, :reverse, :units
    attr_reader   :to
    alias         :reverse? :reverse

    def_delegator :units, :each

    def initialize from, to, units
      @from, @to = setup_times from, to
      @remaining = to.to_r - from.to_r
      @units     = units.map &:new

      calculate!
    end

    private

    # Perform duration calculations for units in chain.
    def calculate!
      sort!

      each do |unit|
        calculate_unit unit
      end
    end

    def calculate_unit unit
      unit.calculate remaining, to
      unit.reverse! if reverse?

      @remaining = unit.rest
    end

    # Units must be sorted to perform a correct calculation chain.
    def sort!
      @units = units.sort
    end

    def setup_times from, to
      @reverse = to < from
      new_from = reverse? ? to : from
      new_to   = reverse? ? from : to

      [ new_from, new_to ]
    end

  end

end
