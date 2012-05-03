
Tangram.Editor = Ember.Application.extend

  toolBar: null
  textarea: null
  rootElement: null
  blockContainer: null
  selectorToBlockMap: {}

  init: ->
    @_setupRootElement()
    @_super()

  ready: ->
    @_setupToolBar()
    @_setupBlockContainer()

  updateElement: -> @textarea.val @blockContainer.getMarkup()

  getBlockForElement: (element) ->
    foundBlock = null

    for selector, block of @selectorToBlockMap
      foundBlock = block if element.is selector

    return foundBlock

  _setupRootElement: ->
    @rootElement = jQuery '<div class="tangram-editor">'
    @textarea = $(@textarea).hide()
    @textarea.after @rootElement

  _setupBlockContainer: ->
    @blockContainer = Tangram.blocks.Container.create
      markup: @textarea.val()

    @blockContainer.appendTo @rootElement

  _setupToolBar: ->
    @toolBar = Tangram.ToolBar.create editor: this
    @toolBar.appendTo @rootElement