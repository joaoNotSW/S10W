-- S10W

displayMode(FULLSCREEN)
supportedOrientations(LANDSCAPE_ANY)

function setup()
    NEST_LEVEL = 1
    PLAYER_NUMBER = 2
    NESTED_GRID_POS = (WIDTH - HEIGHT)/2
    NESTED_GRID_SIZE = HEIGHT

    --MAIN_GRID = Grid(GRID_POS, 0, GRID_SIZE)
    NESTED_GRID = NestedGrid(NESTED_GRID_POS, 0, NESTED_GRID_SIZE)
    --CURRENT_PLAYER = "X"
end

function draw()
    background(0)

    NESTED_GRID:draw()
end

function touched(touch)
  if MAIN_GRID:touched(touch, CURRENT_PLAYER) == 0 then
    if CURRENT_PLAYER == "X" then
      CURRENT_PLAYER = "O"
    else
      CURRENT_PLAYER = "X"
    end

    winner = MAIN_GRID:checkwin()
    if winner ~= "CLOSED" then
      print("WINNER:", winner)
      MAIN_GRID.winner = winner
      --setup()
    end

  end
end
