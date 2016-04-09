module InsightsSnitcher
  module Insights
    class ComparePercentageWithOther < Insight

      def template
        "El {{concept}} de {{subject}} en {{time}} fue un {{comparation_value}} {{comparation_direction}} que el de {{time_compared}}"
      end

      private

      RELEVANCE = 20

      def data
        row = @dataset.pop

        time_row = row[time_column]
        value_row = row[data_column]

        @dataset.map do |other_row|
          time_other_row = other_row[time_column]
          value_other_row = other_row[data_column]

          comparation_value = (value_row.to_f - value_other_row.to_f)/value_other_row.to_f * 100
          next if comparation_value.abs < RELEVANCE

          comparation_direction = (value_row > value_other_row) ? 'mayor' : 'menor'

          context_variables.merge({
            time: time_row,
            time_compared: time_other_row,
            comparation_direction: comparation_direction,
            comparation_value: Formatter.format_percentage(comparation_value.abs)
          })
        end.compact
      end
    end
  end
end
