#= require jquery
#= require jquery_ujs
#= require flight-for-rails
#= require components/flash

# Boot up admin application
$ -> window.Application = new Psyte.Application()

@Psyte = {}

Psyte.Application = ->
  $document = $(document)
  baseNode = $(document.body)

  init = ->

  init.apply $document

  {}