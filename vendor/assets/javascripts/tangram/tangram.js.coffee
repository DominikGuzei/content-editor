
class @Tangram

  @editors: []
  @blocks: {}

  @replace: (textarea, configuration={}) ->
    configuration.textarea = textarea
    editor = Tangram.Editor.create configuration

    Tangram.editors.push editor
    return editor

  @updateAllEditorElements: ->
    for editor in Tangram.editors
      editor.updateElement()