#= require jquery
#= require jquery_ujs
#= require flight-for-rails
#= require global/admin
#= require plugins/epiceditor
#= require components/flash

# Boot up admin application
$ -> window.Application = new Psyte.Application()

@Psyte = {}

Psyte.Application = ->
  $document = $(document)
  baseNode = $(document.body)
  
  selectors =
    editorElement: '#epiceditor'
    editorTextArea: '#epiceditora'

  init = ->
    if (editorElement = baseNode.find(selectors.editorElement))
      new EpicEditor(
        container: editorElement.get(0)
        textarea: baseNode.find(selectors.editorTextArea).get(0)
        fullscreen: false
        basePath: ''
        theme: globEpicEditorTheme
        autogrow:
          maxHeight: 600
        button:
          fullscreen: false
      ).load()
  
  init.apply $document

  {}