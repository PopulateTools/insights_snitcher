require 'spec_helper'

describe InsightsSnitcher do
  it 'has a version number' do
    expect(InsightsSnitcher::VERSION).not_to be nil
  end

  context 'Given an scenario and a dataset' do
    let(:dataset) { 'spec/fixtures/madrid-total.json' }
    let(:context) { 'spec/fixtures/context-totals.yml' }

    it 'should load' do
      snitcher = InsightsSnitcher::Detector.new dataset: dataset, context: context
      snitcher.detect
    end
  end
end
