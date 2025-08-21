local cube_science_packs = {
  "automation-science-pack-cubic",
  "logistic-science-pack-cubic",
  "chemical-science-pack-cubic",
  "military-science-pack-cubic",
  "production-science-pack-cubic",
  "utility-science-pack-cubic",
}

local kr_tech_cards = {
  "automation-science-pack",
  "logistic-science-pack",
  "chemical-science-pack",
  "military-science-pack",
  "production-science-pack",
  "utility-science-pack",
}

local concentrate_amounts = {
    50,
    75,
    100,
    125,
    150,
    150,
}

local iconPaths = {
  "__Krastorio2Assets__/icons/cards/automation-tech-card.png",
  "__Krastorio2Assets__/icons/cards/logistic-tech-card.png",
  "__Krastorio2Assets__/icons/cards/chemical-tech-card.png",
  "__Krastorio2Assets__/icons/cards/military-tech-card.png",
  "__Krastorio2Assets__/icons/cards/production-tech-card.png",
  "__Krastorio2Assets__/icons/cards/utility-tech-card.png",
}

-- Iterate through the cubic science packs and update their ingredients
-- by copying those from the base recipes which have already been updated by K2SO.
-- These ones only require concentrated dream so can be done all at once.
for i, cubicPack in pairs(cube_science_packs) do
  local cubeRecipe = data.raw.recipe[cubicPack]
  local baseRecipe = data.raw.recipe[kr_tech_cards[i]]

  if cubeRecipe and baseRecipe then
    local newIngredients = {}
    for _, ingredient in pairs(baseRecipe.ingredients or {}) do
      table.insert(newIngredients, ingredient)
    end

    table.insert(newIngredients, {type = "fluid", name = "dream-concentrate", amount = concentrate_amounts[i]})
    table.insert(newIngredients, {type = "item", name = "energized-microcube", amount = 1})
    cubeRecipe.ingredients = newIngredients

    -- Update the icon to include the Krastorio tech card icon in lieu of the base icon
    cubeRecipe.icons = 
      {
        {
          icon = "__cubium__/graphics/icons/matter-cube.png",
          scale = 0.9
        },
        {
          icon = iconPaths[i],
          scale = 0.6,
        }
      }
  else
    log("Warning: Could not find recipe for '" .. (cubicPack or "nil") ..
        "' or base recipe for '" .. (kr_tech_cards[i] or "nil") .. "'")
  end
end

-- the space age sciences will be done separately as they have different item requirements
--TODO: Add space age science packs here
local adv_cube_science_packs = {
  "metallurgic-science-pack-cubic",
  "electromagnetic-science-pack-cubic",
  "cryogenic-science-pack-cubic",
  "agricultural-science-pack-cubic",
  "promethium-science-pack-cubic",
}

local adv_kr_tech_cards = {
  "metallurgic-science-pack",
  "electromagnetic-science-pack",
  "cryogenic-science-pack",
  "agricultural-science-pack",
  "promethium-science-pack",
}

local concentrate_amounts = {
  200,
  200,
  200,
  0,
  200,
}

iconPaths = {
  "__Krastorio2-spaced-out__/graphics/icons/metallurgy-tech-card.png",
  "__Krastorio2-spaced-out__/graphics/icons/electromagnetic-tech-card.png",
  "__Krastorio2-spaced-out__/graphics/icons/cryogenic-tech-card.png",
  "__Krastorio2-spaced-out__/graphics/icons/agricultural-tech-card.png",
  "__Krastorio2-spaced-out__/graphics/icons/promethium-tech-card.png",
}

for i, cubicPack in pairs(adv_cube_science_packs) do
  local cubeRecipe = data.raw.recipe[cubicPack]
  local baseRecipe = data.raw.recipe[adv_kr_tech_cards[i]]

  if cubeRecipe and baseRecipe then
    local newIngredients = {}
    for _, ingredient in pairs(baseRecipe.ingredients or {}) do
      table.insert(newIngredients, ingredient)
    end

    if concentrate_amounts[i] > 0 then
      table.insert(newIngredients, {type = "fluid", name = "dream-concentrate", amount = concentrate_amounts[i]})
    end
    if i > 1 then
      table.insert(newIngredients, {type = "item", name = "energized-microcube", amount = 1})
    else
      table.insert(newIngredients, {type = "item", name = "inverted-microcube", amount = 1})
    end

    local newResults = {}
    for _, result in pairs(baseRecipe.results or {}) do
      local name = result.name
      if name:find("card") then
        table.insert(newResults, {type = "item", name = name, amount = 5})
      else
        table.insert(newResults, result)
      end
    end
    cubeRecipe.results = newResults

    cubeRecipe.localised_name = baseRecipe.localised_name

    -- Update the icon to include the Krastorio tech card icon in lieu of the base icon
    cubeRecipe.icons = 
      {
        {
          icon = "__cubium__/graphics/icons/matter-cube.png",
          scale = 0.9
        },
        {
          icon = iconPaths[i],
          scale = 0.6,
        }
      }
  else
    log("Warning: Could not find recipe for '" .. (cubicPack or "nil") ..
        "' or base recipe for '" .. (kr_tech_cards[i] or "nil") .. "'")
  end
end


-- Update the cube recipes that use iron and copper plates in their icons
local metal_recipes = {
  "cube-jelly-ore-advanced-iron",
  "cube-jelly-ore-advanced-copper",
}

local metal_icon_paths = {
  "__Krastorio2Assets__/icons/items/iron-plate.png",
  "__Krastorio2Assets__/icons/items/copper-plate.png",
}

for i, metalRecipe in pairs(metal_recipes) do
  local recipe = data.raw.recipe[metalRecipe]
  if recipe then
    recipe.icons = {
      {
        icon = "__cubium__/graphics/icons/matter-cube.png",
        scale = 0.9
      },
      {
        icon = metal_icon_paths[i],
        scale = 0.6,
      }
    }
  else
    log("Warning: Could not find recipe for '" .. (metalRecipe or "nil") .. "'")
  end
end