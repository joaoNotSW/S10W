-- S10W
-- 10, by sw -> S10W
--
-- March, 2020

displayMode(FULLSCREEN)
--supportedOrientations(LANDSCAPE_ANY)

function setup()
  NESTED_GRID = NestedGrid((WIDTH - HEIGHT)/2, 0, HEIGHT)

  CURRENT_PLAYER = "X"
  GAME_WINNER = nil
  APP_STATE = "MENU"
  mainMenu = Menu()
end

function draw()
  background(245)

  if APP_STATE == "MENU" then
    mainMenu:draw()
  else
    NESTED_GRID:draw()
  end
end

function touched(touch)
  if APP_STATE == "MENU" then
    if mainMenu:touched(touch) == 1 then
        APP_STATE = "othee" 
    end
  else
    NESTED_GRID:draw()
        
    if GAME_WINNER == nil then
            if NESTED_GRID:touched(touch, CURRENT_PLAYER) == 0 then
                if CURRENT_PLAYER == "X" then
                    CURRENT_PLAYER = "O"
                    NESTED_GRID.nextPlayer = "O"
                else
                    CURRENT_PLAYER = "X"
                    NESTED_GRID.nextPlayer = "X"
                end
                
                GAME_WINNER = NESTED_GRID:checkwin()
                if GAME_WINNER ~= nil then
                    NESTED_GRID.winner = GAME_WINNER
                    alert("Toque em qualquer sitio depois de ok para jogar de novo", "Jogador "..GAME_WINNER.." ganhou!")
                end
            end
        else
            if touch.state == ENDED then
                restart()
            end
        end
  end

end

function restart()
  setup()
end
