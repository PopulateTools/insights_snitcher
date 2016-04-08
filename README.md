# InsightsSnitcher

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/insights_snitcher`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'insights_snitcher'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install insights_snitcher

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/insights_snitcher. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).



----

# Sentences

## Bloque con totales

+ El presupuesto total de Madrid en 2015 fue de 4600 M €
  El {{concept}} de {{subject}} en {{time}} fue de {{value}} {{unit}}

+ El presupuesto total de Madrid en 2015 fue un 5% mayor que el de 2014
  El {{concept}} de {{subject}} en {{time}} fue un {{value}} {{comparation_direction}} que el de {{time_compared}}

+ El presupuesto total de Madrid en 2015 subió 6000 M € respecto a 2014
  El {{concept}} de {{subject}} en {{time}} {{comparation_direction}} {{comparation_value}} {{unit}} respecto a {{time_compared}}

+ El presupuesto total de Madrid en 2015 fue un 5% menor que la media de los últimos 5 años
  El {{concept}} de {{subject}} en {{time}} fue un {{comparation_value}} {{comparation_direction}}
  que la media de los últimos {{mean_period}} {{time_unit}}

+ El presupuesto total de Madrid lleva 3 años subiendo
  El {{concept}} de {{subject}} lleva {{time}} {{time_unit}} {{comparation_direction}}

+ El presupuesto total de Madrid ha subido en 4000 € desde 2012
  El {{concept}} de {{subject}} ha {{comparation_direction}} en {{comparation_value}} {{unit}} desde
  {{time_compared}}

## Bloque con medias provinciales y autonomias

- El presupuesto total de Madrid en 2015 es 20% mayor que la media provincial
- El presupuesto total de Madrid en 2015 es 30000 M € mayor que la media autonomica
- El presupuesto medio de la C. de Madrid ha bajado en 2015 pero el de Madrid ha subido

## Bloque de partidas concretas

(misma lista que bloque de totales)
(misma lista que bloque de provincias y autonomias)
- El gasto en parques supone el 34.5% del gasto total
- El gasto en parques supone sólo el 2% del gasto total

