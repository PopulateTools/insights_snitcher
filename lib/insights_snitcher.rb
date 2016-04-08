require "byebug"
require "yaml"
require "json"
require "mustache"
require "active_support/all"

require "insights_snitcher/insights/insight"

Dir["#{File.dirname(__FILE__)}/**/*.rb"].each {|file| require file }

module InsightsSnitcher
  class Detector
    def initialize(options)
      dataset = options.fetch(:dataset)
      context = options.fetch(:context)

      raise "Missing file #{dataset}" unless File.file?(dataset)
      raise "Missing file #{context}" unless File.file?(context)

      @dataset = JSON.parse(File.read(dataset))
      @context = YAML.load(File.read(context))

      @insights = []
    end

    def detect
      puts 'Dataset'
      puts @dataset

      puts 'Context'
      puts @context

      InsightsSnitcher::Insights::Plain.new(dataset: @dataset, context: @context).extract

      InsightsSnitcher::Insights::ComparePercentageWithOther.new(dataset: @dataset, context: @context).extract

      # Disabled
      # InsightsSnitcher::Insights::CompareValueWithOther.new(dataset: @dataset, context: @context).extract

      InsightsSnitcher::Insights::CompareMeanWithPercentage.new(dataset: @dataset, context: @context).extract

      InsightsSnitcher::Insights::Trend.new(dataset: @dataset, context: @context).extract

      InsightsSnitcher::Insights::Period.new(dataset: @dataset, context: @context).extract
    end
  end
end
