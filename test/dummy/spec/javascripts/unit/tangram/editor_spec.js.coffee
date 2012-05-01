
describe 'Tangram.Editor', ->

  beforeEach ->

    # simulate textarea within a form
    @wrapper = jQuery '<div>'
    @textarea = jQuery '<textarea><h1>headline</h1><p class="test">text</p></textarea>'
    @textarea.appendTo @wrapper

    # register fake blocks for selectors
    @headlineBlockStub = @stub()
    @paragraphBlockStub = @stub()

    Tangram.registerBlock @headlineBlockStub, 'h1'
    Tangram.registerBlock @paragraphBlockStub, 'p.test'


  describe 'initialising an editor instance', ->

    describe 'replacing a textarea', ->

      it 'should hide the textarea and append an editor instance directly after it', ->
        new Tangram.Editor @textarea[0]

        (expect @wrapper).toContain @textarea
        (expect @textarea).toBeHidden()
        (expect @wrapper).toContain "div.#{Tangram.Editor.CSS_CLASS}"

      it 'should create blocks for all child elements', ->
        new Tangram.Editor @textarea[0]

        (expect @headlineBlockStub).toHaveBeenCalledWithNew()
        (expect @headlineBlockStub.args[0][0]).toBe 'h1'
        (expect @paragraphBlockStub).toHaveBeenCalledWithNew()
        (expect @paragraphBlockStub.args[0][0]).toBe 'p.test'


  describe 'updating underlying form element', ->

    describe 'updating a textarea', ->

      beforeEach ->
        @headlineBlockInstance = preview: @spy()
        @headlineBlockStub.returns @headlineBlockInstance

        @paragraphBlockInstance = preview: @spy()
        @paragraphBlockStub.returns @paragraphBlockInstance

        @editor = new Tangram.Editor @textarea[0]

      it 'should tell all blocks to go into preview mode', ->
        @editor.updateElement()

        (expect @headlineBlockInstance.preview).toHaveBeenCalled()
        (expect @paragraphBlockInstance.preview).toHaveBeenCalled()

      it 'should copy the preview markup into the textarea', ->
        editorElement = @editor.rootElement

        changedContent = "<h2>Changed title</h2>"
        editorElement.html changedContent

        @editor.updateElement()

        (expect @textarea.val()).toEqual changedContent