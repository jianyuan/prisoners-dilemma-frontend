$ ->
  $('[data-countdown]').each ->
    $this = $(this)
    $this.countdown
      until: $this.text()
      compact: true