
describe "Tangram", ->

  afterEach -> Tangram.editors.length = 0 # clear any created test editors

  describe 'registration of block plugins', ->

    it 'should allow mapping of blocks to element selectors', ->
      paragraphBlockFake = {}

      Tangram.registerBlock paragraphBlockFake, 'p.test'

      (expect Tangram.getBlockForElement jQuery '<p class="test">').toBe paragraphBlockFake


  describe 'replacing elements with editor instances', ->

    beforeEach ->
      @elementFake = {}
      @stub Tangram, 'Editor'

    it 'should create editor instance and provide element as parameter', ->
      Tangram.replace @elementFake

      (expect Tangram.Editor.calledWithNew()).toBe true
      (expect Tangram.Editor).toHaveBeenCalledWith @elementFake

    it 'should return an editor instance' , ->
      fakeEditorInstance = {}
      Tangram.Editor.returns fakeEditorInstance

      replaceReturnValue = Tangram.replace @elementFake

      (expect replaceReturnValue).toBe fakeEditorInstance


  describe 'updating replaced form elements', ->

    beforeEach ->
      @editorInstanceFake = updateElement: @spy()
      (@stub Tangram, 'Editor').returns @editorInstanceFake

      # create two fake editor instances
      Tangram.replace {}
      Tangram.replace {}

    it 'should tell all editor instances to update their elements', ->
      Tangram.updateAllEditorElements()

      (expect @editorInstanceFake.updateElement).toHaveBeenCalledTwice()