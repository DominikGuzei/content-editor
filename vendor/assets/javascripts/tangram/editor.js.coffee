
class Tangram.Editor

  @CSS_CLASS: 'tangram-editor'

  textarea: null
  rootElement: null
  blocks: null

  constructor: (textarea) ->
    @blocks = []
    @textarea = $(textarea).hide()

    @_createRootElement()
    @_initializeBlocks()

    @textarea.after @rootElement

  updateElement: ->
    block.preview() for block in @blocks
    @textarea.val @rootElement.html()

  _createRootElement: ->
    contents = @textarea.text()
    @rootElement = jQuery '<div class="tangram-editor">'
    @rootElement.append contents

  _initializeBlocks: ->
    @rootElement.children().each (index, childElement) =>
      childElement = $(childElement)
      BlockType = Tangram.getBlockForElement childElement
      @blocks.push (new BlockType childElement) if BlockType?