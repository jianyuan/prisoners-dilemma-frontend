$ ->
  $('[data-countdown]').each ->
    $this = $(this)
    $this.countdown
      until: new Date($this.data('end-time') * 1000)
      compact: true