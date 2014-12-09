card = {}

card.colours = {"blue","green","yellow","red"}
card.types = {"0","1","2","3","4","5","6","7","8","9","plus2","plus4","wild","reverse","skip"}
card.colourTable = {red={r=212,g=8,b=8,a=255},green={r=0,g=111,b=24,a=255},blue={r=22,g=41,b=123,a=255},yellow={r=243,g=217,b=39,a=255},black={r=0,g=0,b=0,a=255}}

card.colour = "blue"
card.type = "0"
card.up = true

-- Callbacks --
function card:created()
	self.type = self.types[math.random(1, table.getn(self.types))]
	self.colour = self.colours[math.random(1, table.getn(self.colours))]
	if self.type == "wild" or self.type == "plus4" then self.colour = "black" end
	debug.log(self.colour, self.type)
end

return card