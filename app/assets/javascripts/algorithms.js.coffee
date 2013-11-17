class AlgorithmEditor
  constructor: ->
    @initCodeMirror()
  initCodeMirror: ->
    cm = CodeMirror.fromTextArea($('#algorithm_code')[0],
      mode: 'python'
      theme: 'monokai'
      indentUnit: 4
      lineNumbers: true
      autofocus: true
      viewportMargin: Infinity
    )

$ ->
  if $('body.algorithms.edit').length > 0
    new AlgorithmEditor