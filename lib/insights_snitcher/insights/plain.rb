module InsightsSnitcher
  module Insights
    class Plain < Insight

      def template
        "El {{concept}} de {{subject}} en {{time}} fue de {{value}} {{unit}}"
      end

      private

      def data
        @dataset.map do |row|
          context_variables.merge({
            'time': row[@context['time_column']],
            'value': Formatter.format_money(row[@context['data_column']])
          })
        end
      end
    end
  end
end
