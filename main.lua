-- SPDX-FileCopyrightText: 2024 dpkgluci
--
-- SPDX-License-Identifier: MIT

-- libraries:
-- https://github.com/tesselode/baton input management
local baton = require 'lib/baton/baton'
-- https://github.com/tesselode/baton collision and reaction
local bump = require 'lib/bump/bump'
-- https://github.com/kikito/anim8 sprite animations
local anim8 = require 'lib/anim8/anim8'

-- key mapping (usando baton)
local player = baton.new {
    controls = {
        left = {'key:left', 'button:dpleft', 'axis:leftx-'},
        right = {'key:right', 'button:dpright', 'axis:leftx+'},
        up = {'key:up', 'button:dpup', 'axis:lefty-'},
        down = {'key:down', 'button:dpdown', 'axis:lefty+'},

        action = {'key:t', 'button:b'},
    },
    pairs = {
        move = {"left", "right", "up", "down"}
    },
    joystick = love.joystick.getJoysticks()[1],
}


-- variables
local px, py = 0, 0

-- aca empieza el codigo

function love.load()
    
end

function love.update(dt)
    player:update()

    -- local x, y = input:get 'move'
    -- playership:move(x*100, y*100)
    if player:down 'left' then
        px = px - 10
    end
    if player:down 'right' then
        px = px + 10
    end
end

function love.draw()
    love.graphics.rectangle("fill", px, py, 50, 50)

end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end