class AlgorithmEditor
  constructor: ->
    @$form = $('form.edit_algorithm')
    @$btnCheckSyntax = $('[data-action=check-syntax]')
    @$btnBenchmark = $('[data-action=benchmark]')
    @$syntaxCheckerResponse = $('[data-syntax-checker-response]')
    @$benchmarkResponse = $('[data-benchmark-response]')

    # State
    @doSyntaxCheckLater = false
    @doBenchmarkLater = false

    $.safetynet()
    @initForm()
    @initCodeMirror()
    @initSyntaxChecker()
    @initBenchmark()
  initForm: ->
    @$form.on 'ajax:before', =>
      @cm.save()

    @$form.on 'ajax:success', =>
      $.safetynet.clearAllChanges()
      if @doSyntaxCheckLater
        @doSyntaxCheckLater = false
        @$btnCheckSyntax.click()
      if @doBenchmarkLater
        @$doBenchmarkLater = false
        @$btnBenchmark.click()
  initCodeMirror: ->
    @cm = CodeMirror.fromTextArea($('#algorithm_code')[0],
      mode: 'python'
      theme: 'monokai'
      indentUnit: 4
      lineNumbers: true
      autofocus: true
      viewportMargin: Infinity
    )

    @cm.on 'change', ->
      $.safetynet.raiseChange 'code-changed'
  initSyntaxChecker: ->
    @$btnCheckSyntax.on 'ajax:before', (e, data, status, xhr) =>
      if $.safetynet.hasChanges()
        @doSyntaxCheckLater = true
        @$form.submit()
        return false

    @$btnCheckSyntax.on 'ajax:success', (e, data, status, xhr) =>
      @$syntaxCheckerResponse.html(JST['templates/syntax_checker_response'](data))

    @$btnCheckSyntax.on 'ajax:error', @errorHandler
  initBenchmark: ->
    @$btnBenchmark.on 'ajax:before', (e, data, status, xhr) =>
      if $.safetynet.hasChanges()
        @doBenchmarkLater = true
        @$form.submit()
        return false

    @$btnBenchmark.on 'ajax:success', (e, data, status, xhr) =>
      @$benchmarkResponse.html(JST['templates/benchmark_response'](data))

    @$btnBenchmark.on 'ajax:error', @errorHandler
  errorHandler: ->
    alert 'Whoops! Compiler server is down!'

$ ->
  if $('body.algorithms.edit').length > 0
    window.algorithmEditor = new AlgorithmEditor

  $('pre code').each (i, e) ->
    hljs.highlightBlock(e)