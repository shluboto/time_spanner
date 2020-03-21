require "test_helper"

module TimeSpanner
  module TimeUnits
    class DecadeTest < TestCase
      it "initializes" do
        decade = Decade.new

        assert decade.is_a?(CalendarUnit)
        assert_equal 3, decade.position
        assert_equal :decades, decade.plural_name
      end

      it "calculates without rest" do
        from = Time.parse("2023-04-01 00:00:00")
        to = Time.parse("2043-04-01 00:00:00")
        duration = to.to_r - from.to_r
        decade = Decade.new

        decade.calculate duration, to

        assert_equal 2, decade.amount
        assert_equal 0, decade.rest
      end

      it "calculates with rest (1 second)" do
        from = Time.parse("2013-01-01 00:00:00")
        to = Time.parse("2033-01-01 00:00:01")
        duration = to.to_r - from.to_r
        decade = Decade.new

        decade.calculate duration, to

        assert_equal 2, decade.amount
        assert_equal 1, decade.rest
      end

      it "should not calculate amount of 2 although units equal" do
        from = Time.parse "2012-06-12 00:00:00"
        time_at_decades = Time.parse "2032-06-12 00:00:00"
        to = Time.at time_at_decades.to_r, -0.001
        duration = to.to_r - from.to_r
        decade = Decade.new

        decade.calculate duration, to

        assert_equal 1, decade.amount
        assert decade.rest > 0
      end

      it "calculates correctly on exact leap day" do
        from = Time.parse("2012-02-29 00:00:00") # leap year
        to = Time.parse("2022-02-28 00:00:00")
        duration = to.to_r - from.to_r
        decade = Decade.new

        decade.calculate duration, to

        assert_equal 1, decade.amount
        assert_equal 0, decade.rest
      end
    end
  end
end
