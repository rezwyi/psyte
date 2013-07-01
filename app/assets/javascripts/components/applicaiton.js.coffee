$ ->
  Application = flight.component ->
  	@defaultAttrs
      modalSelector: '.js-in-modal'
      flashSelector: '.component-flash'
  	
  	@after 'initialize', ->
      @select('flashSelector').animate top: '5px'
      setTimeout (=>@select('flashSelector').animate(top: '-1000px')), 5000
	  	
      @on 'click',
        modalSelector: (event) ->
          event.preventDefault()
          target = $(event.target)
          @trigger 'uiModalShow', title: target.data('title'), url: target.attr('href')

  Application.attachTo 'body'