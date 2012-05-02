
class @Tangram

  @editors: []
  @typeToBlockMap: {}
  @blocks: {}

  @registerBlock: (block, selector) ->
    Tangram.typeToBlockMap[selector] = block

  @getBlockForElement: (element) ->
    foundBlock = null

    for selector, block of Tangram.typeToBlockMap
      foundBlock = block if element.is selector

    return foundBlock

  @replace: (textarea) ->
    editor = Tangram.Editor.create textarea: textarea
    Tangram.editors.push editor

    return editor

  @updateAllEditorElements: ->
    for editor in Tangram.editors
      editor.updateElement()