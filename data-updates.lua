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