

describe 'Tangram.blocks.Headline', ->

  Headline = Tangram.blocks.Headline

  it 'registers itself for all headline tags', ->
    (expect Tangram.getBlockForElement jQuery '<h1>').toBe Headline
    (expect Tangram.getBlockForElement jQuery '<h2>').toBe Headline
    (expect Tangram.getBlockForElement jQuery '<h3>').toBe Headline
    (expect Tangram.getBlockForElement jQuery '<h4>').toBe Headline
    (expect Tangram.getBlockForElement jQuery '<h5>').toBe Headline
    (expect Tangram.getBlockForElement jQuery '<h6>').toBe Headline


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


  describe 'saving the changes back as headline element', ->

    beforeEach ->
      @headlineBlock = Headline.create blockElement: @headline


    it 'should replace the ember view with an correct headline element', ->
      headlineText = "test"
      headlineSize = 'h6'

      @headlineBlock.set 'text', headlineText
      @headlineBlock.set 'currentSize', headlineSize

      @headlineBlock.save()

      Ember.run.end()

      (expect @wrapper).not.toContain @headlineBlock.get 'element'
      (expect @wrapper).toContain headlineSize
      (expect @wrapper.find headlineSize).toHaveText headlineText