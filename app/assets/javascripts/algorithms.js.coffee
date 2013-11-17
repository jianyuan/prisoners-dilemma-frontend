class AlgorithmEditor
  constructor: ->
    @initCodeMirror()
    @$syntaxCheckerResponse = $('[data-syntax-checker-response]')
    @$benchmarkResponse = $('[data-benchmark-response]')
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

  handleBenchmarkResponse: (data) ->
    console.log data
    @$benchmarkResponse.html(JST['templates/benchmark_response'](data))

$ ->
  if $('body.algorithms.edit').length > 0
    window.algorithmEditor = new AlgorithmEditor

  $('pre code').each (i, e) ->
    hljs.highlightBlock(e)