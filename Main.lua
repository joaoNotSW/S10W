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
  ALERT = false
  APP_STATE = "MENU"
  mainMenu = Menu()
  
  socket = require("socket")  
  server, port = "192.168.1.178", 1999
  tcp = assert(socket.tcp())
end

function draw()
  background(245)

  if APP_STATE == "MENU" then
    mainMenu:draw()
  else
        NESTED_GRID:draw()
    if APP_STATE == "Online Multiplayer" then
        r, rr, rrr = socket.select({tcp}, nil, 0.1)
            if(r[tcp] ~= nil) then
                s = tcp:receive()
                touch = Touch(NESTED_GRID.x + tonumber(s:sub(3,3))*HEIGHT/3 + tonumber(s:sub(7,7))*HEIGHT/9 + HEIGHT/27, NESTED_GRID.y + tonumber(s:sub(5,5))*HEIGHT/3 + tonumber(s:sub(9,9))*HEIGHT/9 + HEIGHT/27)
                if CURRENT_PLAYER == "O" and NESTED_GRID:touched(touch, CURRENT_PLAYER) == 0 then
                    if CURRENT_PLAYER == "X" then
                        CURRENT_PLAYER = "O"
                        NESTED_GRID.nextPlayer = "O"
                    else
                        CURRENT_PLAYER = "X"
                        NESTED_GRID.nextPlayer = "X"
                    end
                end
            end
    end
        
    GAME_WINNER = NESTED_GRID:checkwin()
    if GAME_WINNER ~= nil and ALERT == false then
        ALERT = true
        NESTED_GRID.winner = GAME_WINNER
        alert("Toque em qualquer sitio depois de ok para jogar de novo", "Jogador "..GAME_WINNER.." ganhou!")
    end
  end
end

function touched(touch)
  if APP_STATE == "MENU" then
    res = mainMenu:touched(touch)
    if res ~= 0 then
        APP_STATE = res
        if res == "Online Multiplayer" then
            tcp:connect(server, port)
        end
    end
        
  elseif APP_STATE == "Multiplayer" or APP_STATE == "Online Multiplayer" then
    if GAME_WINNER == nil then
            if NESTED_GRID:touched(touch, CURRENT_PLAYER) == 0 then
                if CURRENT_PLAYER == "X" then
                    CURRENT_PLAYER = "O"
                    NESTED_GRID.nextPlayer = "O"
                else
                    CURRENT_PLAYER = "X"
                    NESTED_GRID.nextPlayer = "X"
                end
            end
        else
            if touch.state == ENDED then
                restart()
            end
        end
    elseif APP_STATE == "Single Player" then
        --will develop ai later on
        print("nothing yet")
    end
end

function restart()
  setup()
end
