$ ->
  Flash = flight.component ->
    @after 'initialize', ->
      @.$node.animate top: '5px'
      setTimeout (=> @.$node.animate(top: '-1000px')), 5000
  
  Flash.attachTo '.component-flash'