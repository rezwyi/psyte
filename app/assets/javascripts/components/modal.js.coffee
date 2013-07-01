$ ->
  Modal = flight.component ->
    @defaultAttrs
      closeSelector: '.close'
      titleSelector: '.title'
      bodySelector: '.body'
    
    @after 'initialize', ->
      @on document, 'uiModalShow', @show
      @on 'click', closeSelector: @close

    @show = (event, data) ->
      if data.title && data.title.length
        @select('titleSelector').text data.title
      
      if data.url && data.url.length && !@.$node.is(':visible')
        $.ajax
          type: 'get'
          url: data.url + '.js'
          dataType: 'html'
        .done (data) =>
          @select('bodySelector').html $(data).addClass('in-modal')
          @.$node.show()

    @close = (event) ->
      event.preventDefault()
      @select('titleSelector').text ''
      @select('bodySelector').html ''
      @.$node.hide()
  
  Modal.attachTo '.component-modal'