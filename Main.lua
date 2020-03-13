-- S10W

displayMode(FULLSCREEN)
supportedOrientations(LANDSCAPE_ANY)

function setup()
    NEST_LEVEL = 1
    PLAYER_NUMBER = 2
    GRID_SIZE = HEIGHT

    
end

function draw()
    background(255)
    tile:draw()
end
