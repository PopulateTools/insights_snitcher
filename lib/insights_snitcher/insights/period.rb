module InsightsSnitcher
  module Insights
    class Period < Insight

      def template
        "El {{concept}} de {{subject}} ha {{comparation_direction}} en {{comparation_value}} {{unit}} desde {{time_compared}}"
      end

      private

      RELEVANCE = 10

      def data
        years = @dataset.map{ |row| row[time_column].to_i }.sort.reverse
        return [] if years.length < 3

        results = []
        2.upto(years.length-1) do |i|
          data0 = @dataset.detect { |row| row[time_column].to_i == years[0] }[data_column]
          data1 = @dataset.detect { |row| row[time_column].to_i == years[i] }[data_column]
          comparation_value = data0 - data1
          comparation_direction = comparation_value > 0 ? 'subido' : 'bajado'

          diff_percentage = (data0.to_f - data1.to_f)/data1.to_f * 100
          next if diff_percentage < RELEVANCE

          results.push context_variables.merge({
            'time': years[0],
            'comparation_direction': comparation_direction,
            'comparation_value': Formatter.format_money(comparation_value),
            'time_compared': years[i]
          })
        end

        results
      end
    end
  end
end
