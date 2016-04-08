module InsightsSnitcher
  module Insights
    class CompareValueWithOther < Insight

      def template
        "El {{concept}} de {{subject}} en {{time}} fue un {{comparation_direction}} {{comparation_value}} {{unit}} respecto a {{time_compared}}"
        "El {{concept}} de {{subject}} en {{time}} {{comparation_direction}} {{comparation_value}} {{unit}} respecto a {{time_compared}}"
      end

      private

      RELEVANCE = 5

      def data

        @dataset.map do |row|
          time_row = row[@context['time_column']]
          value_row = row[@context['data_column']]

          @dataset.map do |other_row|
            time_other_row = other_row[@context['time_column']]
            next if time_row == time_other_row
            value_other_row = other_row[@context['data_column']]


            comparation_value = value_row.to_f - value_other_row.to_f
            comparation_relevance = (value_row.to_f - value_other_row.to_f)/value_other_row.to_f * 100
            next if comparation_relevance.abs < RELEVANCE

            comparation_direction = (comparation_value > 0) ? 'subió' : 'bajó'

            context_variables.merge({
              'time': time_row,
              'time_compared': time_other_row,
              'comparation_direction': comparation_direction,
              'comparation_value': Formatter.format_money(comparation_value.abs)
            })
          end
        end.flatten.compact
      end
    end
  end
end
