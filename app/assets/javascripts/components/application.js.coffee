$(document).ready ->
  # Show login form in modal mode
  $('@login').click (e) ->
    e.preventDefault()
    $('@login-modal').fadeToggle()
    $('@modal-killer').show()

  # If you click outside the login form
  # it is its close
  $('@modal-killer').click (e) ->
    e.preventDefault()
    $('@login-modal').fadeToggle()
    $(this).hide()

  # Concat tag names to input
  $('@tag-picker').click (e) ->
    e.preventDefault()
    input = $('@tags-collector')
    input.val [input.val(), $(this).text()].join(' ')

  # Datepickers
  $('@datepicker').datepicker
    dateFormat: 'dd/mm/yy'
  