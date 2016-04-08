module InsightsSnitcher
  module Insights
    class ComparePercentageWithOther < Insight

      def template
        "El {{concept}} de {{subject}} en {{time}} fue un {{comparation_value}} {{comparation_direction}} que el de {{time_compared}}"
      end

      private

      RELEVANCE = 10

      def data

        @dataset.map do |row|
          time_row = row[@context['time_column']]
          value_row = row[@context['data_column']]

          @dataset.map do |other_row|
            time_other_row = other_row[@context['time_column']]
            next if time_row == time_other_row
            value_other_row = other_row[@context['data_column']]

            comparation_value = (value_row.to_f - value_other_row.to_f)/value_other_row.to_f * 100
            next if comparation_value.abs < RELEVANCE

            comparation_direction = (value_row > value_other_row) ? 'mayor' : 'menor'

            context_variables.merge({
              'time': time_row,
              'time_compared': time_other_row,
              'comparation_direction': comparation_direction,
              'comparation_value': Formatter.format_percentage(comparation_value.abs)
            })
          end
        end.flatten.compact
      end
    end
  end
end
