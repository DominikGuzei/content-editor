
class @Tangram

  @editors: []
  @blocks: {}

  @replace: (textarea) ->
    editor = Tangram.Editor.create textarea: textarea
    Tangram.editors.push editor

    return editor

  @updateAllEditorElements: ->
    for editor in Tangram.editors
      editor.updateElement()