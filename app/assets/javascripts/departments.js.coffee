source = new EventSource('/departments/show')
source.addEventListener 'messages.create', (e) ->
  message = $.parseJSON(e.data)
  $('.pagination-centered').append($('<li>').text("#{message}: #{message}"))
