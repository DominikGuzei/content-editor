
class Tangram.blocks.Headline

  element: null
  input: null

  constructor: (@element) ->
    tag = (@element.prop 'tagName').toLowerCase()
    @input = jQuery "<input type='text' class='headline #{tag}' />"

  onEdit: ->
    @input.val @element.text()
    @element.replaceWith @input

  onPreview: ->
    @element.text @input.val()
    @input.replaceWith @element


Tangram.registerBlock Tangram.blocks.Headline, 'h1, h2, h3, h4, h5, h6'