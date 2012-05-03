
describe 'Tangram.ToolBar', ->

  beforeEach ->
    @wrapper = jQuery '<div>'
    @editorFake = {}
    @toolBar = Tangram.ToolBar.create editor: @editorFake


  describe 'creating the tools when inserted into DOM', ->

    beforeEach ->
      #simulate registered block for 'h1' selector
      @headlineBlock = getToolMarkup: -> '<div id="headline-tool">'
      @paragraphBlock = getToolMarkup: -> '<div id="paragraph-tool">'

      @editorFake.selectorToBlockMap =
        h1: @headlineBlock
        p: @paragraphBlock


    it 'should concatenate the tool markup of all blocks and insert it', ->
      @toolBar.appendTo @wrapper

      Ember.run.end()

      (expect @toolBar.$ '.tools').toContain 'div#headline-tool'
      (expect @toolBar.$ '.tools').toContain 'div#paragraph-tool'