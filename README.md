# Coins
A simple live terminal currency exchange rate converter in Ruby

## Installation
Install the command line application with ruby-gems through rubygems.org
by typing:
```shell
gem install coins
```
you might need to use `sudo`, if the command fails type `sudo !-1`

If you prefer to build from source:
```shell
git clone https://github.com/Demonstrandum/Coins.git && cd Coins
gem build coins.gemspec
gem install coins-*.gem
```

## Usage
This application is meant purely as a terminal tool.

To convert between an amount of money between currencies, simply put:
`from [amount] [currency] to [other currency]` for example:
```shell
coins from 6 GBP to NOK
coins to NOK from 6 GBP
```
either will work just the same.

To print all known currencies
```shell
coins rates
```
This will default to showing the currencies against the US dollar (USD).
To change this simply add the word `against CUR` where `CUR` is the currency to check against, e.g. `GBP` (Great British Pound), or use the word `base` instead, anywhere in the command arguments.

For example:
```shell
coins rates against GBP
coins base GBP rates
```
both will work.

To print a single rate, write rate and the currency, (still defaults to USD if no other currency is specified in either `base` or `against`)
```shell
coins against EUR rate NOK
coins rate NOK base EUR
```
