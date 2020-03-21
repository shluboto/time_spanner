require "test_helper"

module TimeSpanner
  module TimeUnits
    class WeekTest < TestCase
      it "initializes" do
        week = Week.new

        assert week.is_a?(CalendarUnit)
        assert_equal 6, week.position
        assert_equal :weeks, week.plural_name
      end

      it "calculates without rest" do
        from = Time.parse("2013-04-01 00:00:00")
        to = Time.parse("2013-04-08 00:00:00")
        duration = to.to_r - from.to_r
        week = Week.new

        week.calculate duration, to

        assert_equal 1, week.amount
        assert_equal 0, week.rest
      end

      it "calculates with rest (6 days and 1 second in seconds)" do
        from = Time.parse("2013-04-01 00:00:00")
        to = Time.parse("2013-04-21 00:00:01")
        duration = to.to_r - from.to_r
        week = Week.new

        week.calculate duration, to

        assert_equal 2, week.amount
        assert_equal 518401, week.rest
      end

      it "should not calculate amount of 2 although units equal" do
        from = Time.parse "2012-06-01 12:00:00"
        time_at_weeks = Time.parse "2012-06-15 12:00:00"
        to = Time.at time_at_weeks.to_r, -0.001
        duration = to.to_r - from.to_r
        week = Week.new

        week.calculate duration, to

        assert_equal 1, week.amount
        assert week.rest > 0
      end
    end
  end
end
