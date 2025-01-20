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
-- local anim8 = require 'lib/anim8/anim8'
-- https://github.com/excessive/i18n translations
-- local i18n require "lib/i18n/i18n"
-- https://github.com/kikito/gamera camera
local gamera = require 'lib/gamera/gamera'

-- variables
local gamescale = 4
LenP = 0
Axel = 0
PLmGY = 0
Cameraoffset = {x = -80, y = -60}

-- bump
-- crear un mundo en bump
World = bump.newWorld(32)
-- sti
-- cargar el mapa
--Map = sti("assets/maps/debug map.lua", {"bump"})
Map = sti("assets/maps/begginings.lua", {"bump"})
-- iniciar integracíon de sti con bump.
-- Map pertenece a sti, y bump_init es un plugin de sti para
-- darle info a bump.
Map:bump_init(World)
Map.layers.object.visible = false
Map.layers.spike.visible = false
Map.layers.special.visible = false

-- camera
Gam = gamera.new(0,0,512,512)

-- archivo lua del jugador
require("assets/scripts/player")

local function drawCameraStuff(l, t, w, h)
  -- MUNDO
  -- love.graphics.push("all")
  -- love.graphics.scale(gamescale, gamescale)

  -- dibujar el mapa
  -- Map:draw(0, 0, gamescale, gamescale)
  -- debug
  Map:draw(gamescale*8*5.5667 - Gam:getXPosition() + Cameraoffset.x + 2,
           gamescale*8*4.2 - Gam:getYPosition() + Cameraoffset.y + 1,
           gamescale,
           gamescale)

  -- dibujar al jugador
  Player:draw()
  -- mundo
  -- love.graphics.pop()
end

function love.load()
  Gam:setScale(gamescale)
end

function love.update(dt)
  Player:update(dt)
end

function love.draw()
  -- camera
  Gam:draw(drawCameraStuff)
  
  -- aquí estaba el código que dibujaba el mundo
  -- y el jugador, que fue movido a la función de arriba
  
  -- INTERFAZ
  love.graphics.setColor(1, 1, 1, 1)
  -- mover el cursor hacia abajo
  love.graphics.print("aceleración: " .. tostring(Axel), 0, 20)
  love.graphics.print("goaly - pl.y: " .. tostring(PLmGY), 0, 40)
  love.graphics.print("offset x: " .. tostring(Cameraoffset.x), 0, 60)
  love.graphics.print("offset x: " .. tostring(Cameraoffset.y), 0, 80)
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end
