
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

    @headlineBlock = new Headline @headline


  describe 'edit mode', ->

    it 'should swap the headline with a textfield when editing starts', ->
      @headlineBlock.onEdit()

      (expect @headlineBlock.input).toHaveValue @headlineText

    it 'should update the input every time with the headline text', ->
      currentText = "first value"
      @headlineBlock.element.text currentText

      @headlineBlock.onEdit()

      (expect @headlineBlock.input).toHaveValue currentText

  describe 'preview mode', ->

    it 'should swap the edit textfield back to the headline', ->
      @headlineBlock.onEdit()

      changedText = 'changed text'
      @headlineBlock.input.val changedText

      @headlineBlock.onPreview()

      (expect @wrapper).not.toContain 'input[type=text]'
      (expect @wrapper).toContain @headline
      (expect @headline).toHaveText changedText