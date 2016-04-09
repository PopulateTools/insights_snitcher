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
            time: row[time_column].to_i,
            value: Formatter.format_money(row[data_column])
          })
        end.sort_by{ |h| h[:time] }
      end
    end
  end
end
