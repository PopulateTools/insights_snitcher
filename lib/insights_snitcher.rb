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
      @context = options.fetch(:context)

      dataset = options.fetch(:dataset)

      raise "Missing file #{dataset}" unless File.file?(dataset)
      @dataset = JSON.parse(File.read(dataset))

      @dataset = @dataset.sort_by{ |h| h[time_column].to_i }

      if @context[:filters]
        filter_column = @context[:filters].keys.first
        filter_value = @context[:filters].values.first
        @dataset = @dataset.select{ |row| row[filter_column.to_s] == filter_value }
      end

      @insights = {
        data_column => {}
      }
    end

    def detect
      return [].to_json if  @dataset.empty?

      # Plain
      #@insights[data_column].merge! InsightsSnitcher::Insights::Plain.new(dataset: @dataset, context: @context).extract

      @insights[data_column].merge! InsightsSnitcher::Insights::ComparePercentageWithOther.new(dataset: @dataset, context: @context).extract

      # Disabled
      # @insights.concat InsightsSnitcher::Insights::CompareValueWithOther.new(dataset: @dataset, context: @context).extract

      @insights[data_column].merge! InsightsSnitcher::Insights::CompareMeanWithPercentage.new(dataset: @dataset, context: @context).extract

      @insights[data_column].merge! InsightsSnitcher::Insights::Trend.new(dataset: @dataset, context: @context).extract

      @insights[data_column].merge! InsightsSnitcher::Insights::Period.new(dataset: @dataset, context: @context).extract

      @insights.to_json
    end

    private

    def data_column
      @context[:data_column]
    end

    def time_column
      @context[:time_column]
    end

  end
end
