-- Note that you'll only need to fill out gear pieces in your default if one of the sets in your other sets replaces it. Otherwise it is redundant (you can set it if you want it won't hurt)

-- The name is how it will display in-game
-- The title id is optional and can be found at https://archeagecodex.com/ or you can ask around for it
-- The gear name should be the exact name displayed in-game
-- If you wish to equip something into the offhand or into a secondary ring/earring slot you can add the alternative = true value to the gear object
return {
    --[[
    {
        name = "Archery" ,
        title_id = 176,
        gear = {
            {
                name = "Hellforged Ranger's Cap"
            },  
            {
                name = "Hellforged Ranger's Jerkin"
            }, 
            {
                name = "Hellforged Ranger's Breeches"
            }, 
            {
                name = "Hellforged Ranger's Fists"
            },            
            {
                name = "Hellforged Sash"
            },
            {
                name = "Hellforged Sleeves"
            },
            {
                name = "Hellforged Ranger's Boots"
            }
        }
    },  
    --]]
    {
        name = "Battlerage" ,
        title_id = 176,
        gear = {
            {
                name = "Hellforged Warrior's Cap"
            },  
            {
                name = "Hellforged Warrior's Jerkin"
            }, 
            {
                name = "Hellforged Warrior's Breeches"
            }, 
            {
                name = "Hellforged Warrior's Fists"
            },            
            {
                name = "Hellforged Sash"
            },
            {
                name = "Hellforged Sleeves"
            },
            {
                name = "Hellforged Warrior's Boots"
            }
        }
    },
    {
        name = "Dawnsdrop",
        title_id = 191,
        gear = {
            {
                name = "Radiant Dawnsdrop Cap"
            },
			{
                name = "Radiant Dawnsdrop Jerkin"
            },
			{
                name = "Radiant Dawnsdrop Belt"
            },
			{
                name = "Radiant Dawnsdrop Guards"
            },
			{
                name = "Radiant Dawnsdrop Fists"
            },
			{
                name = "Radiant Dawnsdrop Breeches"
            },
			{
                name = "Radiant Dawnsdrop Boots"
            }
        }
    },  
    {
        name  = "Commerce",
        title_id = 618,
        gear = {
            {
                name = "Radiant Dawnsdrop Boots"
            }
        }
    },
    {
        name = "Fishing",
        title_id = 87,
        gear = {
			{
                name = "Radiant Dawnsdrop Boots"
            }
        }
    },
    {
        name = "Sleep",
		title_id = 191,
        gear = {
            {
                name = "Radiant Dawnsdrop Cap"
            },
            {
                name = "Lullaby Pajama Top",
                -- alternative = true
            },
			{
				name = "Lullaby Pajama Bottoms",
			},
			{
				name = "Lullaby Pajama Slippers",
			},
			{
				name = "Lullaby Pajama Mittens",
			}
        }
    }
}