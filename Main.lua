-- S10W

displayMode(FULLSCREEN)
supportedOrientations(LANDSCAPE_ANY)

function setup()
    NEST_LEVEL = 1
    PLAYER_NUMBER = 2
    GRID_POS = (WIDTH - HEIGHT)/2
    GRID_SIZE = HEIGHT

    MAIN_GRID = Grid(GRID_POS, 0, GRID_SIZE)
    CURRENT_PLAYER = "X"
end

function draw()
    background(255)
    MAIN_GRID:draw()
end

function touched(touch)
  MAIN_GRID:touched(touch, CURRENT_PLAYER)
end
