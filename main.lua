-- SPDX-FileCopyrightText: 2024 dpkgluci
--
-- SPDX-License-Identifier: MIT

-- libraries:
-- https://github.com/tesselode/Baton input management
Baton = require 'lib/baton/baton'
-- https://github.com/tesselode/Baton collision and reaction
local bump = require 'lib/bump/bump'
-- https://github.com/karai17/Simple-Tiled-Implementation maps
local sti = require 'lib/sti/sti'
-- https://github.com/kikito/anim8 sprite animations
local anim8 = require 'lib/anim8/anim8'
-- https://github.com/vrld/hump camera library
local camera = require 'lib/hump/camera'

-- variables
local gamescale = 4
Onground = false
LenP = 0
-- LenF = 0
Axel = 0

-- bump
-- crear un mundo en bump
World = bump.newWorld(32)
-- sti
-- cargar el mapa
local map = sti("assets/maps/debug map.lua", {"bump"})
-- iniciar integracíon de sti con bump.
-- map pertenece a sti, y bump_init es un plugin de sti para
-- darle info a bump.
map:bump_init(World)
map.layers.object.visible = false

-- archivo lua del jugador
require("assets/scripts/player")

--[[
-- me quedo con esta función que dibuja lindo los bloques
-- aunque no la vamos a usar jaja

-- dibujar bloques
local function drawBlocks()
  for _,block in ipairs(blocks) do
    drawBox(block, 1,0,0)
  end
end

-- helper function
function drawBox(box, r,g,b)
  love.graphics.push("all")
  love.graphics.setColor(r,g,b,0.25)
  love.graphics.rectangle("fill", box.x, box.y, box.w, box.h)
  love.graphics.setColor(r,g,b)
  love.graphics.rectangle("line", box.x, box.y, box.w, box.h)
  love.graphics.pop()
end
]]

-- draw player
--[[
function drawPlayer()
  love.graphics.push("all")
  love.graphics.setColor(1,0,1,0.25)
  love.graphics.rectangle("fill", Playerc.x, Playerc.y, Playerc.w, Playerc.h)
  love.graphics.setColor(1,0,1)
  love.graphics.rectangle("line", Playerc.x, Playerc.y, Playerc.w, Playerc.h)
  love.graphics.pop()
end
]]

-- aca empieza el codigo

function love.load()
  Player:load()

end

function love.update(dt)
  -- refrescar el input

  -- bump world update

  Player:update(dt)
  -- hay que rehacer esto con las fisicas en cuenta 
  --[[
  if Batonplayer:down 'left' then
    Playerc.x = Playerc.x - 4*8*dt
  end
  if Batonplayer:down 'right' then
    Playerc.x = Playerc.x + 4*8*dt
  end
  ]]

  -- bumpPlayercollision = World:check(bumpplayer)
end

function love.draw()
  -- INTERFAZ
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.print(tostring(Onground), 0, 0)
  -- mover el cursor hacia abajo
  love.graphics.print(tostring(Axel), 0, 20)
  
  -- MUNDO
  love.graphics.push("all")
  love.graphics.scale(gamescale, gamescale)

  -- dibujar al jugador
  Player:draw()

  -- dibujar el mapa
  map:draw(0, 0, gamescale, gamescale)
  love.graphics.pop()
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end

