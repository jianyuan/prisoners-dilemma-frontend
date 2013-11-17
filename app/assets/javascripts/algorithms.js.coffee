class AlgorithmEditor
  constructor: ->
    @initCodeMirror()
    @$syntaxCheckerResponse = $('[data-syntax-checker-response]')
  initCodeMirror: ->
    cm = CodeMirror.fromTextArea($('#algorithm_code')[0],
      mode: 'python'
      theme: 'monokai'
      indentUnit: 4
      lineNumbers: true
      autofocus: true
      viewportMargin: Infinity
    )
  handleSyntaxCheckerResponse: (data) ->
    @$syntaxCheckerResponse.html(JST['templates/syntax_checker_response'](data))

$ ->
  if $('body.algorithms.edit').length > 0
    window.algorithmEditor = new AlgorithmEditor