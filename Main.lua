-- S10W

displayMode(FULLSCREEN)
supportedOrientations(LANDSCAPE_ANY)

function setup()
    NEST_LEVEL = 1
    NESTED_GRID_POS = (WIDTH - HEIGHT)/2
    NESTED_GRID_SIZE = HEIGHT

    NESTED_GRID = NestedGrid(NESTED_GRID_POS, 0, NESTED_GRID_SIZE)
    CURRENT_PLAYER = "X"
end

function draw()
    background(215)

    NESTED_GRID:draw()
end

function touched(touch)
  if NESTED_GRID:touched(touch, CURRENT_PLAYER) == 0 then
    if CURRENT_PLAYER == "X" then
      CURRENT_PLAYER = "O"
    else
      CURRENT_PLAYER = "X"
    end

    winner = NESTED_GRID:checkwin()
    if winner ~= nil then
      print (winner)
      NESTED_GRID.winner = winner
    end

  end
end
