$ ->
  Application = flight.component ->
  	@defaultAttrs
      modalSelector: '.js-in-modal'
  	
  	@after 'initialize', ->
	  	@on 'click',
        modalSelector: (event) ->
          event.preventDefault()
          @trigger 'uiModalShow', url: $(event.target).attr('href')

  Application.attachTo 'body'