
module InsightsSnitcher
  class Formatter
    def self.format_money(amount)
      options = {
        format: '%n', precision: 1,
        delimiter: ',', separator: '.'
      }
      amount = amount.to_f
      if amount.abs > 1_000_000
        amount = amount/1_000_000
        amount.to_s(:currency, options) + 'M'
      else
        amount.to_s(:currency, options)
      end
    end

    def self.format_percentage(amount)
      amount.to_s(:percentage, {precision: 1, delimiter: ',', separator: '.'})
    end

  end
end
