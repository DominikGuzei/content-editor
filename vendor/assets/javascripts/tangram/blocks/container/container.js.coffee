
CONTAINER_CLASS = 'tangram-container'

Tangram.blocks.Container = Ember.View.extend

  classNames: [CONTAINER_CLASS]

  editor: null
  blocks: null
  markup: ''

  _blockIndexBeforeSort: null

  init: ->
    @_super()
    @blocks = []

  didInsertElement: ->
    this.$().html @markup
    @_setupBlocks()
    @_makeBlocksSortable()

  getMarkup: ->
    markup = ''
    markup += block.getMarkup() for block in @blocks

    return markup

  _setupBlocks: ->
    this.$().children().each (index, childElement) =>
      childElement = $(childElement)
      @_createBlockFromElementAtIndex childElement, index

  _makeBlocksSortable: ->
    this.$().sortable
      start: => @_handleBlockSortStart.apply this, arguments
      stop: => @_handleBlockSortStop.apply this, arguments

  _handleBlockSortStart: (event, ui) ->
    blockToSort = ui.item
    @_blockIndexBeforeSort = blockToSort.index() unless blockToSort.hasClass 'tool'

  _handleBlockSortStop: (event, ui) ->
    sortedBlock = ui.item
    blockIndexAfterSort = sortedBlock.index()

    (@_createBlockFromElementAtIndex sortedBlock, blockIndexAfterSort) if sortedBlock.hasClass 'tool'
    (@_moveBlockToIndex @_blockIndexBeforeSort, blockIndexAfterSort) if @_blockIndexBeforeSort?

    @_blockIndexBeforeSort = null

  _moveBlockToIndex: (oldIndex, newIndex) ->
    @blocks.splice newIndex, 0, @blocks.splice(oldIndex, 1)[0]

  _createBlockFromElementAtIndex: (element, index) ->
    BlockType = @editor.getBlockForElement element

    createdBlock = BlockType.create blockElement: element
    @blocks.splice index, 0, createdBlock


Tangram.blocks.Container.reopenClass CONTAINER_CLASS: CONTAINER_CLASS