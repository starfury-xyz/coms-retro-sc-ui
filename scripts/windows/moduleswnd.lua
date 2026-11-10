-- ----------------------------------------------------------------------------
--
-- Workfile: moduleswnd.lua
-- Copyright й 2006, Targem LLC. All rights reserved.
--
-- ----------------------------------------------------------------------------
--  $Id:  $
-- ----------------------------------------------------------------------------

UI.ModulesWnd = {}
local mw = UI.ModulesWnd

-- ------------------------------
-- window definition
-- ------------------------------

UI.ModulesWnd.def =
{
	className	= "Wnd",

	props =
	{
		name		= "ModulesWnd",
		style		= UI.WS_NOT_MOUSE_REACT + UI.WS_NOT_KB_REACT + UI.WS_UPDATE_IF_VISIBLE,		
		isPrototype	= true,
	},

	layers =
	{
		-- MAIN_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,
			main		= true,

			effects =
			{{
				defName 			= "modules_main",
				defaultAnimation	= "idle",

				links =
				{
					{
						objName		= "self",
						animParams	= UI.EffectAnimParams.SIZE,
					},
				}		
			}}
		},   
	}
}

-- ------------------------------
-- const
-- ------------------------------

mw.layers =
{
    MAIN_EFFECT			= 0,
}

mw.MAX_SLOTS = 6	-- НЕ включая специальный слот

mw.effectInfo =
{
	main =
	{
		slotLocators_WEAPON =
		{
			locator	= "slot_1"
		},

		slotLocators_ROCKETS =
		{
			locator = "missle_1"
		},

		slotLocators_MODULE =
		{
			locatorPrefix = "modul_"
		},

		slotLocators_SPECIAL =
		{
			locator	= "modules_special"
		},
	}
}

-- ------------------------------
-- vars
-- ------------------------------

mw.slots	= {}
mw.specSlot	= nil

-- ------------------------------
-- work functions
-- ------------------------------

--
function UI.ModulesWnd:F_PostLoad()

	UI.Wnd.F_PostLoad( self )

	if self:IsPrototype() then
		return
	end

	self.slots = {}

	self:CreateSlots()
	self:Reset()

end


--
function UI.ModulesWnd:CreateSlots()

	for slotIdx = 1, self.MAX_SLOTS do	
		local slotWnd = UI:CreateChildWnd( self, UI.Modules_SlotWnd, tostring( slotIdx ) )
		table.insert( self.slots, slotWnd )
	end
	
	self.specSlot = UI:CreateChildWnd( self, UI.Modules_SpecialSlotWnd, "" )

end



--
function UI.ModulesWnd:Reset()

	self:HideAllSlots()

end


--
function UI.ModulesWnd:ShowSlot( slotWnd, locator )

	if locator then
		local mainEffect = UI:GetEffectFromLayer( self, self.layers.MAIN_EFFECT )
		UI:AddChildAndLink( self, slotWnd, mainEffect, locator, UI.EffectAnimParams.POS )
	else
		self:AddChild( slotWnd )
	end

end


--
function UI.ModulesWnd:HideSlot( slotWnd )

	slotWnd:Reset()
	slotWnd:UnlinkFromParent()

	local mainEffect = UI:GetEffectFromLayer( self, self.layers.MAIN_EFFECT )
	if mainEffect then
		mainEffect:UnlinkWnd( slotWnd:GetUiHandle(), "" )
	end

end


--
function UI.ModulesWnd:HideAllSlots()

	for slotIdx, slotWnd in pairs( self.slots ) do		
		self:HideSlot( slotWnd )
	end

	self:HideSlot( self.specSlot )

end


--
function UI.ModulesWnd:GetFreeSlot()

	for slotIdx, slotWnd in pairs( self.slots ) do
		if not slotWnd:IsChildOf( self ) then
			return slotWnd
		end
	end

	return nil

end


-- for override
function UI.ModulesWnd:FullUpdate()
end


-- ----------------------------------------------------------------------
-- UI.Modules_SlotWnd
-- ----------------------------------------------------------------------

UI.Modules_SlotWnd = {}
local ms = UI.Modules_SlotWnd

-- ------------------------------
-- window definition
-- ------------------------------

UI.Modules_SlotWnd.def =
{
	className	= "Wnd",

	props =
	{
		name		= "Modules_SlotWnd",
		style		= UI.WS_NOT_KB_REACT + UI.WS_UPDATE_IF_VISIBLE,		
		isPrototype	= true,
	},

	layers =
	{
		-- MAIN_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,
			main		= true,

			effects =
			{{
				defName 			= "modules_slot",
				defaultAnimation	= "idle",

				links =
				{
					{
						objName		= "self",
						animParams	= UI.EffectAnimParams.SIZE,
					},

					{
						objName		= "buff_icon",
						layer		= "UI.Modules_SlotWnd.layers.ICO_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "key",
						layer		= "UI.Modules_SlotWnd.layers.KEY_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "namber_ship",
						layer		= "UI.Modules_SlotWnd.layers.TARGETS_COUNT_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					}, 

					{
						objName		= "module_inactive",
						layer		= "UI.Modules_SlotWnd.layers.ICO_INACTIVE_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "modules_icon",
						layer		= "UI.Modules_SlotWnd.layers.ICO_BG_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "marker_1",	
						layer		= "UI.Modules_SlotWnd.layers.COLOR_BG_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "marker_2",	
						layer		= "UI.Modules_SlotWnd.layers.COLOR_ENCHANTMENT_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "modules_icon",	
						layer		= "UI.Modules_SlotWnd.layers.SEL_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "icon_gold",	
						layer		= "UI.Modules_SlotWnd.layers.ENCHANTMENT_FRAME_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "destroy",	
						layer		= "UI.Modules_SlotWnd.layers.DESTROYED_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "cooldown",
						layer		= "UI.Modules_SlotWnd.layers.WORK_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},
					
					{
						objName		= "frame",
						layer		= "UI.Modules_SlotWnd.layers.COLOR2_FRAME_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "star",
						layer		= "UI.Modules_SlotWnd.layers.ENCHANTMENT2_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},
					
					{
						objName		= "bg_2",
						layer		= "UI.Modules_SlotWnd.layers.INFLUENCE_COLOR_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},
				}
			}}
		},

		-- ICO_BG_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "modules_slot_icoBg",
				defaultAnimation	= "active",
			}}
		}, 
		
		-- INFLUENCE_COLOR_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,
			
			effects =
			{{
				defName 			= "itemIco_influenceColor",
				defaultAnimation	= "active",
			}}
		},

		-- COLOR_BG_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "itemIco_colorBg",
				defaultAnimation	= "idle",
			}}
		},   

		-- COLOR_ENCHANTMENT_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "itemIco_colorEnchantment",
				defaultAnimation	= "idle",
			}}
		},   

		-- SEL_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "modules_slot_sel",
				defaultAnimation	= "activity_on",
			}}
		}, 

		-- ICO_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "spellIco",
				defaultAnimation	= "color",
			}}
		}, 

		-- ENCHANTMENT_FRAME_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "itemIco_enchantmentFrame",
				defaultAnimation	= "active",
			}}
		},	
		
		-- COLOR2_FRAME_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "itemIco_color2Frame",
				defaultAnimation	= "active",
			}}
		},
		
		-- ENCHANTMENT2_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "itemIco_enchantment2",
				defaultAnimation	= "active",
			}}
		},
		
		-- ICO_INACTIVE_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "modules_slot_icoInactive",
				defaultAnimation	= "idle",
			}}
		},

		-- COOLDOWN_TIME
		{
			layerType		= UI.LAYER_TEXT,
   			formatFlags	 	= FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz	= { 1, 1 },
   			font			= { fontName = "Small" },			
		},

		-- KEY_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "modules_slot_key",
				defaultAnimation	= "idle",

				links =
				{
					{
						objName		= "number",
						layer		= "UI.Modules_SlotWnd.layers.KEY",
						animParams	= UI.EffectAnimParams.ALL,
					},
				}
			}}
		}, 

		-- KEY
		{
			layerType		= UI.LAYER_TEXT,
   			formatFlags	 	= FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz	= { 1, 1 },
   			font			= { fontName = "Small" },			
		},

		-- TARGETS_COUNT_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "modules_slot_targetsCount",
				defaultAnimation	= "idle",

				links =
				{
					{
						objName		= "number",
						layer		= "UI.Modules_SlotWnd.layers.TARGETS_COUNT",
						animParams	= UI.EffectAnimParams.ALL,
					},
				}
			}}
		},

		-- TARGETS_COUNT
		{
			layerType		= UI.LAYER_TEXT,
   			formatFlags	 	= FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz	= { 1, 1 },
   			font			= { fontName = "Small" },			
		},

		-- DESTROYED_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "modules_slot_destroyed",
				defaultAnimation	= "idle",
			}}
		},

		-- невидимый, в логике не используется, нужен чисто для организации локаторов в эффекте
		-- WORK_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "modules_slot_work",
				defaultAnimation	= "idle",

				links =
				{
    				{
    					objName		= "cooldown_text",	
    					layer		= "UI.Modules_SlotWnd.layers.COOLDOWN_TIME",
    					animParams	= UI.EffectAnimParams.ALL,
    				},

    				{
    					objName		= "reload",	
    					layer		= "UI.Modules_SlotWnd.layers.AMMO_EFFECT",
    					animParams	= UI.EffectAnimParams.POS,
    				},

    				{
    					objName		= "flash",	
    					layer		= "UI.Modules_SlotWnd.layers.FLASH_EFFECT",
    					animParams	= UI.EffectAnimParams.POS,
    				},
				}
			}}
		},

		-- FLASH_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "modules_slot_flash",
				defaultAnimation	= "idle",
			}}
		},

		-- AMMO_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "modules_slot_ammo",
				defaultAnimation	= "idle",

				links =
				{
					{
						objName		= "text",
						layer		= "UI.Modules_SlotWnd.layers.AMMO_COUNT",
						animParams	= UI.EffectAnimParams.ALL,
					},

					{
						objName		= "progr",
						layer		= "UI.Modules_SlotWnd.layers.AMMO_RELOAD_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},
				}
			}}
		},

		-- AMMO_COUNT
		{
			layerType		= UI.LAYER_TEXT,
   			formatFlags	 	= FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz	= { 1, 1 },
   			font			= { fontName = "Small" },			
		},

		-- AMMO_RELOAD_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,
			updatable	= false,

			effects =
			{{
				defName 			= "modules_slot_ammoReload",
				defaultAnimation	= "idle",
			}}
		},

		-- COOLDOWN_CLOCK  [MOD cooldown-clock]
		-- Vertex-stream layer used to draw the two white clock lines.
		-- Appended last so it draws on top of the icon and keeps all
		-- original layer ids unchanged.
		{
			layerType	= UI.LAYER_VERTEX_STREAM,
			layerStyle	= UI.WLS_RESIZABLE,
		},
	}
}

-- ------------------------------
-- interface functions
-- ------------------------------

--
function UI.Modules_SlotWnd:Reset()

	self:SetLayerVisible( false, self.layers.ICO_BG_EFFECT )
	self:SetLayerVisible( false, self.layers.ICO_EFFECT )
	self:SetLayerVisible( false, self.layers.ICO_INACTIVE_EFFECT )
	self:SetLayerVisible( false, self.layers.KEY_EFFECT )
	self:SetLayerVisible( false, self.layers.KEY )
	self:SetLayerVisible( false, self.layers.AMMO_EFFECT )
	self:SetLayerVisible( false, self.layers.AMMO_COUNT )
	self:SetLayerVisible( false, self.layers.AMMO_RELOAD_EFFECT )
	self:SetLayerVisible( false, self.layers.TARGETS_COUNT_EFFECT )
	self:SetLayerVisible( false, self.layers.TARGETS_COUNT )
	self:SetLayerVisible( false, self.layers.COOLDOWN_TIME )
	self:SetLayerVisible( false, self.layers.COLOR_BG_EFFECT )
	self:SetLayerVisible( false, self.layers.COLOR_ENCHANTMENT_EFFECT )
	self:SetLayerVisible( false, self.layers.SEL_EFFECT )
	self:SetLayerVisible( false, self.layers.ENCHANTMENT_FRAME_EFFECT )
	self:SetLayerVisible( false, self.layers.DESTROYED_EFFECT )
	self:SetLayerVisible( false, self.layers.FLASH_EFFECT )
	self:SetLayerVisible( false, self.layers.COLOR2_FRAME_EFFECT )
	self:SetLayerVisible( false, self.layers.ENCHANTMENT2_EFFECT )
	self.icoInactiveWanted = false	-- [MOD cooldown-clock]
	self.readyFlashStart = nil
	self:HideCooldownClock()

	self:SetLayerVisible( false, self.layers.INFLUENCE_COLOR_EFFECT )

	if self.icoBgEffect then
		self.icoBgEffect:StartAnimationById( self.animIdIcoBgActive )
	end

	if self.keyEffect then
		self.keyEffect:StartAnimationById( self.animIdKeyActive )
	end

	self.ammoCount		= -1
	self.targetsCount	= -1
	self.cooldownTime	= -1
	self.isInited		= false
	self.data			= nil

	self.tooltipData	= nil

end


--
function UI.Modules_SlotWnd:SetEmpty()

	self:Reset()

	self:SetLayerVisible( true, self.layers.ICO_BG_EFFECT )	

	if self.icoBgEffect then
		self.icoBgEffect:StartAnimationById( self.animIdIcoBgEmpty )
	end

end


--
function UI.Modules_SlotWnd:ShowIco( defName, phase )

	self:SetLayerVisible( true, self.layers.ICO_BG_EFFECT )
	self:SetLayerVisible( true, self.layers.ICO_EFFECT )

	UI:UpdateItemIco( defName, self, self.layers.ICO_EFFECT, false, phase )

end   


--
function UI.Modules_SlotWnd:ShowIcoDirect( hTex )

	self:SetLayerVisible( true, self.layers.ICO_BG_EFFECT )
	self:SetLayerVisible( true, self.layers.ICO_EFFECT )

	UI:SetItemIcoDirect( hTex, self, self.layers.ICO_EFFECT )

end   


--
function UI.Modules_SlotWnd:HideIco()

	self:SetLayerVisible( false, self.layers.ICO_BG_EFFECT )
	self:SetLayerVisible( false, self.layers.ICO_EFFECT )
	self:SetLayerVisible( false, self.layers.ICO_INACTIVE_EFFECT )
	self:SetLayerVisible( false, self.layers.SEL_EFFECT )

end


--
function UI.Modules_SlotWnd:ShowColorBg( color, bEnchantment )

	if bEnchantment == nil then
		bEnchantment = false
	end

	self:SetLayerVisible( true, self.layers.COLOR_BG_EFFECT )
	self:SetLayerVisible( bEnchantment, self.layers.COLOR_ENCHANTMENT_EFFECT )	

	if self.colorBgEffect then

		local bgColor = color
		if bEnchantment then
			bgColor = UI:GetPremiumItemColor( false )
		end

		self.colorBgEffect:SetColor( bgColor )

	end

	if self.colorEnchantmentEffect then
		self.colorEnchantmentEffect:SetColor( color )
	end

	self:SetLayerVisible( bEnchantment, self.layers.ENCHANTMENT_FRAME_EFFECT )

end


--
function UI.Modules_SlotWnd:HideColorBg()

	self:SetLayerVisible( false, self.layers.COLOR_BG_EFFECT )
	self:SetLayerVisible( false, self.layers.COLOR_ENCHANTMENT_EFFECT )
	self:SetLayerVisible( false, self.layers.ENCHANTMENT_FRAME_EFFECT )

end


--
function UI.Modules_SlotWnd:ShowColorBg2( color, bEnchantment )

	if bEnchantment == nil then
		bEnchantment = false
	end

	self:SetLayerVisible( true, self.layers.COLOR2_FRAME_EFFECT )

	local frameEffect = UI:GetEffectFromLayer( self, self.layers.COLOR2_FRAME_EFFECT )
	if frameEffect then
		frameEffect:SetColor( color )
	end

	self:SetLayerVisible( bEnchantment, self.layers.ENCHANTMENT2_EFFECT )

end


--
function UI.Modules_SlotWnd:HideColorBg2()

	self:SetLayerVisible( false, self.layers.COLOR2_FRAME_EFFECT )
	self:SetLayerVisible( false, self.layers.ENCHANTMENT2_EFFECT )

end


--
function UI.Modules_SlotWnd:AnimateIcoActive()

	self.icoInactiveWanted = false	-- [MOD cooldown-clock]
	self:SetLayerVisible( false, self.layers.ICO_INACTIVE_EFFECT )
	self:SetLayerVisible( false, self.layers.SEL_EFFECT )

	if self.icoBgEffect and self.icoBgEffect:GetCurAnimationId() ~= self.animIdIcoBgActive then
		self.icoBgEffect:StartAnimationById( self.animIdIcoBgActive )
	end

end


--
function UI.Modules_SlotWnd:AnimateIcoSuperActive()

	self.icoInactiveWanted = false	-- [MOD cooldown-clock]
	self:SetLayerVisible( false, self.layers.ICO_INACTIVE_EFFECT )
	self:SetLayerVisible( true, self.layers.SEL_EFFECT )

	if self.icoBgEffect and self.icoBgEffect:GetCurAnimationId() ~= self.animIdIcoBgActive then
		self.icoBgEffect:StartAnimationById( self.animIdIcoBgActive )
	end

end


--
function UI.Modules_SlotWnd:AnimateIcoInactive()

	self.icoInactiveWanted = true	-- [MOD cooldown-clock]
	self:SetLayerVisible( self.cooldownClockKey == nil, self.layers.ICO_INACTIVE_EFFECT )
	self:SetLayerVisible( false, self.layers.SEL_EFFECT )

	if self.icoBgEffect and self.icoBgEffect:GetCurAnimationId() ~= self.animIdIcoBgActive then
		self.icoBgEffect:StartAnimationById( self.animIdIcoBgActive )
	end

end


--
function UI.Modules_SlotWnd:IsIcoInactive()

	return self.icoInactiveWanted or self:IsLayerVisible( self.layers.ICO_INACTIVE_EFFECT )	-- [MOD cooldown-clock]

end


--
function UI.Modules_SlotWnd:SetKey( strKey )

	self:SetText( strKey, self.layers.KEY )

end


--
function UI.Modules_SlotWnd:ShowKey()

	self:SetLayerVisible( true, self.layers.KEY_EFFECT )
	self:SetLayerVisible( true, self.layers.KEY )

end


--
function UI.Modules_SlotWnd:HideKey()

	self:SetLayerVisible( false, self.layers.KEY_EFFECT )
	self:SetLayerVisible( false, self.layers.KEY )

end


--
function UI.Modules_SlotWnd:AnimateKeyInactive()

	if self.keyEffect and self.keyEffect:GetCurAnimationId() ~= self.animIdKeyInactive then
		self.keyEffect:StartAnimationById( self.animIdKeyInactive )
	end

end


--
function UI.Modules_SlotWnd:AnimateKeyActive()

	if self.keyEffect and self.keyEffect:GetCurAnimationId() ~= self.animIdKeyActive then
		self.keyEffect:StartAnimationById( self.animIdKeyActive )
	end

end 


--
function UI.Modules_SlotWnd:ShowAmmoCount( ammoCount )

	if ammoCount ~= self.ammoCount then
		self:SetLayerVisible( true, self.layers.AMMO_EFFECT )
		self:SetLayerVisible( true, self.layers.AMMO_COUNT )
		self:SetText( tostring( ammoCount ), self.layers.AMMO_COUNT )
		self.ammoCount = ammoCount
	end

end


--
function UI.Modules_SlotWnd:HideAmmoCount()

	if not self:IsLayerVisible( self.layers.AMMO_RELOAD_EFFECT ) then
		self:SetLayerVisible( false, self.layers.AMMO_EFFECT )
	end
	self:SetLayerVisible( false, self.layers.AMMO_COUNT )
	self.ammoCount = -1

end


--
function UI.Modules_SlotWnd:GetAmmoCount()

	return self.ammoCount

end


--
function UI.Modules_SlotWnd:ShowAmmoReload( val )

	self:SetLayerVisible( true, self.layers.AMMO_EFFECT )
	self:SetLayerVisible( true, self.layers.AMMO_RELOAD_EFFECT )

	if self.ammoReloadEffect then
		self.ammoReloadEffect:SetAnimationTimeAndUpdate( 1 - val )
	end

end


--
function UI.Modules_SlotWnd:HideAmmoReload()

	if not self:IsLayerVisible( self.layers.AMMO_COUNT ) then
		self:SetLayerVisible( false, self.layers.AMMO_EFFECT )
	end
	self:SetLayerVisible( false, self.layers.AMMO_RELOAD_EFFECT )

end


--
function UI.Modules_SlotWnd:ShowTargetsCount( targetsCount )

	if targetsCount ~= self.targetsCount then
		self:SetLayerVisible( true, self.layers.TARGETS_COUNT_EFFECT )
		self:SetLayerVisible( true, self.layers.TARGETS_COUNT )
		self:SetText( string.format( "%d %s", targetsCount, self.strTargetsCountUnits ), self.layers.TARGETS_COUNT )
		self.targetsCount = targetsCount
	end

end


--
function UI.Modules_SlotWnd:HideTargetsCount()

	self:SetLayerVisible( false, self.layers.TARGETS_COUNT_EFFECT )
	self:SetLayerVisible( false, self.layers.TARGETS_COUNT )
	self.targetsCount = -1

end


--
function UI.Modules_SlotWnd:ShowCooldownTime( cooldownTime )

	local clockCfg = UI.Modules_SlotWnd.COOLDOWN_CLOCK	-- [MOD cooldown-clock]
	if self.useCooldownClock and clockCfg.enabled and clockCfg.hideNumber then
		return
	end

	if cooldownTime ~= self.cooldownTime then
		self:SetLayerVisible( true, self.layers.COOLDOWN_TIME )
		self:SetText( tostring( cooldownTime ), self.layers.COOLDOWN_TIME )
		self.cooldownTime = cooldownTime
	end

end


--
function UI.Modules_SlotWnd:HideCooldownTime()

	self:SetLayerVisible( false, self.layers.COOLDOWN_TIME )
	self.cooldownTime = -1

end


--
function UI.Modules_SlotWnd:GetCooldownTime()

	return self.cooldownTime

end


--
function UI.Modules_SlotWnd:SetInited( isInited )

	self.isInited = isInited

end


--
function UI.Modules_SlotWnd:IsInited()

	return self.isInited

end


--
function UI.Modules_SlotWnd:GetTooltipData()

	return self.tooltipData

end


--
function UI.Modules_SlotWnd:SetTooltipData( tooltipData )

	if tooltipData ~= nil and type( tooltipData ) ~= "table" then
		sys.log( "UI.Modules_SlotWnd:SetTooltipData()[ERROR]: invalid type of the 1-st parameter(\"tooltipData\"); \"table\" or nil expected, got \"%s\"", type( tooltipData ) )
		return
	end

	self.tooltipData = nil

	if tooltipData then
		self.tooltipData = UI:CopyTable2( tooltipData )
	end

end


--
function UI.Modules_SlotWnd:ShowDestroyed()

	self:SetLayerVisible( true, self.layers.DESTROYED_EFFECT )

end


--
function UI.Modules_SlotWnd:HideDestroyed()

	self:SetLayerVisible( false, self.layers.DESTROYED_EFFECT )

end


--
function UI.Modules_SlotWnd:ShowFlash()

	local clockCfg = UI.Modules_SlotWnd.COOLDOWN_CLOCK	-- [MOD cooldown-clock]
	if self.useCooldownClock and clockCfg.enabled and clockCfg.replaceFlash then
		return
	end

	self:SetLayerVisible( true, self.layers.FLASH_EFFECT )

	if self.flashEffect	then
		self.flashEffect:RestartAnimation()
	end

end


--
function UI.Modules_SlotWnd:HideFlash()

	self:SetLayerVisible( false, self.layers.FLASH_EFFECT )

end


--
function UI.Modules_SlotWnd:ShowInfluenceColor( color )

	if color == nil then	-- функция GetItemInfluenceColor() может возвращать nil, если нет цвета
	
		self:HideInfluenceColor()
		
	else

		self:SetLayerVisible( true, self.layers.INFLUENCE_COLOR_EFFECT )
		
		local influenceEffect = UI:GetEffectFromLayer( self, self.layers.INFLUENCE_COLOR_EFFECT )
		if influenceEffect then
			influenceEffect:SetColor( color )
		end
		
	end

end


--
function UI.Modules_SlotWnd:HideInfluenceColor()

	self:SetLayerVisible( false, self.layers.INFLUENCE_COLOR_EFFECT )

end


--
function UI.Modules_SlotWnd:SetData( data )

	self.data = data

end


--
function UI.Modules_SlotWnd:GetData()

	return self.data

end


-- ------------------------------
-- const
-- ------------------------------

ms.layers =
{
    MAIN_EFFECT					= 0,
	ICO_BG_EFFECT				= 1,
	INFLUENCE_COLOR_EFFECT		= 2, 
	COLOR_BG_EFFECT			    = 3, 
	COLOR_ENCHANTMENT_EFFECT	= 4, 
	SEL_EFFECT					= 5, 
    ICO_EFFECT					= 6,
	ENCHANTMENT_FRAME_EFFECT	= 7, 
	COLOR2_FRAME_EFFECT			= 8,
	ENCHANTMENT2_EFFECT			= 9,
	ICO_INACTIVE_EFFECT			= 10,
	COOLDOWN_TIME				= 11,
    KEY_EFFECT					= 12,
    KEY							= 13,
	TARGETS_COUNT_EFFECT		= 14,
	TARGETS_COUNT				= 15,
	DESTROYED_EFFECT			= 16,
	WORK_EFFECT					= 17,
	FLASH_EFFECT				= 18,
	AMMO_EFFECT					= 19,
    AMMO_COUNT					= 20,
	AMMO_RELOAD_EFFECT			= 21,
	COOLDOWN_CLOCK				= 22,	-- [MOD cooldown-clock]
}

ms.effectInfo =
{
	icoBg =
	{
		animActive		= "active",
		animEmpty		= "empty",
	},

	key =
	{
		animInactive		= "idle",
		animActive			= "select",
	},
}

ms.strTargetsCountUnits = UI:GetStringByName( "hud_modules_targetsCountUnits" )

-- ------------------------------
-- vars
-- ------------------------------

ms.animIdIcoBgActive		= -1
ms.animIdIcoBgEmpty			= -1
ms.animIdKeyInactive		= -1
ms.animIdKeyActive			= -1
ms.ammoCount 				= -1
ms.targetsCount				= -1
ms.cooldownTime				= -1
ms.isInited					= false
ms.tooltipData				= nil
ms.mainEffect				= nil
ms.icoBgEffect				= nil
ms.colorBgEffect			= nil
ms.colorEnchantmentEffect	= nil
ms.icoEffect				= nil
ms.enchantmentFrameEffect	= nil
ms.icoInactiveEffect		= nil
ms.ammoReloadEffect			= nil
ms.keyEffect				= nil
ms.ammoCountEffect			= nil
ms.targetsCountEffect		= nil
ms.flashEffect				= nil
ms.data						= nil

-- ------------------------------
-- work functions
-- ------------------------------

--
function UI.Modules_SlotWnd:F_PostLoad()

	UI.Wnd.F_PostLoad( self )

	if self:IsPrototype() then
		return
	end

	self.mainEffect				= UI:GetEffectFromLayer( self, self.layers.MAIN_EFFECT )
	self.icoBgEffect			= UI:GetEffectFromLayer( self, self.layers.ICO_BG_EFFECT )
	self.colorBgEffect			= UI:GetEffectFromLayer( self, self.layers.COLOR_BG_EFFECT )
	self.colorEnchantmentEffect	= UI:GetEffectFromLayer( self, self.layers.COLOR_ENCHANTMENT_EFFECT )
	self.icoEffect				= UI:GetEffectFromLayer( self, self.layers.ICO_EFFECT )
	self.enchantmentFrameEffect	= UI:GetEffectFromLayer( self, self.layers.ENCHANTMENT_FRAME_EFFECT )
	self.icoInactiveEffect		= UI:GetEffectFromLayer( self, self.layers.ICO_INACTIVE_EFFECT )
	self.ammoReloadEffect		= UI:GetEffectFromLayer( self, self.layers.AMMO_RELOAD_EFFECT )
	self.keyEffect				= UI:GetEffectFromLayer( self, self.layers.KEY_EFFECT )
	self.ammoCountEffect		= UI:GetEffectFromLayer( self, self.layers.AMMO_EFFECT )
	self.targetsCountEffect		= UI:GetEffectFromLayer( self, self.layers.TARGETS_COUNT_EFFECT )
	self.flashEffect			= UI:GetEffectFromLayer( self, self.layers.FLASH_EFFECT )

	if self.icoBgEffect then
        self.animIdIcoBgActive		= self.icoBgEffect:GetAnimationId( self.effectInfo.icoBg.animActive )
		self.animIdIcoBgEmpty		= self.icoBgEffect:GetAnimationId( self.effectInfo.icoBg.animEmpty )
	end

	if self.keyEffect then
        self.animIdKeyInactive		= self.keyEffect:GetAnimationId( self.effectInfo.key.animInactive )
        self.animIdKeyActive		= self.keyEffect:GetAnimationId( self.effectInfo.key.animActive )
	end

	self:Reset()

end


--
function UI.Modules_SlotWnd:F_OnEffectAnimationEnded( effect, animName )

	if effect == self.flashEffect then
		self:SetLayerVisible( false, self.layers.FLASH_EFFECT )
	end

end



-- ----------------------------------------------------------------------
-- [MOD cooldown-clock] Clock-style cooldown overlay

-- Sizes are fractions of the icon square's width.
UI.Modules_SlotWnd.COOLDOWN_CLOCK =
{
	enabled			= true,
	hideNumber		= true,			-- hide the numeric countdown on clock slots
	replaceFlash	= true,			-- use the white ready flash instead of the stock one

	-- lines
	color			= 0xFFFFFFFF,
	outlineColor	= 0xBB000000,
	softColor		= 0x55FFFFFF,	-- faint fringe that softens jagged edges
	lineWidth		= 0.045,
	outlineWidth	= 0.025,
	softWidth		= 0.012,
	lineLength		= 1.0,			-- lines are cut off flush at this box (1 = the square's edge)
	hubRadius		= 0.030,		-- round joint at the center

	-- shading
	shadeColor		= 0x99000000,	-- part still cooling down
	revealedColor	= 0x2A000000,	-- part already swept

	-- ready flash
	flashColor		= 0xFFFFFF,		-- RGB, alpha is animated
	flashAlpha		= 240,			-- starting alpha, 0..255
	flashDuration	= 0.65,			-- seconds

	steps			= 360,			-- redraw resolution (1 step = 1 degree)
	debugSquare		= false,		-- outline the computed icon square in red
}

UI.Modules_SlotWnd.COOLDOWN_CLOCK_LAYOUTS =
{
	normal	= { top = 14 / 64, side = 50 / 50, height = 50 / 64 },
	special	= { top = 15 / 80, side = 64 / 64, height = 64 / 80 },
}

ms.cooldownClockLayout	= nil	-- per instance; nil = normal
ms.cooldownClockKey		= nil	-- what is drawn now; nil = clock hidden
ms.useCooldownClock		= false	-- set by the HUD on slots that use the clock
ms.icoInactiveWanted	= false	-- the HUD asked for the dark "inactive" overlay
ms.readyFlashStart		= nil

local TWO_PI	= 2 * math.pi
local CORNERS	= { math.pi * 0.25, math.pi * 0.75, math.pi * 1.25, math.pi * 1.75 }

-- Geometry is built in "box" coords: the icon square is [-1,1] x [-1,1],
-- y down. Map() converts to window coords, scaling x and y separately
-- because UI units differ horizontally and vertically.
local function Map( b, u, v )
	return UI:Vec2( b.cx + u * b.hx, b.cy + v * b.hy )
end

local function Alpha( color )
	return math.floor( color / 0x1000000 )
end

-- Point on the square's edge at clock angle a (0 = 12 o'clock, clockwise).
local function EdgePoint( a )
	local s, c = math.sin( a ), -math.cos( a )
	local t = 1 / math.max( math.abs( s ), math.abs( c ) )
	return s * t, c * t
end

local function PushTri( vs, b, p1, p2, p3, color )
	vs:PushQuad( p1, p2, p3, p3, b.tc, b.tc, b.tc, b.tc, color )
end

-- Line from (u0,v0) to (u1,v1); 'ext' lengthens the far end.
-- Clips a convex polygon { u1,v1, u2,v2, ... } to the box |u|,|v| <= lim.
local function ClipToBox( pts, lim )
	for edge = 1, 4 do
		local axis = edge <= 2 and 1 or 2		-- 1 = u, 2 = v
		local sign = edge % 2 == 1 and 1 or -1	-- which side of the box
		local out = {}
		local n = #pts / 2
		for i = 1, n do
			local j = i % n + 1
			local au, av = pts[ 2 * i - 1 ], pts[ 2 * i ]
			local bu, bv = pts[ 2 * j - 1 ], pts[ 2 * j ]
			local da = lim - sign * ( axis == 1 and au or av )	-- >= 0 is inside
			local db = lim - sign * ( axis == 1 and bu or bv )
			if da >= 0 then
				out[ #out + 1 ] = au
				out[ #out + 1 ] = av
			end
			if ( da >= 0 ) ~= ( db >= 0 ) then
				local t = da / ( da - db )
				out[ #out + 1 ] = au + ( bu - au ) * t
				out[ #out + 1 ] = av + ( bv - av ) * t
			end
		end
		pts = out
		if #pts == 0 then
			break
		end
	end
	return pts
end

-- Line from (u0,v0) to (u1,v1); 'ext' lengthens the far end.
-- If 'clip' is given, the line is cut off flush at the box |u|,|v| <= clip.
local function PushLine( vs, b, u0, v0, u1, v1, width, ext, color, clip )
	if Alpha( color ) == 0 then
		return
	end
	local du, dv = u1 - u0, v1 - v0
	local len = math.sqrt( du * du + dv * dv )
	if len <= 0 then
		return
	end
	du, dv = du / len, dv / len
	u1, v1 = u1 + du * ext, v1 + dv * ext
	local nu, nv = -dv * width * 0.5, du * width * 0.5

	local pts = { u0 + nu, v0 + nv, u1 + nu, v1 + nv, u1 - nu, v1 - nv, u0 - nu, v0 - nv }
	if clip then
		pts = ClipToBox( pts, clip )
	end

	-- convex polygon -> triangle fan
	local n = #pts / 2
	if n < 3 then
		return
	end
	local p1 = Map( b, pts[ 1 ], pts[ 2 ] )
	for i = 2, n - 1 do
		PushTri( vs, b, p1, Map( b, pts[ 2 * i - 1 ], pts[ 2 * i ] ), Map( b, pts[ 2 * i + 1 ], pts[ 2 * i + 2 ] ), color )
	end
end

local function PushDisc( vs, b, r, color )
	if Alpha( color ) == 0 or r <= 0 then
		return
	end
	local SEG = 16
	local center = Map( b, 0, 0 )
	local prev = Map( b, 0, -r )
	for i = 1, SEG do
		local a = i / SEG * TWO_PI
		local p = Map( b, math.sin( a ) * r, -math.cos( a ) * r )
		PushTri( vs, b, center, prev, p, color )
		prev = p
	end
end

-- Fills the part of the square between clock angles a0 and a1.
local function PushWedge( vs, b, a0, a1, color )
	if Alpha( color ) == 0 or a1 <= a0 then
		return
	end
	local angles = { a0 }
	for _, ca in ipairs( CORNERS ) do
		if ca > a0 and ca < a1 then
			angles[ #angles + 1 ] = ca
		end
	end
	angles[ #angles + 1 ] = a1

	local center = Map( b, 0, 0 )
	local prev = nil
	for _, a in ipairs( angles ) do
		local p = Map( b, EdgePoint( a ) )
		if prev then
			PushTri( vs, b, center, prev, p, color )
		end
		prev = p
	end
end


-- Icon square in window coords. Returns nil if the layer is missing.
function UI.Modules_SlotWnd:BeginCooldownClockDraw()

	local layer = self:GetLayer( UI.LAYER_VERTEX_STREAM, self.layers.COOLDOWN_CLOCK )
	if not layer then
		return nil
	end

	local layout = self.cooldownClockLayout or UI.Modules_SlotWnd.COOLDOWN_CLOCK_LAYOUTS.normal
	local W, H = self:GetWidth(), self:GetHeight()

	local b = {}
	b.hx = W * layout.side * 0.5
	b.hy = H * layout.height * 0.5
	b.cx = W * 0.5
	b.cy = H * layout.top + b.hy
	b.tc = UI:Vec2( 0, 0 )

	layer:Clear()
	layer:AddVertexStream()
	local vs = layer:GetVertexStream( layer:GetNumVertexStreams() - 1 )
	vs:SetTexture( UI:GetTex( "white" ) )

	self:SetLayerVisible( true, self.layers.COOLDOWN_CLOCK )

	return vs, b

end


-- fraction: elapsed part of the cooldown, 0..1 (0 = just used, 1 = ready)
function UI.Modules_SlotWnd:ShowCooldownClock( fraction )

	local cfg = UI.Modules_SlotWnd.COOLDOWN_CLOCK
	if not cfg.enabled then
		return
	end

	fraction = math.max( 0, math.min( 1, fraction or 0 ) )
	local step = math.floor( fraction * cfg.steps )

	-- redraw only when the hand moved a step or the slot was resized
	local key = string.format( "%d|%.3f|%.3f", step, self:GetWidth(), self:GetHeight() )
	if key == self.cooldownClockKey then
		return
	end

	self.readyFlashStart = nil

	local vs, b = self:BeginCooldownClockDraw()
	if not vs then
		return
	end
	self.cooldownClockKey = key

	-- our shading replaces the stock dark overlay
	self:SetLayerVisible( false, self.layers.ICO_INACTIVE_EFFECT )

	local angle = step / cfg.steps * TWO_PI

	-- box coords span 2 units per side, so double the width fractions
	local lw	= cfg.lineWidth * 2
	local ow	= cfg.outlineWidth * 2
	local sw	= cfg.softWidth * 2
	local hub	= cfg.hubRadius * 2

	-- lines run past the square and get cut off flush at 'clip'
	local clip = cfg.lineLength
	local hu, hv = math.sin( angle ) * 2, -math.cos( angle ) * 2
	local tu, tv = 0, -2

	PushWedge( vs, b, 0, angle, cfg.revealedColor )
	PushWedge( vs, b, angle, TWO_PI, cfg.shadeColor )

	PushLine( vs, b, 0, 0, tu, tv, lw + ow * 2, ow, cfg.outlineColor, clip )
	PushLine( vs, b, 0, 0, hu, hv, lw + ow * 2, ow, cfg.outlineColor, clip )
	PushDisc( vs, b, hub + ow, cfg.outlineColor )

	PushLine( vs, b, 0, 0, tu, tv, lw + sw * 2, sw, cfg.softColor, clip )
	PushLine( vs, b, 0, 0, hu, hv, lw + sw * 2, sw, cfg.softColor, clip )

	PushLine( vs, b, 0, 0, tu, tv, lw, 0, cfg.color, clip )
	PushLine( vs, b, 0, 0, hu, hv, lw, 0, cfg.color, clip )
	PushDisc( vs, b, hub, cfg.color )

	if cfg.debugSquare then
		PushLine( vs, b, -1, -1,  1, -1, lw, 0, 0xFFFF0000 )
		PushLine( vs, b,  1, -1,  1,  1, lw, 0, 0xFFFF0000 )
		PushLine( vs, b,  1,  1, -1,  1, lw, 0, 0xFFFF0000 )
		PushLine( vs, b, -1,  1, -1, -1, lw, 0, 0xFFFF0000 )
	end

end


--
function UI.Modules_SlotWnd:HideCooldownClock()

	local layer = self:GetLayer( UI.LAYER_VERTEX_STREAM, self.layers.COOLDOWN_CLOCK )
	if layer then
		layer:Clear()
	end

	self:SetLayerVisible( false, self.layers.COOLDOWN_CLOCK )

	-- give back the stock overlay if the module still can't be used
	if self.cooldownClockKey and self.icoInactiveWanted then
		self:SetLayerVisible( true, self.layers.ICO_INACTIVE_EFFECT )
	end

	self.cooldownClockKey = nil

end


-- White flash over the icon that fades out.
function UI.Modules_SlotWnd:StartReadyFlash()

	if not UI.Modules_SlotWnd.COOLDOWN_CLOCK.enabled or not _G.TimerGetRealTime then
		return
	end

	self.readyFlashStart = _G.TimerGetRealTime()
	self:UpdateReadyFlash()

end


-- Call every frame; does nothing when no flash is running.
function UI.Modules_SlotWnd:UpdateReadyFlash()

	if not self.readyFlashStart then
		return
	end

	local cfg = UI.Modules_SlotWnd.COOLDOWN_CLOCK
	local t = ( _G.TimerGetRealTime() - self.readyFlashStart ) / cfg.flashDuration

	if t >= 1 or self.cooldownClockKey then
		self.readyFlashStart = nil
		if not self.cooldownClockKey then
			self:HideCooldownClock()
		end
		return
	end

	local vs, b = self:BeginCooldownClockDraw()
	if not vs then
		self.readyFlashStart = nil
		return
	end

	local k = ( 1 - t ) * ( 1 - t )		-- ease out
	local alpha = math.floor( cfg.flashAlpha * k )
	PushWedge( vs, b, 0, TWO_PI, alpha * 0x1000000 + cfg.flashColor )

end

-- [/MOD cooldown-clock]

-- ----------------------------------------------------------------------
-- UI.Modules_SpecialSlotWnd
-- ----------------------------------------------------------------------

UI.Modules_SpecialSlotWnd = {}
local mss = UI.Modules_SpecialSlotWnd

-- ------------------------------
-- window definition
-- ------------------------------

UI.Modules_SpecialSlotWnd.def =
{
	className	= "Wnd",
	prototype	= "Modules_SlotWnd",

	props =
	{
		name		= "Modules_SpecialSlotWnd",
		isPrototype	= true,
	},

	layers =
	{
		-- MAIN_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,
			main		= true,

			effects =
			{{
				defName 			= "modules_specialSlot",
				defaultAnimation	= "idle",

				links =
				{
					{
						objName		= "self",
						animParams	= UI.EffectAnimParams.SIZE,
					},

					{
						objName		= "buff_icon",
						layer		= "UI.Modules_SlotWnd.layers.ICO_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "key_3",
						layer		= "UI.Modules_SlotWnd.layers.KEY_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "inactive",
						layer		= "UI.Modules_SlotWnd.layers.ICO_INACTIVE_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "modules_special_icon",
						layer		= "UI.Modules_SlotWnd.layers.ICO_BG_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "namber_ship",
						layer		= "UI.Modules_SlotWnd.layers.TARGETS_COUNT_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					}, 

					{
						objName		= "sel",	
						layer		= "UI.Modules_SlotWnd.layers.SEL_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "destroy_spec",	
						layer		= "UI.Modules_SlotWnd.layers.DESTROYED_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "cooldown",	
						layer		= "UI.Modules_SlotWnd.layers.WORK_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},
				}
			}}
		},

		-- ICO_BG_EFFECT
		{
			id			= UI.Modules_SlotWnd.layers.ICO_BG_EFFECT,

			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "modules_slot_specialIcoBg",
				defaultAnimation	= "active",
			}}
		},

		-- SEL_EFFECT
		{
			id			= UI.Modules_SlotWnd.layers.SEL_EFFECT,

			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "modules_slot_specialSel",
				defaultAnimation	= "actitvity_on",
			}}
		},

		-- ICO_INACTIVE_EFFECT
		{
			id			= UI.Modules_SlotWnd.layers.ICO_INACTIVE_EFFECT,

			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "modules_slot_specialIcoInactive",
				defaultAnimation	= "idle",
			}}
		},

		-- DESTROYED_EFFECT
		{
			id			= UI.Modules_SlotWnd.layers.DESTROYED_EFFECT,

			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "modules_slot_specialDestroyed",
				defaultAnimation	= "idle",
			}}
		},

		-- невидимый, в логике не используется, нужен чисто для организации локаторов в эффекте
		-- WORK_EFFECT
		{
			id			= UI.Modules_SlotWnd.layers.WORK_EFFECT,

			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "modules_slot_specialWork",
				defaultAnimation	= "idle",

				links =
				{
    				{
    					objName		= "cooldown_text",	
    					layer		= "UI.Modules_SlotWnd.layers.COOLDOWN_TIME",
    					animParams	= UI.EffectAnimParams.ALL,
    				},

    				{
    					objName		= "reload",	
    					layer		= "UI.Modules_SlotWnd.layers.AMMO_EFFECT",
    					animParams	= UI.EffectAnimParams.POS,
    				},

    				{
    					objName		= "flash",	
    					layer		= "UI.Modules_SlotWnd.layers.FLASH_EFFECT",
    					animParams	= UI.EffectAnimParams.POS,
    				},
				}
			}}
		},

		-- FLASH_EFFECT
		{
			id			= UI.Modules_SlotWnd.layers.FLASH_EFFECT,

			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "modules_slot_specialFlash",
				defaultAnimation	= "idle",
			}}
		},
	}
}