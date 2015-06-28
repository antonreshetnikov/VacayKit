class Items
  constructor: (@widget, index)->
    @minCount = @widget.attr('data-min') || 5
    @name = @widget.attr('data-name') || index

    @state =  @parseBoolean(@widget.attr('data-state')) || true
    if sessionStorage.getItem(@name)
      @state =  @parseBoolean(sessionStorage.getItem(@name))

    @items = @widget.find '.item'
    @count = @items.length
    @tail = @widget.find('.item:gt('+(@minCount-1)+')')
    @buttons = null

    @test()
    $(window).on 'resize', @test

  test: =>
    if Modernizr.mq '(max-width: 500px)' && @buttons != null
      @buttons.remove()
      @buttons = null
      @tail.show()
      return

    if @minCount<@count

      if @buttons == null
        @addButtons()

      if @state == false

        @tail.hide()
        @buttons.removeClass 'items__hide_open'
        num = @count-@minCount
        end = ''
        if num>1
          end = 's'
        $(@buttons).text('Show ' + num + ' item'+end)

      else

        @tail.show()
        @buttons.addClass 'items__hide_open'
        num = @count-@minCount
        end = ''
        if num>1
          end = 's'
        $(@buttons).text('Hide ' + num + ' item'+end)


  addButtons: =>
    button_1 = document.createElement 'BUTTON'
    button_1.setAttribute 'type', 'button'

    num = @count-@minCount
    end = ''
    if num>1
      end = 's'

    if @state
      button_1.appendChild document.createTextNode('Hide ' + num + ' item'+end)
    else
      button_1.appendChild document.createTextNode('Show ' + num + ' item'+end)

    button_1.className = 'items__hide'

    button_2 = button_1.cloneNode true
    button_2.className = 'items__hide items__hide_last'

    @widget.before button_1
    @widget.after button_2
    @buttons = @widget.parent().find '>.items__hide'
    @buttons.on 'click', @toggleState

  toggleState: (event)=>
    @state = !@state
    sessionStorage.setItem(@name, @state)
    num = @count-@minCount
    end = ''
    if num>1
      end = 's'

    if @state == false

      @tail.hide()
      @buttons.removeClass 'items__hide_open'
      $(@buttons).text('Show ' + num + ' item'+end)
    else

      @tail.show()
      @buttons.addClass 'items__hide_open'
      $(@buttons).text('Hide ' + num + ' item'+end)

    button = $ event.currentTarget
    if button.hasClass('items__hide_last') && (@state == false)
      $(window).scrollTo(button.offset().top - Math.max(document.documentElement.clientHeight, window.innerHeight || 0)/2, 200)

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
