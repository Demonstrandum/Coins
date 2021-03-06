require 'net/http'
require 'json'

class Coins
  def setRate base
    begin
      @exchange = JSON.parse Net::HTTP.get(URI 'http://api.fixer.io/latest?base=' + base)
    rescue
      puts "Could not get exchange rate information.\nCheck your internet connnection or try again later."
      exit 1
    end
  end

  def help
    help = <<EOF

      A simple live terminal currency exchange rate converter in Ruby
      The currencies are retrieved from fixer.io which is a
      'Foreign exchange rates and currency conversion API'
      which is a JSON API published by the 'European Central Bank'.

      The rates are updated daily around 4 PM CET

      Usage:
        `coins [rate(s)] [base/against] / [from] num(float/int ){CUR} [to] {CUR}`
      where CUR is the three letter currency
      (e.g. USD, GBP NOK, EUR, RUB, etc...)
        use 'from `n` `CUR` to `CUR(other)`' toconvert between currencies.
        use 'rates' to list all rates (see `base` also) or 'rate `CUR`'
      to see the rate for one single currency.
        use 'base `CUR`' or 'agains `CUR`' to change what the exchange
        rates compare to.
      Default rate base is USD

EOF
    puts help
  end

  def args? this
    if ARGV.include? this
      return true
    end
    return false
  end

  def currencyConvert from, to
    return @exchange['rates'][to].to_f * from.to_f
  end

  def rates
    @exchange['rates'].each do |types|
      print types.to_s + "\n"
    end
  end

  def rate currency
    return @exchange['rates'][currency].to_s
  end


  def parseArgs
    if ARGV.empty? || args?('help') || args?('h') || args?('-h') || args?('--h')
      help
      exit 1
    end

    if args?('base')
      setRate(ARGV[ARGV.index('base') + 1].upcase)
    end

    unless args?('base') || args?('against') || args?('from')
      puts "No base rate set,\nset base rate by typing 'base' and than the three letter currency.\nDefaulting to USD.\n\n"
      setRate('USD')
    end

    if args?('against')
      setRate(ARGV[ARGV.index('against') + 1].upcase)
    end

    if args?('rates')
      rates
    end

    if args?('rate')
      puts rate ARGV[ARGV.index('rate') + 1].upcase
    end

    if args?('from') && args?('to')
      setRate(ARGV[ARGV.index('from') + 2].upcase)
      from = ARGV[ARGV.index('from') + 1].to_f
      to = ARGV[ARGV.index('to') + 1].upcase
      puts currencyConvert from, to
    end
  end
end
