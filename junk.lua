
function breakstring()
brokenstring =""

for i = 1, string.len(currstring) do
		if i % charlimit == 0 then
		brokenstring = brokenstring .. "\n"
		end

		brokenstring = brokenstring .. string.sub(currstring, i, i)

	end

end

function printchallenge()
--detect fullstops, replace and assign screen clickin' locations
	for i = 1, string.len(currstring) do

			if string.sub(currstring, i, i) == "." then
				table.insert(clickpoints, {initxdisplace + ((i-1) % charlimit) * charx, initydisplace + math.floor((i-1)/charlimit) * chary})
			end

	end

	currstring = string.lower(string.gsub(currstring, "%.", ""))
	breakstring()

end
