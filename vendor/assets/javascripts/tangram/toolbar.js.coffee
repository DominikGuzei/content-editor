
Tangram.ToolBar = Ember.View.extend

  classNames: ['tangram-toolbar']
  templateName: 'tangram_templates_toolbar'

  editor: null
  blockTypes: null

  didInsertElement: ->
    @_setupTools()
    @_makeToolsDraggable()

  _setupTools: ->
    @blockTypes = @editor.selectorToBlockMap

    toolsMarkup = ''

    for selector, block of @blockTypes
      toolsMarkup += block.getToolMarkup()

    this.$('.tools').html toolsMarkup

  _makeToolsDraggable: ->
    this.$('.tool').draggable
      connectToSortable: '.' + Tangram.blocks.Container.CONTAINER_CLASS
      helper: "clone"
      revert: "invalid"
