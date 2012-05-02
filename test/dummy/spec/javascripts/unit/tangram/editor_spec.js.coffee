
describe 'Tangram.Editor', ->

  beforeEach ->

    # simulate textarea within a form
    @wrapper = jQuery '<div>'
    @textarea = jQuery '<textarea><h1>headline</h1><p class="test">text</p></textarea>'
    @textarea.appendTo @wrapper

    # register fake blocks for selectors
    @headlineBlockStub = create: @stub()
    @paragraphBlockStub = create: @stub()

    Tangram.registerBlock @headlineBlockStub, 'h1'
    Tangram.registerBlock @paragraphBlockStub, 'p.test'


  describe 'initialising an editor instance', ->

    describe 'replacing a textarea', ->

      it 'should hide the textarea and append an editor instance directly after it', ->
        editor = Tangram.Editor.create textarea: @textarea[0]

        (expect @wrapper).toContain @textarea
        (expect @textarea).toBeHidden()
        (expect @wrapper).toContain editor.rootElement

      it 'should create blocks for all child elements', ->
        editor = Tangram.Editor.create textarea: @textarea[0]

        editor.ready()

        (expect @headlineBlockStub.create).toHaveBeenCalled()
        (expect @paragraphBlockStub.create).toHaveBeenCalled()


  describe 'updating underlying form element', ->

    describe 'updating a textarea', ->

      beforeEach ->
        @headlineBlockInstance = getMarkup: @stub().returns "headline"
        @headlineBlockStub.create.returns @headlineBlockInstance

        @paragraphBlockInstance = getMarkup: @stub().returns "paragraph"
        @paragraphBlockStub.create.returns @paragraphBlockInstance

        @editor = Tangram.Editor.create textarea: @textarea[0]

      it 'should concatenate the markup of all blocks', ->
        @editor.updateElement()

        (expect @headlineBlockInstance.getMarkup).toHaveBeenCalled()
        (expect @paragraphBlockInstance.getMarkup).toHaveBeenCalled()

      it 'should concatenate the markup of all blocks and copy it into the textarea', ->
        @editor.updateElement()

        (expect @headlineBlockInstance.getMarkup).toHaveBeenCalled()
        (expect @paragraphBlockInstance.getMarkup).toHaveBeenCalled()
        (expect @textarea.val()).toEqual "headlineparagraph"