
Tangram.ToolBar = Ember.View.extend

  classNames: ['tangram-toolbar']
  templateName: 'tangram_templates_toolbar'

  editor: null
  blockTypes: null

  didInsertElement: ->
    @blockTypes = @editor.getTypeToBlockMap()

    toolsMarkup = ''

    for selector, block of @blockTypes
      toolsMarkup += block.getToolMarkup()

    this.$('.tools').html toolsMarkup