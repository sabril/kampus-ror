App.reviews = App.cable.subscriptions.create "ReviewsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#review_list').prepend data.review
    $('#form_review').remove();
    $('#no_review').remove();
    load_rating();

