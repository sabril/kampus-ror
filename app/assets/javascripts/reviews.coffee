# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  load_rating = ->
    $('#review_rating').raty
      path: '/images'
      scoreName: 'review[star]'
      score: 4
    $('.review_star').raty
      path: '/images'
      score: -> 
        $(this).attr('data-score')
      readOnly: true
  load_rating()
  window.load_rating = load_rating