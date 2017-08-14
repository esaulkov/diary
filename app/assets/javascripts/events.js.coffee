$(document).ready ->
  $(".share_event").click (e) ->
    e.preventDefault()
    event_id = $(this).attr('id')
    $('#event_id').val(event_id)
    $(".modal").modal('show')