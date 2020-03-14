-- S10W
-- 10, by sw -> S10W
--
-- March, 2020

displayMode(FULLSCREEN)
supportedOrientations(LANDSCAPE_ANY)

function setup()
  NESTED_GRID = NestedGrid((WIDTH - HEIGHT)/2, 0, HEIGHT)

  CURRENT_PLAYER = "X"
end

function draw()
  background(245)

  NESTED_GRID:draw()
end

function touched(touch)
  if NESTED_GRID:touched(touch, CURRENT_PLAYER) == 0 then
    if CURRENT_PLAYER == "X" then
      CURRENT_PLAYER = "O"
      NESTED_GRID.nextPlayer = "O"
    else
      CURRENT_PLAYER = "X"
      NESTED_GRID.nextPlayer = "X"
    end

    winner = NESTED_GRID:checkwin()
    if winner ~= nil then
      print (winner)
      NESTED_GRID.winner = winner
    end

  end
end
