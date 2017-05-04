Scene = {}
Scene.__index = Scene

local function new(name)
	local s = {}
	setmetatable(s, Scene)

	s.trecos = {}	--Tabela de trecos na cena
	s.name = name
	s.isScene = true

	cCore.registerScene(s)
	return s
end

function Scene:addTreco(treco)
	--treco.scene = self 	--Necessário?
	self.trecos[treco.id] = treco
end

function Scene:removeTreco(treco)
	self.trecos[treco.id] = nil
end

function Scene:getTrecos(filter)
	if not filter then return self.trecos end
	local fTrecos = {}
	for i,c in ipairs(self.trecos) do
		if c:compare(filter) then
			fTrecos[#fTrecos+1] = c.id
		end
	end
	return fTrecos
end

function Scene:_enter()
	if not self.isInitialized and self.init then
		self:init()
	end
	self.isInitialized = true
	if self.enter then
		self:enter()
	end
end

function Scene:_exit()
	if self.exit then
		self:exit()
	end
end

function Scene:_update(dt)
	if self.update then
		self:update(dt)
	end
end

function Scene:_lateUpdate(dt)
	if self.lateUpdate then
		self:lateUpdate(dt)
	end
end

function Scene:_draw()
	if self.draw then
		self:draw()
	end
end

function Scene:loadMap(name)
	map = require(R.mapsFolder.."."..name)
	map.tiles = {}

	for i,ts in ipairs(map.tilesets) do
		ts.texture = R.get("tileset", ts.image)
		local curID = ts.firstgid
		ts.lastid = curID + ts.tilecount
		for j=0, (ts.imageheight/ts.tileheight)-1 do
			for i=0, (ts.imagewidth/ts.tilewidth)-1 do
				map.tiles[curID] = {}
				map.tiles[curID].quad = love.graphics.newQuad(i*ts.tilewidth, j*ts.tileheight, ts.tilewidth, ts.tileheight, ts.imagewidth, ts.imageheight)
				curID = curID + 1
			end
		end

		for k,t in pairs(ts.tiles) do
			for k,p in pairs(t.properties) do
				map.tiles[t.id+1][k] = p
			end
		end
	end

	local function getTileSet(id)
		for i,ts in ipairs(map.tilesets) do
			if (id>=ts.firstgid and id < ts.lastid) then
				return i
			end
		end
		return 0
	end

	for k,l in pairs(map.layers) do
		if (l.properties.static) then 	--Estatico, nunca muda. Poe tudo num spriteBatch em um Treco
			local layerGO = Treco(l.name)
			local batchs = {}	--Precisa de um spritebatch para cada tileset
		    local curTile = 1

		    --Pra não criar um collider por tile, detecta os tiles adjacentes pra criar um collider só

		    local colX = 0
		    local colY = 0
		    local colW = 0
		    local colCount = 0

		    for j=0,map.height-1 do
		    	for i=0,map.width-1 do
		    		local closeCollider = false
		    		if(l.data[curTile] ~= 0) then
			    		local tsID = getTileSet(l.data[curTile])
			    		if not batchs[tsID] then 	--Só cria um batch pro tileset se ele for usado
			    			batchs[tsID] = love.graphics.newSpriteBatch(map.tilesets[tsID].texture, map.width * map.height, "static")
			    		end
			    		batchs[tsID]:add(map.tiles[l.data[curTile]].quad, i*map.tilewidth, j*map.tileheight)

			    		--Trata da criação do boxCollider

			    		if(l.properties.collision) then
			    			if(map.tiles[l.data[curTile]].isSlope) then
			    				local colliderGO = Treco("col"..colCount, {Position({x = i*map.tilewidth, y = j*map.tileheight}), BoxCollider({w = map.tilewidth, h = map.tileheight})})

				    			colliderGO.collider.isSlope = true
				    			colliderGO.collider.rightY = map.tiles[l.data[curTile]].rightY
				    			colliderGO.collider.leftY = map.tiles[l.data[curTile]].leftY


				    			colCount = colCount + 1

				    			closeCollider = true
			    			else
					    		if(colW==0)then
					    			colX = i*map.tilewidth
					    			colY = j*map.tileheight
					    		end
					    		colW = colW + 1
					    	end

				    	end
			    	end


			    	--Se tiver um tile vazio ou acabou o mapa, e os tiles anteriores tinham colisão, fecha um collider
			    	nextTile = math.min(curTile+1, map.width*map.height-1)

			    	if ((l.data[curTile] == 0 or i == (map.width-1) or closeCollider) and l.properties.collision and colW>0) then
		    			colCount = colCount + 1
		    			local colliderGO = Treco("col"..colCount, {Position({x = colX, y = colY}), BoxCollider({w = colW*map.tilewidth, h = map.tileheight})})


		    			colliderGO.tileID = l.data[curTile]
		    			if(l.data[curTile] == 21)then
		    				colliderGO.isSlope = true
		    			end
		    			--layerGO:addChild(colliderGO)

		    			colW = 0

			    	end
			    	curTile = curTile + 1
		    	end
		    end

		    for i,b in ipairs(batchs) do
		    	local tsGO = Treco("tileset "..i, {Sprite({texture = b})})
		    	--layerGO:addChild(tsGO)
		    end

		    --self:addGO(layerGO:newInstance())

		end
	end
	if(map.backgroundcolor) then
		love.graphics.setBackgroundColor(map.backgroundcolor)
	end
	love.window.setMode(map.width*map.tilewidth, map.height*map.tileheight)
end

setmetatable(Scene, {__call = function(_, ...) return new(...) end})
