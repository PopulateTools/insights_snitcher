module InsightsSnitcher
  module Insights
    class CompareMeanWithPercentage < Insight

      def template
        "El {{concept}} de {{subject}} en {{time}} fue un {{comparation_value}} {{comparation_direction}} que la media de los últimos {{mean_period}} {{time_unit}}"
      end

      private

      RELEVANCE = 1.5

      def data
        time_unit = 'años'

        years = @dataset.map{ |row| row[time_column].to_i }.sort.reverse
        last_year = years.shift

        (years.length - 3...years.length).map do |length|
          selected_years = years[0...length]
          mean_period = selected_years.length

          value = nil
          mean = 0
          @dataset.each do |row|
            time_row = row[time_column].to_i
            value = row[data_column].to_f if last_year == time_row

            next unless selected_years.include?(time_row)

            mean += row[data_column].to_f
          end
          mean = mean / selected_years.length
          comparation_value = (value.to_f - mean.to_f)/mean.to_f * 100
          next if comparation_value.abs < RELEVANCE

          comparation_direction = (comparation_value > 0) ? 'mayor' : 'menor'

          context_variables.merge({
            'time': last_year,
            'time_unit': time_unit,
            'mean_period': mean_period,
            'comparation_direction': comparation_direction,
            'comparation_value': Formatter.format_percentage(comparation_value.abs)
          })
        end.compact
      end
    end
  end
end
