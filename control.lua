local watts = 0.01674 -- 1 tick = 1/60 seconds
local chunk_width = 32
local chunk_height = 32

if not global.areaCache then
  global.areaCache = {}
end

--Expand the given area by one chunk in each direction (in place)
local function expandArea(area)
  area.left_top.x = area.left_top.x - chunk_width
  area.left_top.y = area.left_top.y - chunk_height
  area.right_bottom.x = area.right_bottom.x + chunk_width
  area.right_bottom.y = area.right_bottom.y + chunk_height
end

--Returns true if the given position is in the given area.
local function isInArea(pos, area)
  return pos.x >= area.left_top.x and pos.x <= area.right_bottom.x and pos.y >= area.left_top.y and pos.y <= area.right_bottom.y
end

--Returns true if the given areas overlap.
local function areasOverlap(firstArea, secondArea)
  right_top = {x = firstArea.right_bottom.x, y = firstArea.left_top.y}
  left_bottom = {x = firstArea.left_top.x, y = firstArea.right_bottom.y}
  return isInArea(firstArea.left_top, secondArea) or isInArea(right_top, secondArea) or isInArea(firstArea.right_bottom, secondArea) or isInArea(left_bottom, secondArea) 
end

----------------
--Game scripts
----------------
script.on_event(defines.events.on_chunk_generated, function(event)
  local area = event.area
  expandArea(area)
  
  --Don't generate biter spires if the current chunk area is close to other biter spires
  for _, cachedArea in pairs(global.areaCache) do
    if areasOverlap(cachedArea, area) then
      return
    end
  end
  
  local surface = event.surface
  spawnersInArea = surface.find_entities_filtered{area = area, type = "unit-spawner"}
  numSpawnersInArea = #spawnersInArea
  
  if numSpawnersInArea >= settings.global["biter-spire-minimum-base-size"].value then      
      local randomSpawnerInArea = spawnersInArea[math.random(1, numSpawnersInArea)]
      local spirePos = surface.find_non_colliding_position("biter-spire", randomSpawnerInArea.position, 16, 2)
      
      if spirePos ~= nil then
        local spire = surface.create_entity{name = "biter-spire", position = spirePos, force = "neutral"}
       
        if spire ~= nil then
            --make the spire indestructible and set power output values according to config
            spire.destructible = false
            --disable the GUI for normally generated spires (if a player somehow is able to get a biter spire (i.e. creative mode), he can adjust the energy values)
            spire.operable = false
            
            local base_power_value = settings.global["biter-spire-base-generation"].value
            local distance_scale_factor = settings.global["biter-spire-distance-scale-factor"].value
            
            local result_power_value = base_power_value
            
            if settings.global["biter-spire-scale-with-distance"].value then
              max_norm_distance_to_origin = math.max(math.abs(spire.position.x), math.abs(spire.position.y))
              result_power_value = base_power_value * (1 + distance_scale_factor * max_norm_distance_to_origin)
            end
            
            spire.electric_output_flow_limit = result_power_value * watts
            spire.electric_buffer_size = spire.electric_output_flow_limit
            spire.power_production = spire.electric_output_flow_limit
            
            --add the area we used to the session cache so we do not generate biter spires close to areas that already contain spires
            table.insert(global.areaCache, area)
        end
      end
   end
end)