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
-- https://github.com/vrld/hump camera library
-- local Camera = require 'lib/hump/camera'
-- https://github.com/excessive/i18n translations
-- local i18n require "lib/i18n/i18n"

-- variables
local gamescale = 3
LenP = 0
-- LenF = 0
Axel = 0
PLmGY = 0

-- bump
-- crear un mundo en bump
World = bump.newWorld(32)
-- sti
-- cargar el mapa
Map = sti("assets/maps/debug map.lua", {"bump"})
-- iniciar integracíon de sti con bump.
-- Map pertenece a sti, y bump_init es un plugin de sti para
-- darle info a bump.
Map:bump_init(World)
Map.layers.object.visible = false
Map.layers.spike.visible = false

-- archivo lua del jugador
require("assets/scripts/player")

function love.load()

end

function love.update(dt)
  Player:update(dt)
end

function love.draw()
  -- INTERFAZ
  love.graphics.setColor(1, 1, 1, 1)
  -- mover el cursor hacia abajo
  love.graphics.print("aceleración: " .. tostring(Axel), 0, 20)
  love.graphics.print("goaly - pl.y: " .. tostring(PLmGY), 0, 40)

  -- MUNDO
  love.graphics.push("all")
  love.graphics.scale(gamescale, gamescale)

  -- dibujar al jugador
  Player:draw()

  -- dibujar el mapa
  Map:draw(0, 0, gamescale, gamescale)
  love.graphics.pop()
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end
