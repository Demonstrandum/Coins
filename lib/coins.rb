require 'net/http'
require 'json'

class Coins
  def initialize
    parseArgs
  end

  def setRate base
    begin
      @exchange = JSON.parse Net::HTTP.get(URI 'http://api.fixer.io/latest?base=' + base)
    rescue
      puts "Could not get exchange rate information.\nCheck your internet connnection or try again later."
      exit 1
    end
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
