
Tangram.Editor = Ember.Application.extend

  textarea: null
  rootElement: null
  blocks: null

  init: ->
    @_setupRootElement()
    @_super()

  ready: ->
    @blocks = []

    @_initializeBlocks()
    @_initializeSortable()

  updateElement: ->
    updatedMarkup = ""
    updatedMarkup += block.getMarkup() for block in @blocks
    @textarea.val updatedMarkup

  _setupRootElement: ->
    @rootElement = jQuery '<div class="tangram-editor">'
    @textarea = $(@textarea).hide()
    @textarea.after @rootElement
    @rootElement.html @textarea.val()

  _initializeBlocks: ->
    @rootElement.children().each (index, childElement) =>
      childElement = $(childElement)
      BlockType = Tangram.getBlockForElement childElement
      @blocks.push (BlockType.create blockElement: childElement) if BlockType?

  _initializeSortable: ->
    @rootElement.sortable
      items: '.block'