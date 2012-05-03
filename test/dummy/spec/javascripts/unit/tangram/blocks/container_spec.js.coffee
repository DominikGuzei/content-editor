
describe 'Tangram.blocks.Container', ->

  beforeEach ->

    @wrapper = jQuery '<div>'
    @testMarkup = '<h1>Headline</h1><p class="test">Test Markup</p>'



    # simulate registered blocks on editor
    @headlineBlockStub = create: @stub()
    @paragraphBlockStub = create: @stub()

    # fake method for mapping elements to blocks
    @editor = getBlockForElement: (element) =>
      return @headlineBlockStub if element.is 'h1'
      return @paragraphBlockStub if element.is 'p.test'

    @container = Tangram.blocks.Container.create
      editor: @editor
      markup: @testMarkup


  describe 'creating a container with markup', ->

    it 'should create blocks for all child elements within markup', ->
      @container.appendTo @wrapper

      Ember.run.end()

      (expect @headlineBlockStub.create).toHaveBeenCalled()
      (expect @paragraphBlockStub.create).toHaveBeenCalled()


  describe 'returning markup for all child blocks', ->

    beforeEach ->
      @headlineBlockInstance = getMarkup: @stub().returns "headline"
      @headlineBlockStub.create.returns @headlineBlockInstance

      @paragraphBlockInstance = getMarkup: @stub().returns "paragraph"
      @paragraphBlockStub.create.returns @paragraphBlockInstance

      @container.appendTo @wrapper

      Ember.run.end()

    it 'should get the markup of all child blocks', ->
      @container.getMarkup()

      (expect @headlineBlockInstance.getMarkup).toHaveBeenCalled()
      (expect @paragraphBlockInstance.getMarkup).toHaveBeenCalled()

    it 'should concatenate the markup of all child blocks and return it', ->
      generatedMarkup = @container.getMarkup()

      (expect generatedMarkup).toEqual "headlineparagraph"

