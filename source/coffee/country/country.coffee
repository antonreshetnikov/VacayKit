class Country
  constructor: ->
    @widget = $ '.page[data-code]'
    @country_code = @widget.attr 'data-code'

    if $('.info__currency').length > 0
      currency_title = window.currency_info[@country_code].currencyName + ' (' + window.currency_info[@country_code].currencyId + ')'
      @currency = window.currency_info[@country_code].currencyId
      $('.info__currency-name').text currency_title

    if $('.info__capital').length > 0
      $.get('https://restcountries.eu/rest/v1/alpha/'+@country_code).success @countryData

  countryData: (data)=>
    @widget.find('.info__capital .info__details p').text data.capital
    $('.info__capital').fadeIn()


$(document).ready ->
  window.country = new Country
