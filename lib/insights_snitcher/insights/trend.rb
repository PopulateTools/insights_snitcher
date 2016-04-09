module InsightsSnitcher
  module Insights
    class Trend < Insight

      def template
        "El {{concept}} de {{subject}} lleva {{time}} {{time_unit}} {{comparation_direction}}"
      end

      private

      RELEVANCE = 1.5

      def data
        found_trend = false
        time_unit = 'años'

        years = @dataset.map{ |row| row[time_column].to_i }.sort.reverse
        return [] if years.length < 3

        last_year = years.shift
        trend = 1
        trends = []
        # 0,1
        # 1,2
        # 2,3
        # 3,4
        0.upto(years.length-2) do |i|
          data0 = @dataset.detect { |row| row[time_column].to_i == years[i] }[data_column]
          data1 = @dataset.detect { |row| row[time_column].to_i == years[i+1] }[data_column]
          trends.push(data0 - data1)
        end

        # TODO: make this search dynamic
        if trends[0] > 0
          if trends[1] > 0
            found_trend = true
            time = 2
            comparation_direction = 'subiendo'
            if trends[2] > 0
              time = 2
            end
          end
        end

        if trends[0] < 0
          if trends[1] < 0
            found_trend = true
            time = 2
            comparation_direction = 'bajando'
            if trends[2] < 0
              time = 3
            end
          end
        end

        if found_trend
          # Return an array with one element
          [
            context_variables.merge({
              time: time,
              time_unit: time_unit,
              comparation_direction: comparation_direction
            })
          ]
        else
          []
        end
      end
    end
  end
end
