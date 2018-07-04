-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local M = {}

-- Don't allow the same sound to be played within "gate_time" interval.
local gate_time = 0.1

function M.init()
	-- Store played sound timers in a table and count down each frame until they have been
	-- in the table for "gate_time" seconds. Then remove them.
	M.sounds = {}
end

function M.update(dt)
	-- Count down the stored timers
	for k,_ in pairs(M.sounds) do
		M.sounds[k] = M.sounds[k] - dt
		if M.sounds[k] < 0 then
			M.sounds[k] = nil
		end
	end
end

function M.play(soundcomponent, gain)
	-- Only play sounds that are not currently in the gating table.
	if M.sounds[soundcomponent] == nil then
		-- Store sound timer in table
		M.sounds[soundcomponent] = gate_time
		-- Redirect the "play_sound" message to the real target
		msg.post(soundcomponent, "play_sound", { gain = gain })
	else
		-- An attempt to play a sound was gated
		-- print("gated " .. message.soundcomponent)
	end
end

return M
