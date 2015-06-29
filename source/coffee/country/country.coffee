class Country
  constructor: ->
    @widget = $ '.page[data-code]'
    @country_code = @widget.attr 'data-code'

    if $('.info__currency').length > 0
      currency_title = window.currency_info[@country_code].currencyName + ' (' + window.currency_info[@country_code].currencyId + ')'
      @currency = window.currency_info[@country_code].currencyId
      $('.info__currency-name').text currency_title
      @exchange()

    if $('.info__capital').length > 0
      $.get('https://restcountries.eu/rest/v1/alpha/'+@country_code).success @countryData

  countryData: (data)=>
    @widget.find('.info__capital .info__details p').text data.capital
    $('.info__capital').fadeIn()

    # @currency = data[0].currencies[0]
    # @exchange()

  exchange: =>
    # @usd_exchange = 'USD_'+@currency
    # @eur_exchange = 'EUR_'+@currency
    $.ajax
      'url': 'http://apilayer.net/api/live'
      'jsonp': @exchanged
      'dataType': 'jsonp'
      'data':
        'access_key': '3f4a16f6f4fcd244ceed0a9ffb13e738'
        'source': @currency
        'amount': '1'
        'callback': 'window.country.exchanged'

  exchanged: (data)=>
    console.log data, arguments
    $('.info__currency-rate_usd').text data.results[@usd_exchange].val.toFixed(1) + ' ' + @currency
    $('.info__currency-rate_eur').text data.results[@eur_exchange].val.toFixed(1) + ' ' + @currency
    $('.info__currency').fadeIn()

$(document).ready ->
  window.country = new Country
