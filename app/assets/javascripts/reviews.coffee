# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#review_rating').raty
    path: '/assets'
    scoreName: 'review[star]'
    score: 4
  $('.review_star').raty
    path: '/assets'
    score: -> 
      $(this).attr('data-score')
    readOnly: true