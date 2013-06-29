$ ->
  Modal = flight.component ->
  	@defaultAttrs
  	  bodySelector: '.body'
  	  closeSelector: '.close'
    
    @after 'initialize', ->
    	@on document, 'uiModalShow', @show
    	@on 'click', closeSelector: @close

    @show = (event, data) ->
      if data.url && data.url.length && !@.$node.is(':visible')
      	$.ajax
      	  type: 'get'
      	  url: data.url + '.js'
      	  dataType: 'html'
      	.done (data) =>
      		@select('bodySelector').html $(data)
      		@.$node.show()

    @close = (event) ->
     	event.preventDefault()
     	@select('bodySelector').html ''
      @.$node.hide()
  
  Modal.attachTo '.component-modal'