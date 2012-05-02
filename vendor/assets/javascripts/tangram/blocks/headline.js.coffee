
Tangram.blocks.Headline = Ember.View.extend

  templateName: 'tangram_blocks_headline_template'

  isEditing: false
  text: ''
  currentSize: null

  blockElement: null
  blockReplacement: null

  sizes: null
  sizeSelect: Ember.Select.extend()

  headlineTextField: Ember.TextField.extend

    keyPress: (event) ->
      if event.keyCode is 13
        event.stopImmediatePropagation()
        (@get 'parentView').preview()


  init: ->
    @_super()

    @set 'currentSize', (@blockElement.prop 'tagName').toLowerCase()
    @set 'text', @blockElement.text()
    @set 'sizes', [ 'h1', 'h2', 'h3', 'h4', 'h5', 'h6']

    @blockReplacement = jQuery '<div class="headline-block">'
    @blockElement.replaceWith @blockReplacement

    @appendTo @blockReplacement

  edit: -> @set 'isEditing', true

  preview: -> @set 'isEditing', false


Tangram.registerBlock Tangram.blocks.Headline, 'h1, h2, h3, h4, h5, h6'