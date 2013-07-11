	--main.lua - main file for MolyJam 2012 game ``A Period Piece"

require "audiosources"
require "imgsources"
require "text"
require "clickpoints"

--Game States
init = 0
runningintro = 1
printing = 2
runninground = 3
roundend = 4
gameover = 5

--constants
	--pixels
initxdisplace = 330
initydisplace = 20
charx = 14
chary = 16
clicktolerance = chary

	--chars

charlimit = 36
--other
roundlimit = 2
bosslimit = 3


--vars
successes = 0
failures = 0
victories = 0
subvictories = 0
currclickpoints = {}
currstring = ""
brokenstring = ""
currenemypic = wilbert


function love.load()
	love.graphics.setBackgroundColor(0, 0, 0)
	love.graphics.setFont( monospaced )
	curraudio = introvoices[#introvoices]
	state = init
	curraudio:play()
end


function love.mousepressed(x, y, button)

if state == runninground then

	if correctclick(x, y) then
		successes = successes + 1
	else
		failures = failures + 1
	end
end

end

function love.keypressed(key)

	if state==init and key == "." and curraudio:isStopped() then
		state = runningintro
		currenemypic = pics[victories + 1][subvictories +1]
		curraudio = introvoices[victories + 1]
		curraudio:play()
	elseif state == runningintro and key == "." and curraudio:isStopped() then
		state = printing
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

	if state == runningintro then
		currstring = "A NEW OPPONENT"


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

			if successes < failures then
				state = gameover
			else
				subvictories = (subvictories + 1) % roundlimit

				if(subvictories == 0) then
					victories = victories + 1
				end

			if victories > bosslimit then
				state = gameover
			else
				successes = 0
				failures = 0

				currenemypic = pics[victories + 1][subvictories +1]
				curraudio = introvoices[victories + 1]
				curraudio:play()
				state = runningintro
			end
			end
	elseif state == gameover then
		currstring = "GAME OVER"
	end

end

function love.draw()

	if state == init then
		love.graphics.printf(introtext, initxdisplace, initydisplace, 360, "left")
	else
	love.graphics.print("Successes: " .. successes, 0, 0)
	love.graphics.print("Failures: " .. failures, 0, 20)


	love.graphics.printf(currstring, initxdisplace, initydisplace, 360, "left")

	love.graphics.push()
	love.graphics.scale(0.5, 0.5)
	love.graphics.draw(wilbert, 0, 200)
	love.graphics.pop()

	love.graphics.push()
	love.graphics.scale(0.75, 0.75)

	love.graphics.draw(currenemypic, 1050, 0)

	love.graphics.pop()

	end

end


