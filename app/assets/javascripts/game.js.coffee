# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@mainInterval = null

$(document).ready ->
  init_cells = 200
  for i in [0..init_cells]
    row = Math.round(Math.random()*boardSize)
    col = Math.round(Math.random()*boardSize)
    unless alive(row, col)
      makeAlive(row, col)
  # setTimeout(mainLoop, 1000)
  window.mainInterval = setInterval(mainLoop, 200)
  # mainLoop()
  $('.main-board td').click (e) ->
    $el = $(e.target)
    $el.attr('data-makealive','true')
  $('.board-stop').click ->
    clearInterval(mainInterval)
    false
  $('.board-start').click ->
    clearInterval(mainInterval)
    window.mainInterval = setInterval(mainLoop, 250)
    false


alive = (row, col) ->
  $el = $elFromCoords(row, col)
  old = $el.css('background-color')
  # $el.css('background-color', 'yellow')
  # $el.css('background-color', old)
  $el.attr('data-alive') != undefined

makeAlive = (row, col) ->
  $el = $elFromCoords(row, col)
  $el.attr('data-alive', "true")

$elFromCoords = (row, col) ->
  $(".main-board td[data-row='#{row}'][data-col='#{col}']")

mainLoop = ->
  for col in [0..boardSize]
    for row in [0..boardSize]
      $el = $elFromCoords(row, col)
      score = calcScore(row, col)
      $el.attr('data-score', score)
      # console.log "row: #{row} col: #{col} score: #{score}"
      if $el.attr('data-alive') == undefined
        if score == 3
          # console.log "awakening cell", $el
          $el.attr('data-nextalive', "true")
      else
        if score == 2 || score == 3
          $el.attr('data-nextalive', "true")
          # console.log "still alive", $el
  $(':not([data-nextalive])').removeAttr('data-alive')
  $('[data-nextalive]').attr('data-alive',"true").removeAttr('data-nextalive')
  $('[data-makealive]').removeAttr('data-makealive').attr('data-alive', "true")








@calcScore = (row, col) ->
  score = 0
  score += 1 if alive(row-1, col)
  score += 1 if alive(row+1, col)
  score += 1 if alive(row-1, col-1)
  score += 1 if alive(row, col-1)
  score += 1 if alive(row+1, col-1)
  score += 1 if alive(row-1, col+1)
  score += 1 if alive(row, col+1)
  score += 1 if alive(row+1, col+1)
  score
