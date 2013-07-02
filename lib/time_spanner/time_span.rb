module TimeSpanner

  class TimeSpan < Hash
    include Errors

    attr_reader :unit_chain

    def initialize from, to, unit_names = []
      validate! from, to

      units       = TimeUnitCollector.new( unit_names ).units
      @unit_chain = DurationChain.new from.to_time, to.to_time, units

      build!
    end


    private

    def build!
      unit_chain.each do |unit|
        self[ unit.plural_name ] = unit.amount
      end
    end

    def validate! from, to
      unless [ from, to ].all? { |obj| obj.is_a?( Time ) || ( obj.respond_to?( :to_time ) && obj.to_time.is_a?( Time ) ) }
        raise InvalidClassError, "Must convert to Time object!"
      end
    end

  end

end