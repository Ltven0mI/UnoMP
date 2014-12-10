game = {}
game.systemKey = "game"
game.runPriority = 17

game.currentCard = nil
game.player = {cards={}}

game.handSize = 10
game.colour = "blue"
game.type = "0"

-- Callbacks --
function game.load()

end

function game.keypressed(key)
	if key == "v" then
		game.addCard(object.new("card"))
	end
	if key == "b" then
		game.startGame()
	end
end

function game.draw()
	if game.currentCard then
		local cw, ch = (main.width+main.height)/10, (main.width+main.height)/10*1.5
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
		end
	end
	local count = 1
	local player = game.player
	for key, card in pairs(player.cards) do
		local cc = player.cardCount
		local maxScale = (main.width/1.5)/game.handSize
		local scale = math.clamp((main.width/1.5)/cc, 10, maxScale)
		local cw, ch = scale, scale*1.5
		local handWidth = cw*cc
		local cx, cy = main.width/2-handWidth/2+cw*(count-1), main.height/1.2-ch/2
		ui.setColor("draw", "fg", {r=255,g=255,b=255,a=255})
		if card.up then
			if ui.imageButton(image.getImage("card_front_base"), cx, cy, cw, ch) then
				if game.playCard(card) then
					player.cards[key] = nil
					player.cardCount = player.cardCount - 1
				end
			end
			ui.setColor("draw", "fg", card.colourTable[card.colour])
			ui.draw(image.getImage("card_decal_base"), cx, cy, cw, ch)
			if card.colour == "black" then ui.setColor("draw", "fg", {r=255,g=255,b=255,a=255}) end
			ui.draw(image.getImage("card_decal_"..card.type), cx, cy, cw, ch)
			ui.setColor("draw", "fg", {r=255,g=255,b=255,a=255})
			ui.draw(image.getImage("card_decal_sides_"..card.type), cx, cy, cw, ch)
		end
		count = count + 1
	end
end

-- Functions --
function game.playCard(c)
	local cCard = game.currentCard
	if c.colour == "black" or (c.type == game.type) or (c.colour == game.colour) then
		if game.currentCard ~= nil then object.destroyObject(game.currentCard) end
		game.currentCard = c
		game.colour = c.colour
		game.type = c.type
		return true
	else
		return false
	end
end

function game.setCard(c)
	if game.currentCard ~= nil then object.destroyObject(game.currentCard) end
	game.currentCard = c
	game.colour = c.colour
	game.type = c.type
end

function game.addCard(card)
	game.player.cards[table.getn(game.player.cards)+1] = card
	game.player.cardCount = player.cardCount + 1
end

function game.startGame()
	local player = game.player
	game.dealHand(player)
	game.setCard(object.new("card"))
end

function game.dealHand(player)
	local player = game.player
	for i=1, game.handSize do
		player.cards[i] = object.new("card")
	end
	player.cardCount = game.handSize
end

function game.removeCards(player)
	local player = game.player
	object.destroyObject(player.cards[i])
	player.cards[i] = nil
	game.player.cardCount = 0
end

return game