
describe 'Tangram.ToolBar', ->

  beforeEach ->
    @wrapper = jQuery '<div>'
    @editorFake = getTypeToBlockMap: @stub()
    @toolBar = Tangram.ToolBar.create editor: @editorFake


  describe 'creating the tools when inserted into DOM', ->

    beforeEach ->
      #simulate registered block for 'h1' selector
      @headlineBlock = getToolMarkup: -> '<div id="headline-tool">'
      @paragraphBlock = getToolMarkup: -> '<div id="paragraph-tool">'

      @editorFake.getTypeToBlockMap.returns
        h1: @headlineBlock
        p: @paragraphBlock


    it 'should get all registered blocks from Tangram', ->
      @toolBar.appendTo @wrapper

      Ember.run.end()

      (expect @editorFake.getTypeToBlockMap).toHaveBeenCalled()

    it 'should concatenate the tool markup of all blocks and insert it', ->
      @toolBar.appendTo @wrapper

      Ember.run.end()

      (expect @toolBar.$ '.tools').toContain 'div#headline-tool'
      (expect @toolBar.$ '.tools').toContain 'div#paragraph-tool'