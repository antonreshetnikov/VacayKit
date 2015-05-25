class Selector
  constructor: ->
    @form = $ 'form.landing__selector'
    if @form.length == 0
      return
    @select = $ '#kit-selector'
    @form.on 'submit', @redirect


  redirect: (event)=>
      event.preventDefault()
      document.location = $('#kit-selector').val()


$(document).ready ->
  new Selector
