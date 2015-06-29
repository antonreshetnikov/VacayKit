class Items
  constructor: (@widget, index)->

    if typeof @widget.attr('data-fold') == "undefined"
      return

    @name = @widget.attr('data-name') || index
    @state =  @parseBoolean(@widget.attr('data-state')) || true
    if sessionStorage.getItem(@name)
      @state =  @parseBoolean(sessionStorage.getItem(@name))

    @items = @widget.find '.item'
    @count = @items.length
    @buttons = null

    @test()
    $(window).on 'resize', @test

  test: =>
    if @buttons == null
      @addButtons()

    if @state == false

      @items.hide()
      @last_button.hide()
      @buttons.removeClass 'items__hide_open'
      end = ''
      if @count>1
        end = 's'
      $(@buttons).text('Show ' + @count + ' item'+end)

    else

      @items.show()
      @last_button.show()
      @buttons.addClass 'items__hide_open'
      end = ''
      if @count>1
        end = 's'
      $(@buttons).text('Hide ' + @count + ' item'+end)


  addButtons: =>
    button_1 = document.createElement 'BUTTON'
    button_1.setAttribute 'type', 'button'

    end = ''
    if @count>1
      end = 's'

    if @state
      button_1.appendChild document.createTextNode('Hide ' + @count + ' item'+end)
    else
      button_1.appendChild document.createTextNode('Show ' + @count + ' item'+end)

    button_1.className = 'items__hide'

    button_2 = button_1.cloneNode true
    button_2.className = 'items__hide items__hide_last'

    @widget.before button_1
    @widget.after button_2
    @buttons = @widget.parent().find '>.items__hide'
    @last_button = @widget.next()
    @first_button = @widget.prev()
    @buttons.on 'click', @toggleState

  toggleState: (event)=>
    @state = !@state
    sessionStorage.setItem(@name, @state)

    end = ''
    if @count>1
      end = 's'

    if @state == false

      @items.hide()
      @buttons.removeClass 'items__hide_open'
      $(@buttons).text('Show ' + @count + ' item'+end)
      @last_button.hide()

    else

      @items.show()
      @last_button.show()
      @buttons.addClass 'items__hide_open'
      $(@buttons).text('Hide ' + @count + ' item'+end)

    button = $ event.currentTarget
    if button.hasClass('items__hide_last') && (@state == false)
      window.setTimeout(()=>
          $(window).scrollTo(@first_button.parent().find('.items__header'), 200)
        , 50)

  parseBoolean: (value)=>
    if typeof value == "undefined"
      return undefined
    if value == "true"
      return true
    return false

$(document).ready ->
  i = 0
  for list in $ '.items__list'
    new Items($(list), i)
    i++
