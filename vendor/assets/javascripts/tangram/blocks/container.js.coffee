
Tangram.blocks.Container = Ember.View.extend

  classNames: ['tangram-container']

  editor: null
  blocks: null
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
    markup += block.getMarkup() for block in @blocks

    return markup

  _setupBlocks: ->
    this.$().children().each (index, childElement) =>
      childElement = $(childElement)
      BlockType = @editor.getBlockForElement childElement
      @blocks.push (BlockType.create blockElement: childElement) if BlockType?

  _makeBlocksSortable: -> this.$().sortable items: '.block'