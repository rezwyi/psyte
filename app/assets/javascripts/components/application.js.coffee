$ ->
  Application = flight.component ->
  	@defaultAttrs
      modalSelector: '.js-in-modal'
  	
  	@after 'initialize', ->
      @on 'click',
        modalSelector: (event) ->
          event.preventDefault()
          target = $(event.target)
          @trigger 'uiModalShow', title: target.data('title'), url: target.attr('href')

  Application.attachTo 'body'