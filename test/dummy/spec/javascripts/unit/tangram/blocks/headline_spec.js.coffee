

describe 'Tangram.blocks.Headline', ->

  Headline = Tangram.blocks.Headline


  beforeEach ->
    @wrapper = jQuery '<div>'
    @headlineText = 'some headline'
    @headline = (jQuery "<h1>#{@headlineText}</h1>").appendTo @wrapper


  it 'should swap the headline with the ember view', ->
    @headlineBlock = Headline.create blockElement: @headline

    Ember.run.end()

    (expect @wrapper).not.toContain @headline
    (expect @wrapper).toContain @headlineBlock.get 'element'

  it 'should set currentSize from replaced headline', ->
    @headlineBlock = Headline.create blockElement: @headline

    Ember.run.end()

    (expect @headlineBlock.get 'currentSize').toBe 'h1'

  it 'should take text from the replaced headline', ->
    @headlineBlock = Headline.create blockElement: @headline

    Ember.run.end()

    (expect @headlineBlock.get 'text').toBe @headline.text()


  describe 'getting the changed markup of the headline', ->

    beforeEach ->
      @headlineBlock = Headline.create blockElement: @headline


    it 'should return', ->
      headlineText = "test"
      headlineSize = 'h6'

      @headlineBlock.set 'text', headlineText
      @headlineBlock.set 'currentSize', headlineSize

      markup = @headlineBlock.getMarkup()

      (expect markup).toEqual "<h6>test</h6>"