game = {}
game.systemKey = "game"
game.runPriority = 17

game.currentCard = nil
game.players = {}

-- Callbacks --
function game.load()

end

function game.keypressed(key)
	if key == "b" then
		game.playCard(object.new("card"))
	end
	if key == "n" then
		game.currentCard.up = not game.currentCard.up
	end
end

function game.draw()
	if game.currentCard then
		local cw, ch = (main.width+main.height)/5, (main.width+main.height)/5*1.5
		local cx, cy = main.width/2-cw/2, main.height/2-ch/2
		ui.setColor("draw", "fg", {r=255,g=255,b=255,a=255})
		if game.currentCard.up then
			ui.draw(image.getImage("card_front_base"), cx, cy, cw, ch)
			ui.setColor("draw", "fg", card.colourTable[game.currentCard.colour])
			ui.draw(image.getImage("card_decal_base"), cx, cy, cw, ch)
			if game.currentCard.colour == "black" then ui.setColor("draw", "fg", {r=255,g=255,b=255,a=255}) end
			ui.draw(image.getImage("card_decal_"..game.currentCard.type), cx, cy, cw, ch)
			ui.setColor("draw", "fg", {r=255,g=255,b=255,a=255})
			ui.draw(image.getImage("card_decal_sides_"..game.currentCard.type), cx, cy, cw, ch)
		else
			ui.draw(image.getImage("card_back"), cx, cy, cw, ch)
		end
	end
end

-- Functions --
function game.playCard(c)
	if game.currentCard ~= nil then object.destroyObject(game.currentCard) end
	game.currentCard = c
end

function game.addPlayer(uuid)
	if uuid then
		game.players[uuid] = {cards={}}
	else
		debug.log("[ERROR] Incorrect call to function 'game.addPlayer(uuid)'")
	end
end

function game.removePlayer(uuid)
	if uuid then
		if game.players[uuid] then
			game.players[uuid] = nil
		else
			debug.log("[WARNING] No player with the uuid '"..uuid.."'")
		end
	else
		debug.log("[ERROR] Incorrect call to function 'game.addPlayer(uuid)'")
	end
end

return game