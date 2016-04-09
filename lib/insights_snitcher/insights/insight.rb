module InsightsSnitcher
  module Insights
    class Insight

      def initialize(options)
        @dataset = options.fetch(:dataset)
        @context = options.fetch(:context)
      end

      def extract
        insights = {
          self.class.name.underscore => []
        }
        puts self.class.name
        puts
        data.each do |occurrence|
          insight = Mustache.render(template, occurrence)
          puts " * " + insight
          insights[self.class.name.underscore].push insight
        end

        insights
      end

      private

      def context_variables
        @context[:template_variables]
      end

      def time_column
        @context[:time_column]
      end

      def data_column
        @context[:data_column]
      end

    end
  end
end
