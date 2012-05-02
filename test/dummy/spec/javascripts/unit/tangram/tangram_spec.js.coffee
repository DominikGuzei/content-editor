
describe "Tangram", ->

  afterEach -> Tangram.editors.length = 0 # clear any created test editors

  describe 'registration of block plugins', ->

    it 'should provide a namespace for blocks', ->
      (expect Tangram.blocks).toBeDefined()

    it 'should allow mapping of blocks to element selectors', ->
      paragraphBlockFake = {}

      Tangram.registerBlock paragraphBlockFake, 'p.test'

      (expect Tangram.getBlockForElement jQuery '<p class="test">').toBe paragraphBlockFake


  describe 'replacing textarea with editor instances', ->

    beforeEach ->
      @textareaFake = {}
      @stub Tangram.Editor, 'create'

    it 'should create editor instance and provide element as parameter', ->
      Tangram.replace @textareaFake

      (expect Tangram.Editor.create).toHaveBeenCalled()
      (expect Tangram.Editor.create.args[0][0]).toEqual { textarea: @textareaFake }

    it 'should return editor instance', ->
      editorFakeInstance = {}
      Tangram.Editor.create.returns editorFakeInstance

      editor = Tangram.replace @textareaFake

      (expect editor).toBe editorFakeInstance


  describe 'updating replaced form elements', ->

    beforeEach ->
      @editorInstanceFake = updateElement: @spy()
      (@stub Tangram.Editor, 'create').returns @editorInstanceFake

      # create two fake editor instances
      Tangram.replace {}
      Tangram.replace {}

    it 'should tell all editor instances to update their elements', ->
      Tangram.updateAllEditorElements()

      (expect @editorInstanceFake.updateElement).toHaveBeenCalledTwice()