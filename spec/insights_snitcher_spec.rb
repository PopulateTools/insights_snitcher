require 'spec_helper'

describe InsightsSnitcher do
  it 'has a version number' do
    expect(InsightsSnitcher::VERSION).not_to be nil
  end

  context 'Given an scenario and a dataset' do
    let(:dataset) { 'spec/fixtures/madrid-total.json' }
    let(:context) do
      {
        data_column: 'total_budget',
        time_column: 'year',
        template_variables: {
          unit: '€',
          concept: 'presupuesto total',
          subject: 'Madrid'
        }
      }
    end

    it 'should load' do
      snitcher = InsightsSnitcher::Detector.new dataset: dataset, context: context
      output = snitcher.detect
    end
  end
end
