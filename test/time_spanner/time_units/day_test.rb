require "test_helper"

module TimeSpanner
  module TimeUnits
    class DayTest < TestCase
      it "initializes" do
        day = Day.new

        assert day.is_a?(CalendarUnit)
        assert_equal 7, day.position
        assert_equal :days, day.plural_name
      end

      it "calculates without rest" do
        from = Time.parse("2013-04-03 00:00:00")
        to = Time.parse("2013-04-05 00:00:00")
        duration = to.to_r - from.to_r
        day = Day.new

        day.calculate duration, to

        assert_equal 2, day.amount
        assert_equal 0, day.rest
      end

      it "calculates with rest" do
        from = Time.parse("2013-04-03 00:00:00")
        target_days = Time.parse("2013-04-05 00:00:00")
        to = Time.at(target_days.to_time.to_r, 0.999)
        duration = to.to_r - from.to_r
        day = Day.new

        day.calculate duration, to

        assert_equal 2, day.amount
        assert_equal Rational(8998192055486251, 9007199254740992000000), day.rest
      end

      it "should not calculate amount of 2 although units equal" do
        from = Time.parse "2012-06-12 23:00:00"
        time_at_days = Time.parse "2012-06-14 23:00:00"
        to = Time.at time_at_days.to_r, -0.001
        duration = to.to_r - from.to_r
        day = Day.new

        day.calculate duration, to

        assert_equal 1, day.amount
        assert day.rest > 0
      end

      describe "leap days" do
        it "calculates correctly without leap day" do
          from = Time.parse("2013-01-01 00:00:00")
          to = Time.parse("2014-01-01 00:00:00")
          duration = to.to_r - from.to_r
          day = Day.new

          day.calculate duration, to

          assert_equal 365, day.amount
          assert_equal 0, day.rest
        end

        it "calculates correctly on leap day" do
          from = Time.parse("2012-01-01 00:00:00") # leap year
          to = Time.parse("2013-01-01 00:00:00")
          duration = to.to_r - from.to_r
          day = Day.new

          day.calculate duration, to

          assert_equal 366, day.amount
          assert_equal 0, day.rest
        end
      end
    end
  end
end
