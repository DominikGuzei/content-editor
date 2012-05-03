
describe 'Tangram.Editor', ->

  beforeEach ->

    # simulate textarea within a form
    @wrapper = jQuery '<div>'
    @textarea = jQuery '<textarea><h1>headline</h1><p class="test">text</p></textarea>'
    @textarea.appendTo @wrapper

    @containerInstanceMock = appendTo: @spy()
    (@stub Tangram.blocks.Container, 'create').returns @containerInstanceMock

    @toolbarInstance = appendTo: @spy()
    (@stub Tangram.ToolBar, 'create').returns @toolbarInstance


  describe 'initialising an editor instance', ->

    describe 'replacing a textarea', ->

      it 'should hide the textarea and append an editor instance directly after it', ->
        editor = Tangram.Editor.create textarea: @textarea[0]

        (expect @wrapper).toContain @textarea
        (expect @textarea).toBeHidden()
        (expect @wrapper).toContain editor.rootElement

      it 'should create a block container with markup and append it', ->
        editor = Tangram.Editor.create textarea: @textarea[0]

        editor.ready()

        (expect Tangram.blocks.Container.create.args[0][0].markup).toEqual @textarea.val()
        (expect @containerInstanceMock.appendTo).toHaveBeenCalledWith editor.rootElement

    describe 'creating the toolbar', ->

      it 'should create the toolbar and append it to the root element', ->
        editor = Tangram.Editor.create textarea: @textarea[0]

        editor.ready()

        (expect Tangram.ToolBar.create).toHaveBeenCalled()
        (expect Tangram.ToolBar.create.args[0][0].editor).toBe editor
        (expect @toolbarInstance.appendTo).toHaveBeenCalledWith editor.rootElement

  describe 'updating underlying form element', ->

    describe 'updating a textarea', ->

      beforeEach ->
        @testMarkup = "headline"
        @containerInstanceMock.getMarkup = @stub().returns @testMarkup
        @editor = Tangram.Editor.create textarea: @textarea[0]

      it 'should get the container markup and copy it into the textarea', ->
        @editor.updateElement()

        (expect @containerInstanceMock.getMarkup).toHaveBeenCalled()
        (expect @textarea.val()).toEqual @testMarkup


  describe 'registration of block plugins', ->

    it 'should take block to selector map on creation', ->
      paragraphBlockFake = {}
      headlineBlockFake = {}

      map =
        'p.test': paragraphBlockFake
        'h1': headlineBlockFake

      @editor = Tangram.Editor.create selectorToBlockMap: map

      (expect @editor.getBlockForElement jQuery '<p class="test">').toBe paragraphBlockFake
      (expect @editor.getBlockForElement jQuery '<h1>').toBe headlineBlockFake