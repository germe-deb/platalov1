-- player script

-- key mapping (usando baton)
local batonplayer = Baton.new {
  controls = {
    left = {'key:left', 'button:dpleft', 'axis:leftx-'},
    right = {'key:right', 'button:dpright', 'axis:leftx+'},
    up = {'key:up', 'button:dpup', 'axis:lefty-'},
    down = {'key:down', 'button:dpdown', 'axis:lefty+'},
    
    action = {'key:t', 'key:space', 'button:b'},
  },
  pairs = {
      move = {"left", "right", "up", "down"}
  },
  joystick = love.joystick.getJoysticks()[1],
}

-- some variables
local acc = {x=0, y=0, initial=-0.55}
local playerc = {x=8, y=8, w=8, h=8}

local bumpplayer = {playerc.x, playerc.y, playerc.w, playerc.h}
World:add(bumpplayer, playerc.x, playerc.y, playerc.w, playerc.h)
-- local bumpfeet = {playerc.x, playerc.y+3.6, playerc.w*0.8, playerc.h*0.2}
-- World:add(bumpfeet, playerc.x, playerc.y+3.6, playerc.w*0.8, playerc.h*0.2)

Player = {}

function Player:load()
  -- playerc.x
  -- playerc.y
  -- playerc.w
  -- playerc.h
  

end

function Player:update(dt)
  batonplayer:update(dt)
  local goalX, goalY = playerc.x, playerc.y

  -- code for X movement
  if batonplayer:down 'left' then
    goalX = playerc.x - 80*dt
    --playerc.x = playerc.x - 4*8*dt
  end
  if batonplayer:down 'right' then
    goalX = playerc.x + 80*dt
    --playerc.x = playerc.x + 4*8*dt
  end
  
  -- code for gravity
  -- si bumpplayer no esta en el piso
  if Onground == false then
    acc.y = acc.y +1.4*dt
  end
  -- max gravity
  if acc.y > 1 then acc.y = 1 end
  -- agregar la aceleración a goalY
  goalY = playerc.y + acc.y
  
  if batonplayer:down 'action' and Onground == true then
    acc.y = acc.initial
    goalY = playerc.y + acc.y
  end

  -- try to apply goal to the actual player coords
  local cols = 0
  -- _, _, _, LenF = World:move(bumpfeet, goalX, goalY)
  playerc.x, playerc.y, cols, LenP = World:move(bumpplayer, goalX, goalY)
  if LenP ~= 0 and acc.y >= 0 then
    Onground = true
    print('onground true')
  else
    Onground = false
    print('onground false')
  end

  -- debug
  for i=1,LenP do
    print('collided with ' .. tostring(cols[i].other))
  end
  
  Axel = acc.y
end

function Player:draw()
  love.graphics.push("all")
  love.graphics.setColor(1,0,1,0.25)
  love.graphics.rectangle("fill", playerc.x, playerc.y, playerc.w, playerc.h)
  love.graphics.setColor(1,0,1)
  love.graphics.rectangle("line", playerc.x, playerc.y, playerc.w, playerc.h)
  love.graphics.pop()
end
