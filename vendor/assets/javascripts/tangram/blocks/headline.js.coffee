
Tangram.blocks.Headline = Ember.View.extend

  isTangramHeadline: true

  templateName: 'tangram_blocks_headline_template'
  classNameBindings: ['isEditing']

  isEditing: false
  text: ''
  currentSize: null

  blockElement: null
  blockReplacement: null

  sizes: null
  headlineEditSizeSelect: Ember.Select.extend()

  headlineEditTextField: Ember.TextField.extend

    classNames: ['is-tangram-headline']

    keyPress: (event) ->
      if event.keyCode is 13
        event.stopImmediatePropagation()
        (@get 'parentView').preview()

    didInsertElement: -> this.$().focus().select()

  switchFromEditToPreviewButton: Ember.Button.extend

    click: (event) ->
      event.stopImmediatePropagation()
      (@get 'parentView').preview()

  init: ->
    @_super()

    @set 'currentSize', (@blockElement.prop 'tagName').toLowerCase()
    @set 'text', @blockElement.text()
    @set 'sizes', [ 'h1', 'h2', 'h3', 'h4', 'h5', 'h6']

    @blockReplacement = jQuery '<div class="headline-block block">'
    @blockElement.replaceWith @blockReplacement

    @appendTo @blockReplacement

  edit: ->
    @set 'isEditing', true

  preview: -> @set 'isEditing', false

  save: ->
    @blockReplacement.after @_createHeadlineFromCurrentState()
    @_removeHeadlineBlockFrom()

  _createHeadlineFromCurrentState: -> jQuery "<#{@currentSize}>#{@text}</#{@currentSize}>"

  _removeHeadlineBlockFrom: ->
    @remove()
    @blockReplacement.remove()


Tangram.registerBlock Tangram.blocks.Headline, 'h1, h2, h3, h4, h5, h6'