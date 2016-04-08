module InsightsSnitcher
  module Insights
    class Insight

      def initialize(options)
        @dataset = options.fetch(:dataset)
        @context = options.fetch(:context)
      end

      def extract
        puts self.class.name
        puts
        data.each do |occurrence|
          puts " * " + Mustache.render(template, occurrence)
        end
      end

      private

      def context_variables
        @context['template_variables']
      end

    end
  end
end
