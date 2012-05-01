
class @Tangram

  @editors: []
  @typeToBlockMap: {}

  @registerBlock: (block, selector) ->
    Tangram.typeToBlockMap[selector] = block

  @getBlockForElement: (element) ->
    foundBlock = null

    for selector, block of Tangram.typeToBlockMap
      foundBlock = block if element.is selector

    return foundBlock

  @replace: (element) ->
    editor = new Tangram.Editor element
    Tangram.editors.push editor

    return editor

  @updateAllEditorElements: ->
    for editor in Tangram.editors
      editor.updateElement()