--main.lua - main file for MolyJam 2012 game ``A Period Piece"

require ("audiosources.lua")
require ("imgsources.lua")
require ("text.lua")
require("clickpoints.lua")

--Game States
init = 0
runningintro = 1
printing = 2
runninground = 3
roundend = 4
gameover = 5

--constants
	--pixels
initxdisplace = 230
initydisplace = 20
charx = 14
chary = 16
clicktolerance = chary

	--chars

charlimit = 36
--other
roundlimit = 1
bosslimit = #speeches


--vars
successes = 0
failures = 0
victories = 0
subvictories = 0
currclickpoints = {}
currstring = ""

brokenstring = ""


function love.load()
	love.graphics.setBackgroundColor(0, 0, 0)
	love.graphics.setFont( monospaced )

	state = init
end


function love.mousepressed(x, y, button)

if state == runninground then

	if correctclick(x, y) then
		successes = successes + 1
	else
		failures = failures + 1
	end
	print(x .. ", " .. y)

end

end


function correctclick(x, y)
	for i = 1, #currclickpoints do
		if math.abs(currclickpoints[i][1] - x) < clicktolerance and math.abs(currclickpoints[i][2] - y) < clicktolerance then
			table.remove(currclickpoints, i)
			return true
		end
	end
	return false
end

function love.update(dt)

	if state == init then
		state = printing
	elseif state == runningintro then

	elseif state == printing then
		currclickpoints = {}
		currstring = string.lower(speeches[victories + 1][subvictories + 1])
		currclickpoints = allclickpoints[victories + 1][subvictories + 1]
		curraudio = voices[victories + 1][subvictories + 1]
		curraudio:play()
		state = runninground
	elseif state == runninground then
		if curraudio:isStopped() then
			state = roundend
		end
	elseif state == roundend then

			if successes - failures < 2 then
				state = gameover
			else
				subvictories = (subvictories + 1) % roundlimit

				if(subvictories == 0) then
					victories = victories + 1
					print("VICTORIES: " .. victories)
				end

				if( victories < 1) then
					state = runningintro
				else
					state = gameover
				end


			end
	elseif state == gameover then
		currstring = "GAME OVER"
	end

end

function love.draw()


	love.graphics.print("Successes: " .. successes, 0, 0)
	love.graphics.print("Failures: " .. failures, 600, 0)


--	love.graphics.printf(currstring, initxdisplace, initydisplace, 360, "left")

	love.graphics.push()
	love.graphics.scale(0.5, 0.5)
	love.graphics.draw(wilbert, 0, 200)
	love.graphics.pop()

	--	love.graphics.setColor(0, 255, 0, 128)
--	for i = 1, #currclickpoints do
		--print("X: " .. currclickpoints[i][1] .. " Y: " .. currclickpoints[i][2])
		--love.graphics.rectangle("fill", currclickpoints[i][1] - charx/2, currclickpoints[i][2] - chary/2, charx, chary)

	--end
	--love.graphics.setColor(255, 255, 255, 255)

end


