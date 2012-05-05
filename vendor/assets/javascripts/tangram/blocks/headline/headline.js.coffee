
Tangram.blocks.Headline = Ember.View.extend

  isTangramHeadline: true

  templateName: 'tangram_blocks_headline_template'
  classNames: ['headline-block block']
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

    @_insertElementLater -> @blockElement.replaceWith this.$()

  didInsertElement: ->
    this.$().data 'tangram-block', this
    @preview()

  edit: -> @set 'isEditing', true

  preview: ->
    @set 'isEditing', false
    @_updatePreviewHeadline()

  getMarkup: -> @_getHeadlineFromCurrentState().wrap('<div>').parent().html()

  _updatePreviewHeadline: ->
    this.$('div.is-tangram-headline').html @_getHeadlineFromCurrentState()

  _getHeadlineFromCurrentState: ->
    currentSize = @get 'currentSize'
    text = @get 'text'

    jQuery "<#{currentSize}>#{text}</#{currentSize}>"


Tangram.blocks.Headline.reopenClass

  getToolMarkup: -> '<h1 class="tool headline">Headline</h1>'