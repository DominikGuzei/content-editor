
CONTAINER_CLASS = 'tangram-container'

Tangram.blocks.Container = Ember.View.extend

  classNames: [CONTAINER_CLASS]

  editor: null
  markup: ''

  init: ->
    @_super()
    @blocks = []

  didInsertElement: ->
    this.$().html @markup
    @_setupBlocks()
    @_makeBlocksSortable()

  getMarkup: ->
    markup = ''

    this.$().children().each (index, childElement) =>
      block = $(this).data 'tangram-block'
      markup += block.getMarkup() for block in @blocks

    return markup

  _setupBlocks: ->
    this.$().children().each (index, childElement) =>
      childElement = $(childElement)
      @_createBlockFromElement childElement

  _makeBlocksSortable: ->
    this.$().sortable
      stop: => @_handleSortStop.apply this, arguments

  _handleSortStop: (event, ui) ->
    @_createBlockFromElement ui.item if ui.item.hasClass 'tool'

  _createBlockFromElement: (element) ->
    BlockType = @editor.getBlockForElement element
    BlockType.create blockElement: element if BlockType?


Tangram.blocks.Container.reopenClass CONTAINER_CLASS: CONTAINER_CLASS