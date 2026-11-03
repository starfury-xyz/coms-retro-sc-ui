-- ----------------------------------------------------------------------------
--
-- Workfile: equipmentwnd_new.lua
-- Copyright й 2006, Targem LLC. All rights reserved.
--
-- ----------------------------------------------------------------------------
--  $Id: $
-- ----------------------------------------------------------------------------

-- for test
if _EQ_ALL == nil then
	_EQ_ALL = false
end

local resolution = UI:GetCoordinateSystemForAspect( UI.screenHeight / UI.screenWidth )

UI.EquipmentWnd = {}
local ew = UI.EquipmentWnd

-- ------------------------------
-- window definition
-- ------------------------------

ew.layers =
{
    MAIN_EFFECT_720							= 0,
	BG_EFFECT								= 1,
	MAIN_EFFECT_1080						= 2,
	SHIP_INFO_EFFECT						= 3,
	SHIP_SLOTS_EFFECT						= 4,
	SHIP_SLOTS_ACTIVE_EFFECT				= 5,
	SHIP_SLOTS_AUTOGEN_EFFECT				= 6,
	SHIP_SLOTS_PASSIVE_EFFECT				= 7,
	SHIP_SLOTS_PASSIVE_ENGINE_MOD_EFFECT	= 8,
	SHIP_SLOTS_PASSIVE_CAPACITOR_MOD_EFFECT	= 9,
	SHIP_SLOTS_PASSIVE_SHIELD_MOD_EFFECT	= 10,
	SHIP_SLOTS_PASSIVE_ARMOR_MOD_EFFECT		= 11,
	SHIP_SLOTS_PASSIVE_CPU_MOD_EFFECT		= 12,
	SHIP_SLOTS_LABEL_WEAPON					= 13,
	SHIP_SLOTS_LABEL_ACTIVE					= 14,
	SHIP_SLOTS_LABEL_ENGINE_MOD				= 15,
	SHIP_SLOTS_LABEL_CAPACITOR_MOD			= 16,
	SHIP_SLOTS_LABEL_SHIELD_MOD				= 17,
	SHIP_SLOTS_LABEL_ARMOR_MOD				= 18,
	SHIP_SLOTS_LABEL_CPU_MOD				= 19,
	SHIP_SLOTS_LABEL_AMMO_PRIMARY			= 20,
	SHIP_SLOTS_LABEL_AMMO_SECONDARY			= 21,
	SHIP_SLOTS_LABEL_SPECIAL				= 22,
	SHIP_SLOTS_LABEL_AUTOGEN				= 23,
}


UI.EquipmentWnd.def =
{
	className	= "Wnd",
	prototype	= "FullScreenSelectionWnd",
	
	props =
	{
		name	= "EquipmentWnd",
		style	= UI.WS_UPDATE_IF_VISIBLE + UI.WS_NOT_MOUSE_REACT + UI.WS_REDIRECT_ACTIVATION_TO_CHILDREN,
	},

	layers =
	{
		-- MAIN_EFFECT_720
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,
			main		= true,

			effects =
			{{
				defName 			= "equipment_main_new_720",
				defaultAnimation	= "idle",

				links =
				{
					{
						objName		= "lvlup_ship_main",	
						wnd			= "UI.EquipmentShipUpgradeWnd",
						animParams	= UI.EffectAnimParams.POS,
					},
				}
			}}
		},

		-- legacy from FullScreenWnd
		-- BG_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,
			visible		= false,
		},
		
		-- MAIN_EFFECT_1080
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,
			main		= true,

			effects =
			{{
				defName 			= "equipment_main_new_1080",
				defaultAnimation	= "idle",

				links =
				{
					{
						objName		= "passiv_slots",
						layer		= "UI.EquipmentWnd.layers.SHIP_SLOTS_PASSIVE_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},
					
					{
						objName		= "ship_prop",
						layer		= "UI.EquipmentWnd.layers.SHIP_INFO_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},
					
					{
						objName		= "modules_3",
						layer		= "UI.EquipmentWnd.layers.SHIP_SLOTS_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},
					
					{
						objName		= "agen",
						layer		= "UI.EquipmentWnd.layers.SHIP_SLOTS_AUTOGEN_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},
					
					{
						objName		= "preset",
						wnd			= "UI.ShipPresetsWnd",
						animParams	= UI.EffectAnimParams.POS,
					},
				}
			}}
		},
		
		-- SHIP_INFO_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "hangar_shipInfo",
				defaultAnimation	= "idle",

				links =
				{
					{
						objName		= "ship_info",
						wnd			= "UI.EquipmentShipInfoWnd",
						animParams	= UI.EffectAnimParams.POS,
					},
					
					{
						objName		= "progr_prop",
						wnd			= "UI.EquipmentShipMainParamsWnd",
						animParams	= UI.EffectAnimParams.POS,
					},
					
					{
						objName		= "survival",
						wnd			= "UI.EquipmentShipSurvivabilityWnd",
						animParams	= UI.EffectAnimParams.POS,
					},
					
					{
						objName		= "ship_proper",
						wnd			= "UI.EquipmentShipParamsWnd",
						animParams	= UI.EffectAnimParams.POS,
					},
				}
			}}
		},
		
		-- SHIP_SLOTS_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "equipment_shipSlots_1080",
				defaultAnimation	= "idle",
				
				links =
				{
					{
						objName		= "active_modules",
						layer		= "UI.EquipmentWnd.layers.SHIP_SLOTS_ACTIVE_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},
					
					{
						objName		= "weap",
						layer		= "UI.EquipmentWnd.layers.SHIP_SLOTS_LABEL_WEAPON",
						animParams	= UI.EffectAnimParams.ALL,
					},

					{
						objName		= "active",
						layer		= "UI.EquipmentWnd.layers.SHIP_SLOTS_LABEL_ACTIVE",
						animParams	= UI.EffectAnimParams.ALL,
					},

					{
						objName		= "ammo",
						layer		= "UI.EquipmentWnd.layers.SHIP_SLOTS_LABEL_AMMO_PRIMARY",
						animParams	= UI.EffectAnimParams.ALL,
					},

					{
						objName		= "rocket",
						layer		= "UI.EquipmentWnd.layers.SHIP_SLOTS_LABEL_AMMO_SECONDARY",
						animParams	= UI.EffectAnimParams.ALL,
					}, 

					{
						objName		= "sp",
						layer		= "UI.EquipmentWnd.layers.SHIP_SLOTS_LABEL_SPECIAL",
						animParams	= UI.EffectAnimParams.ALL,
					},
				}
			}}
		},

		-- SHIP_SLOTS_ACTIVE_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "equipment_shipSlotsActive_1080",
				defaultAnimation	= "idle",
			}}
		},

		-- SHIP_SLOTS_AUTOGEN_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "equipment_shipSlotsAutogen",
				defaultAnimation	= "idle",
				
				links =
				{
					{
						objName		= "ship_name10",
						layer		= "UI.EquipmentWnd.layers.SHIP_SLOTS_LABEL_AUTOGEN",
						animParams	= UI.EffectAnimParams.ALL,
					},
				}
			}}
		},
		
		-- SHIP_SLOTS_PASSIVE_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "equipment_shipSlotsPassive",
				defaultAnimation	= "idle",
			}}
		},
		
		-- SHIP_SLOTS_PASSIVE_ENGINE_MOD_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "equipment_shipSlotsPassive_group",
				defaultAnimation	= "idle",
				
				links =
				{
					{
						objName		= "ship_name9",
						layer		= "UI.EquipmentWnd.layers.SHIP_SLOTS_LABEL_ENGINE_MOD",
						animParams	= UI.EffectAnimParams.ALL,
					},
				}
			}}
		},
		
		-- SHIP_SLOTS_PASSIVE_CAPACITOR_MOD_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "equipment_shipSlotsPassive_group",
				defaultAnimation	= "idle",
				
				links =
				{
					{
						objName		= "ship_name9",
						layer		= "UI.EquipmentWnd.layers.SHIP_SLOTS_LABEL_CAPACITOR_MOD",
						animParams	= UI.EffectAnimParams.ALL,
					},
				}
			}}
		},
		
		-- SHIP_SLOTS_PASSIVE_SHIELD_MOD_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "equipment_shipSlotsPassive_group",
				defaultAnimation	= "idle",
				
				links =
				{
					{
						objName		= "ship_name9",
						layer		= "UI.EquipmentWnd.layers.SHIP_SLOTS_LABEL_SHIELD_MOD",
						animParams	= UI.EffectAnimParams.ALL,
					},
				}
			}}
		},
		
		-- SHIP_SLOTS_PASSIVE_ARMOR_MOD_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "equipment_shipSlotsPassive_group",
				defaultAnimation	= "idle",
				
				links =
				{
					{
						objName		= "ship_name9",
						layer		= "UI.EquipmentWnd.layers.SHIP_SLOTS_LABEL_ARMOR_MOD",
						animParams	= UI.EffectAnimParams.ALL,
					},
				}
			}}
		},
		
		-- SHIP_SLOTS_PASSIVE_CPU_MOD_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "equipment_shipSlotsPassive_group",
				defaultAnimation	= "idle",

				links =
				{
					{
						objName		= "ship_name9",
						layer		= "UI.EquipmentWnd.layers.SHIP_SLOTS_LABEL_CPU_MOD",
						animParams	= UI.EffectAnimParams.ALL,
					},
				}
			}}
		},

		-- SHIP_SLOTS_LABEL_WEAPON
		{
			layerType		= UI.LAYER_TEXT,

   			formatFlags	 	= FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz	= { 1, 1 },
   			font			= { fontName = "Small" },

			text			= "^equipSlot_WEAPON_hangar"
		},

		-- SHIP_SLOTS_LABEL_ACTIVE
		{
			layerType		= UI.LAYER_TEXT,

   			formatFlags	 	= FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz	= { 1, 1 },
   			font			= { fontName = "Small" },

			text			= "^equipSlot_ACTIVE_hangar"
		},

		-- SHIP_SLOTS_LABEL_ENGINE_MOD
		{
			layerType		= UI.LAYER_TEXT,
   			formatFlags	 	= FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz	= { 1, 1 },
   			font			= { fontName = "Small" },

			text			= UI:GetStringByName( "equipSlot_ENGINE_MOD_hangar" ),
		},

		-- SHIP_SLOTS_LABEL_CAPACITOR_MOD
		{
			layerType		= UI.LAYER_TEXT,
   			formatFlags	 	= FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz	= { 1, 1 },
   			font			= { fontName = "Small" },

			text			= UI:GetStringByName( "equipSlot_CAPACITOR_MOD_hangar" ),
		},

		-- SHIP_SLOTS_LABEL_SHIELD_MOD
		{
			layerType		= UI.LAYER_TEXT,
   			formatFlags	 	= FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz	= { 1, 1 },
   			font			= { fontName = "Small" },

			text			= UI:GetStringByName( "equipSlot_SHIELD_MOD_hangar" ),
		},

		-- SHIP_SLOTS_LABEL_ARMOR_MOD
		{
			layerType		= UI.LAYER_TEXT,
   			formatFlags	 	= FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz	= { 1, 1 },
   			font			= { fontName = "Small" },

			text			= UI:GetStringByName( "equipSlot_ARMOR_MOD_hangar" ),
		},

		-- SHIP_SLOTS_LABEL_CPU_MOD
		{
			layerType		= UI.LAYER_TEXT,
   			formatFlags	 	= FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz	= { 1, 1 },
   			font			= { fontName = "Small" },

			text			= UI:GetStringByName( "equipSlot_CPU_MOD_hangar" ),
		},

		-- SHIP_SLOTS_LABEL_AMMO_PRIMARY
		{
			layerType		= UI.LAYER_TEXT,

   			formatFlags	 	= FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz	= { 1, 1 },
   			font			= { fontName = "Small" },

			text			= UI:GetStringByName( "equipSlot_AMMO_PRIMARY_hangar" )
		},

		-- SHIP_SLOTS_LABEL_AMMO_SECONDARY
		{
			layerType		= UI.LAYER_TEXT,

   			formatFlags	 	= FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz	= { 1, 1 },
   			font			= { fontName = "Small" },

			text			= UI:GetStringByName( "equipSlot_AMMO_SECONDARY_hangar" ),
		},

		-- SHIP_SLOTS_LABEL_SPECIAL
		{
			layerType		= UI.LAYER_TEXT,

   			formatFlags	 	= FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz	= { 1, 1 },
   			font			= { fontName = "Small" },

			text			= UI:GetStringByName( "equipSlot_SPECIAL_hangar" ),
		},
		
		-- SHIP_SLOTS_LABEL_AUTOGEN
		{
			layerType		= UI.LAYER_TEXT,
			layerStyle		= UI.WLS_OWNERDRAW,
			formatFlags	 	= FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
			formatInfoSz	= { 1, 1 },
			font			= { fontName = "Small" },
		},
	},

	children =
	{
		"UI.Equipment_ItemsListWnd",
		"UI.Equipment_DDIco",
		"UI.EquipmentShipUpgradeWnd",
		"UI.ShipPresetsWnd",
		"UI.EquipmentShipInfoWnd",
		"UI.EquipmentShipMainParamsWnd",
		"UI.EquipmentShipSurvivabilityWnd",
		"UI.EquipmentShipParamsWnd",
	}
}

-- ------------------------------
-- interface functions
-- ------------------------------

-- called from UI.HangarWnd
function UI.EquipmentWnd:OnHangarSelShipChanged()

	if not self:IsOnScreen() then
		return
	end

	self:UpdateSelShip()

end


--
function UI.EquipmentWnd:GameStore_OnChangeEquipment( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	if result ~= _G.GameStore.ModuleEquipResult.MER_OK then
		UI:ShowMessageOnEquipError( result )
	end

end  


--
function UI.EquipmentWnd:GameStore_OnTransferEquipment( result, requestId, param1, param2, u64Param  )

	if not self:IsOnScreen() then
		return
	end

	if result ~= _G.GameStore.ModuleEquipResult.MER_OK then
		self.equipTransferInfo = nil
		UI:ShowMessageOnEquipError( result )
	end

end


--
function UI.EquipmentWnd:GameStore_OnChangeMunition( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	if result ~= _G.GameStore.MunitionResult.MR_OK then
		UI:ShowMessageOnChangeMunitionError( result ) 
	end

end  


--
function UI.EquipmentWnd:GameStore_OnTransferMunition( result, requestId, param1, param2, u64Param )

	if not self:IsOnScreen() then
		return
	end

	if result ~= _G.GameStore.MunitionResult.MR_OK then
		UI:ShowMessageOnChangeMunitionError( result ) 
	end

end


--
function UI.EquipmentWnd:GameStore_OnInventory( result, requestId, param1, param2 )

	UI.Equipment_UpgradeItemWnd:GameStore_OnInventory( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	if result == 1 then
		self:ShowMessageOnTimeOut()
	end

end


--
function UI.EquipmentWnd:GameStore_OnAutogenInventory( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	if result == 1 then
		self:ShowMessageOnTimeOut()
	end

end


--
function UI.EquipmentWnd:GameStore_OnBuyItem( result, requestId, param1, param2, u64Param )

	if requestId == 0 or requestId ~= self.buyRequestId then
		return
	end

	self.buyRequestId = 0

	if not self:IsOnScreen() then
		return
	end

	if result == _G.GameStore.StoreBuyResult.SBR_OK then

		-- сначала этот коллбэк должен обработаться в UI:UpdateServerData_OnBuyItem;
		-- оттуда должен был уже прийти и быть обработан евент EV_INV_ITEMS_CHANGED

		if not self:IsWaitingRequests() then

        	if u64Param ~= nil and u64Param ~= UI.INVALID_U64_ID then
				self.buyInfo.boughtIid = u64Param
        		self:EquipBoughtModule( self.buyInfo )
			else

				local shopItem = UI:GetShopItemById( param1 ) 				
				if shopItem and not UI:IsDefBundle( shopItem.defName ) then
					sys.log( "UI.EquipmentWnd:GameStore_OnBuyItem()[ERROR]: invalid iid" )	
				end
        	end

		else
			sys.log( "UI.EquipmentWnd:GameStore_OnBuyItem()[ERROR]: still waiting some requests" )
		end

	else

		self:ShowBuyErrorMsg( result )

	end

	self:ResetBuyInfo()

end


--
function UI.EquipmentWnd:GameStore_OnSellItem( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	if result == 1 then
		self:ShowMessageOnTimeOut()
	elseif result == 2 then
		UI:ShowMsgOnSellError()
	end

end


--
function UI.EquipmentWnd:GameStore_OnSellItems( result, requestId, param1, param2 )

	UI.Equipment_SalvageWnd:GameStore_OnSellItems( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	if result == 1 then
		self:ShowMessageOnTimeOut()
	elseif result == 2 then
		UI:ShowMsgOnSellError()
	end

end


--
function UI.EquipmentWnd:GameStore_OnSalvageItem( result, requestId, param1, param2 )

	UI.Equipment_SalvageWnd:GameStore_OnSalvageItem( result, requestId, param1, param2 )

end


--
function UI.EquipmentWnd:GameStore_OnUpgradeItems( result, requestId, iids )

	UI.Equipment_UpgradeItemWnd:GameStore_OnUpgradeItems( result, requestId, iids )

end


--
function UI.EquipmentWnd:IsDD()

	return self.ddInfo.ddState ~= self.ddStates.NONE

end


--
function UI.EquipmentWnd:GetSelShipItem()

	return self.selShipItem

end


--
function UI.EquipmentWnd:GetSelShipEntId()

	return self.selShipEntId

end


--
function UI.EquipmentWnd:GetSelShipSlot()

	return self.selShipSlot

end


--
function UI.EquipmentWnd:GetSelShipSlotInfo()

	local selInfo = nil

	if self.selShipSlot then

		selInfo =
		{
			slotType			= self.selShipSlot:GetShipSlotType(),
			slotId				= self.selShipSlot:GetSlotId(),			
			itemsLayout			= nil,
			itemsUpLevelLayout	= nil,
		}

		if self.itemsListWnd:IsOnScreen() then

			selInfo.itemsLayout = { subType = -1, rank = -1, scrollPos = -1 }

			selInfo.itemsLayout.subType, selInfo.itemsLayout.rank = self:GetOpenItemsSubType()
			selInfo.itemsLayout.scrollPos = self.itemsListWnd:GetScrollPos()

			if selInfo.itemsLayout.subType ~= -1 then
				selInfo.itemsUpLevelLayout = self.savedItemsUpLevelLayout
			end

		else
			sys.log( "UI.EquipmentWnd:GetSelShipSlotInfo()[ERROR]: intems list is not on screen" )
		end

	end

	return selInfo

end


--
function UI.EquipmentWnd:SelectShipSlotByInfo( selInfo )

	if not self:IsOnScreen() then
		sys.log( "UI.EquipmentWnd:SelectShipSlotByInfo()[ERROR]: not on screen" )
		return
	end
	
	if selInfo == nil then
		self:SelectShipSlot( nil )
		return
	end
	
	if type( selInfo ) ~= "table" then
		sys.log( "UI.EquipmentWnd:SelectShipSlotByInfo()[ERROR]: invalid type of 1-st parameter (\"selInfo\"); \"table\" or \"nil\" expected, got \"%s\"", type( selInfo ) )
		return
	end

	if type( selInfo.slotType ) ~= "number" then
		sys.log( "UI.EquipmentWnd:SelectShipSlotByInfo()[ERROR]: invalid type of selInfo.slotType; \"number\" expected, got \"%s\"", type( selInfo.slotType ) )
		return
	end

	if type( selInfo.slotId ) ~= "number" then
		sys.log( "UI.EquipmentWnd:SelectShipSlotByInfo()[ERROR]: invalid type of selInfo.slotId; \"number\" expected, got \"%s\"", type( selInfo.slotId ) )
		return
	end

	local bAmmo = self:IsShipSlotTypeAmmo( selInfo.slotType )

	local slotWnd = bAmmo and self:GetShipSlotForAmmoId( selInfo.slotId ) or self:GetShipSlotForModuleId( selInfo.slotId ) 

	if not slotWnd then
		sys.log( "UI.EquipmentWnd:SelectShipSlotByInfo()[ERROR]: cannot find slot for type %d id %d", selInfo.slotId, selInfo.slotId )
		return
	end

	self:SelectShipSlot( slotWnd )


	local function fnSetItemsLayout()

		if selInfo.itemsLayout == nil then
			return
		end

    	if type( selInfo.itemsLayout ) ~= "table" then
    		sys.log( "UI.EquipmentWnd:SelectShipSlotByInfo()[ERROR]: invalid type of selInfo.itemsLayout; \"table\" or \"nil\" expected, got \"%s\"", type( selInfo.itemsLayout ) )
			return
    	end

    	if type( selInfo.itemsLayout.subType ) ~= "number" and type( selInfo.itemsLayout.subType ) ~= "string" then
    		sys.log( "UI.EquipmentWnd:SelectShipSlotByInfo()[ERROR]: invalid type of selInfo.itemsLayout.subType; \"number\" or \"string\" expected, got \"%s\"", type( selInfo.itemsLayout.subType ) )
			return
    	end

    	if type( selInfo.itemsLayout.rank ) ~= "number" then
    		sys.log( "UI.EquipmentWnd:SelectShipSlotByInfo()[ERROR]: invalid type of selInfo.itemsLayout.rank; \"number\" expected, got \"%s\"", type( selInfo.itemsLayout.rank ) )
			return
    	end

		if selInfo.itemsLayout.subType ~= -1 then

			self:OpenItemsSubType( selInfo.itemsLayout.subType, selInfo.itemsLayout.rank, false )

			local openSubType, openRank = self:GetOpenItemsSubType()
			if openSubType ~= selInfo.itemsLayout.subType or openRank ~= selInfo.itemsLayout.rank then
				sys.log( "UI.EquipmentWnd:SelectShipSlotByInfo()[ERROR]: cannot open subtype %d and rank %d", selInfo.itemsLayout.subType, selInfo.itemsLayout.rank )
				return
			end

			if selInfo.itemsUpLevelLayout ~= nil then

				local bValidUpLevelLayout = true

    			if type( selInfo.itemsUpLevelLayout ) == "table" then

                	if type( selInfo.itemsUpLevelLayout.subType ) ~= "number" and type( selInfo.itemsLayout.subType ) ~= "string" then
                		sys.log( "UI.EquipmentWnd:SelectShipSlotByInfo()[ERROR]: invalid type of selInfo.itemsUpLevelLayout.subType; \"number\" or \"string\" expected, got \"%s\"", type( selInfo.itemsUpLevelLayout.subType ) )
						bValidUpLevelLayout = false
                	end

                	if type( selInfo.itemsUpLevelLayout.rank ) ~= "number" then
                		sys.log( "UI.EquipmentWnd:SelectShipSlotByInfo()[ERROR]: invalid type of selInfo.itemsUpLevelLayout.rank; \"number\" expected, got \"%s\"", type( selInfo.itemsUpLevelLayout.rank ) )
						bValidUpLevelLayout = false
                	end

                	if type( selInfo.itemsUpLevelLayout.scrollPos ) ~= "number" then
                		sys.log( "UI.EquipmentWnd:SelectShipSlotByInfo()[ERROR]: invalid type of selInfo.itemsUpLevelLayout.scrollPos; \"number\" expected, got \"%s\"", type( selInfo.itemsUpLevelLayout.scrollPos ) )
						bValidUpLevelLayout = false
                	end

				else
    				sys.log( "UI.EquipmentWnd:SelectShipSlotByInfo()[ERROR]: invalid type of selInfo.itemsUpLevelLayout; \"table\" or \"nil\" expected, got \"%s\"", type( selInfo.itemsUpLevelLayout ) )
					bValidUpLevelLayout = false
				end

				if bValidUpLevelLayout then
					self.savedItemsUpLevelLayout = selInfo.itemsUpLevelLayout
				end
				
			end
		
		end

    	if type( selInfo.itemsLayout.scrollPos ) == "number" then

			if selInfo.itemsLayout.scrollPos ~= -1 then
				self.itemsListWnd:SetScrollPos( selInfo.itemsLayout.scrollPos )
			end
	
		else
    		sys.log( "UI.EquipmentWnd:SelectShipSlotByInfo()[ERROR]: invalid type of selInfo.itemsLayout.scrollPos; \"number\" expected, got \"%s\"", type( selInfo.itemsLayout.scrollPos ) )
		end

	end

	fnSetItemsLayout()

end


--
function UI.EquipmentWnd:GetOpenBundle()

	if UI.BuyBundleWnd:IsOnScreen() and UI.BuyBundleWnd:GetMainWndName() == self:GetScriptTableName() then
		return UI.BuyBundleWnd:GetDefName(), UI.BuyBundleWnd:GetData()
	else
		return "", nil
	end

end


--
function UI.EquipmentWnd:OpenBundle( defName, data )

	if not self:IsOnScreen() then
		sys.log( "UI.EquipmentWnd:OpenBundle()[ERROR]: not on screen" )
		return
	end

	if type( defName ) ~= "string" then
		sys.log( "UI.EquipmentWnd:OpenBundle()[ERROR]: invalid type of the 1-st parameter (\"defName\"); \"string\" expected, got \"%s\"", type( defName ) )
		return
	end

	if defName == "" then
		sys.log( "UI.EquipmentWnd:OpenBundle()[ERROR]: empty defName" )
		return
	end

	if data ~= nil then
		if type( data ) ~= "table" then
			sys.log( "UI.EquipmentWnd:OpenBundle()[ERROR]: invalid type of the 2-nd parameter (\"data\"); \"table\" or \"nil\" expected, got \"%s\"", type( data ) )
			return
		end
	end

	self:LaunchBuyBundleWnd( defName, data )

end


-- коллбэк, вызывается из окна покупки
function UI.EquipmentWnd:OnTradeResult_Buy( shopItem, count, priceType )

	if UI:IsDefAmmo( shopItem.defName ) then

		UI:PlayGlobalSound( self.sounds.equip )

		self:EquipAmmoInternal( self.buyInfo.shopItem.defName, self.buyInfo.shipItem.vid, self.buyInfo.slotId )

    	if self:GetOpenItemsSubType() ~= -1 then
    		self:OpenItemsSubType( -1, -1, true )
    	end

	elseif UI:IsDefBundle( shopItem.defName ) then

		self:DoBuyBundle( shopItem )

	else

		UI:PlayGlobalSound( self.sounds.equip )

		if not UI:IsDefBundle( shopItem.defName ) and not UI:IsDefAmmo( shopItem.defName ) then
    		self.buyRequestId = _G.GameStore_Buy( self.buyInfo.shopItem.id, count, priceType, 2 )	-- #0072739, (0309199) - 2 нужна для сбора статистики
		else
    		self.buyRequestId = _G.GameStore_Buy( self.buyInfo.shopItem.id, count, priceType )
		end

    	if self.buyRequestId ~= 0 then
    		UI:AddWaitingRequest( self.buyRequestId )
    	end

	end

end


-- коллбэк, вызывается из окна покупки
function UI.EquipmentWnd:OnTradeResult_Sell( invItem, count )

	if invItem.itemType == UI.invItemTypes.MODULE then

		local iids = {}
		for i = 1, count do
			table.insert( iids, invItem.iids[ i ] )
		end

		UI:AddWaitingRequest( _G.GameStore_SellItems( iids ) )

		if invItem.equipShipItem then

			UI:AddWaitingRequest( UI.VESSEL_EQUIPMENT_REQUEST_ID )

			if UI:GetModuleType( invItem.defName ) == ai.ModuleType.WEAPON then
				self:CheckShowMsgOnUnequipPrimaryAmmo( invItem.equipShipItem, ai.WeaponClass.UNKNOWN )
			end

		end

	elseif invItem.itemType == UI.invItemTypes.AMMO then

		if invItem.equipShipItem then
			sys.log( "UI.EquipmentWnd:OnTradeResult_Sell()[ERROR]: trying to sell equipped ammo" )
		else
			UI:AddWaitingRequest( _G.GameStore_SellItem( invItem.iids[ 1 ], count ) )
		end

	else
		sys.log( "UI.EquipmentWnd:OnTradeResult_Sell()[ERROR]: unhandled type of item: %s", tostring( invItem.itemType ) )
	end

end


-- коллбэк, вызывается из окна покупки
function UI.EquipmentWnd:OnTradeResult_Cancel()

	self:ResetBuyInfo()

end


-- коллбэк, вызывается из окна увеличения инвентаря
function UI.EquipmentWnd:OnBuyWndResult( result, mode, data )

	if mode == UI.BuyWnd.modes.INVENTORY_AUTO then

    	if result == true then
    		self:BuyInventory()
    	else
    		self:ResetBuyInfo()		
    	end

	elseif mode == UI.BuyWnd.modes.SALVAGE then

    	if result == true then
			self:DoSalvageItem2( data.iid )
		end

	else
		sys.log( "UI.EquipmentWnd:OnBuyWndResult()[ERROR]: unhandled mode %d", mode )
	end

end


--
function UI.EquipmentWnd:MasterServer_OnPlayerCredits( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	UI.Equipment_TradeWnd:MasterServer_OnPlayerCredits( result, requestId, param1, param2 )
	UI.Equipment_BuyWnd:MasterServer_OnPlayerCredits( result, requestId, param1, param2 )
	UI.Equipment_UpgradeItemWnd:MasterServer_OnPlayerCredits( result, requestId, param1, param2 )
	self:UpdateShipUpgradeWnd()
	UI.Equipment_SalvageWnd:MasterServer_OnPlayerCredits( result, requestId, param1, param2 )
	UI.Equipment_BuyWithInventoryWnd:MasterServer_OnPlayerCredits( result, requestId, param1, param2 )
	UI.EquipmentShipUpgradeWnd:MasterServer_OnPlayerCredits( result, requestId, param1, param2 )

	if result ~= 0 then
		return
	end

	if self:IsItemsPanelVisible() then
		if not UI.serverData.playerCredits.raceRepChanged then
	    	self.itemsListWnd:OnPlayerCreditsChanged()
		end
	end

	for slotId, slotWnd in pairs( self.shipSlots ) do
		if UI:IsWndKindOf( slotWnd, "Equipment_ModuleShipSlotWnd" ) then
			slotWnd:OnPlayerCreditsChanged()
		end
	end

end


--
function UI.EquipmentWnd:MasterServer_OnAccountRankUp( result, requestId, accountRank )

	if not self:IsOnScreen() then
		return
	end

	if result ~= 0 then
		return
	end

	if self:IsItemsPanelVisible() then
		self:UpdateItems( true )
	end
	
	self:UpdateShipPresetsVisibility()

end


--
function UI.EquipmentWnd:GameStore_OnBuyInventoryExtension( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	if requestId == self.requestId_buyInventory then

		self.requestId_buyInventory = 0

    	if result == _G.GameStore.StoreBuyResult.SBR_OK then

    		if self.buyInfo.shopItem then

				if UI:IsDefBundle( self.buyInfo.shopItem.defName ) then
	            	self:DoBuyBundle( self.buyInfo.shopItem )
					self:ResetBuyInfo()
				else
					self:LaunchTradeWnd( self.buyInfo.shopItem, false )
				end

    		else
    			sys.log( "UI.EquipmentWnd:GameStore_OnBuyInventoryExtension(): nil itemToBuy" )
    		end

    	else
			self:ResetBuyInfo()
    		self:ShowBuyErrorMsg( result )
    	end

	end

end


--
function UI.EquipmentWnd:TryBuyAdvertItem( defName, slot )

	if not self:IsOnScreen() then
		sys.log( "UI.EquipmentWnd:TryBuyAdvertItem()[ERROR]: not on screen" )
		return
	end

	if type( defName ) ~= "string" then
		sys.log( "UI.EquipmentWnd:TryBuyAdvertItem()[ERROR]: invalid type of the 1-st parameter (\"defName\"); \"string\" expected, got \"%s\"", type( defName ) )
		return
	end

	if type( slot ) ~= "number" then
		sys.log( "UI.EquipmentWnd:TryBuyAdvertItem()[ERROR]: invalid type of the 2-nd parameter (\"slot\"); \"number\" expected, got \"%s\"", type( slot ) )
		return
	end

	local bAmmo = UI:IsDefAmmo( defName )

	local slotWnd = bAmmo and self:GetShipSlotForAmmoId( slot ) or self:GetShipSlotForModuleId( slot ) 
	if not slotWnd then
		sys.log( "UI.EquipmentWnd:TryBuyAdvertItem()[ERROR]: cannot find slot %d", slot )
		return
	end

	-- выделяется соответствующий слот корабля
	self:SelectShipSlot( slotWnd )


	-- поиск вещи в списке

	local shopRecordIdx = -1
	local inventoryRecordIdx = -1

	local subType, rank = self:GetItemSubTypeExByDefName( defName )
	local openSubType, openRank = self:GetOpenItemsSubType()

	if subType ~= -1 and ( openSubType ~= subType or openRank ~= rank ) then
		self:OpenItemsSubType( subType, rank, false )
	end

	for recordIdx = 1, self.itemsListWnd:GetNumRecords() do

		local data = self.itemsListWnd:GetRecordData( recordIdx )

		if data.item.defName == defName then

			if data.item.itemType == self.itemTypes.SHOP then
				shopRecordIdx = recordIdx
				break

			elseif data.item.itemType == self.itemTypes.INVENTORY then
				inventoryRecordIdx = recordIdx
			end

		end

	end

	if shopRecordIdx == -1 and inventoryRecordIdx == -1 then
		sys.log( "UI.EquipmentWnd:TryBuyAdvertItem()[ERROR]: cannot find item \"%s\" in list", defName )
		return
	end

	-- позиция скролла в списке устанавливается таким образом, чтобы вещь оказалась (по возможности) в самом верху

	local itemRecordIdx = shopRecordIdx ~= -1 and shopRecordIdx or inventoryRecordIdx
	self.itemsListWnd:SetScrollPos( itemRecordIdx, true, false )

	-- если вещи нет в инвентаре, то вызывается окошко покупки
	if shopRecordIdx ~= -1 then

		local data = self.itemsListWnd:GetRecordData( itemRecordIdx )
		self:TryQuickEquip( data.item )

	end

end


--
function UI.EquipmentWnd:GameStore_OnSpoiled( result, requestId )

	if result ~= 0 then
		return
	end

	if not self:IsOnScreen() then
		return
	end

	if UI.Equipment_TradeWnd:IsOnScreen() or UI.Equipment_BuyWnd:IsOnScreen() then
		self:ResetBuyInfo()
	end

	UI.Equipment_TradeWnd:UnlinkFromParent()
	UI.Equipment_BuyWnd:UnlinkFromParent()
	UI.Equipment_SalvageWnd:UnlinkFromParent()
	UI.Equipment_UpgradeItemWnd:UnlinkFromParent()
	
	if UI.AutogenUpgradeWnd:GetMainWndName() == self:GetName() then
		UI.AutogenUpgradeWnd:Hide()
	end

	if self.hMsgRemoveItemFromOtherShip ~= UI.INVALID_UI_HANDLE then
		UI:RemoveUiObj( self.hMsgRemoveItemFromOtherShip )
		self.hMsgRemoveItemFromOtherShip = UI.INVALID_UI_HANDLE
		UI:Purge()
	end

end


--
function UI.EquipmentWnd:GameStore_OnLoadingComplete( storeSize )

	if not self:IsOnScreen() then
		return
	end

	self:HideChildModals()
	self:FullUpdate()

end


--
function UI.EquipmentWnd:F_OnEventMasterServerDisconnectedSync( hSender, iParam0, iParam1, fParam0, fParam1 )

	UI.Equipment_UpgradeItemWnd:F_OnEventMasterServerDisconnectedSync( hSender, iParam0, iParam1, fParam0, fParam1 )
	UI.ShipPresetsWnd:F_OnEventMasterServerDisconnectedSync( hSender, iParam0, iParam1, fParam0, fParam1 )

	self.vesselBudgetActivateRequestId	= 0
	self.vesselBudgetLevelUpRequestId	= 0
	self.recraftVesselRequestId			= 0
	self.autogenDestroyRequestId		= 0
	self.autogenIidToDestroy			= nil

	self:UpdateWaitEquipmentEffect()

end


--
function UI.EquipmentWnd:MasterServer_OnDisassembleItem( result, requestId, param1, param2 )

	if requestId == self.salvage2RequestId then

		if result ~= _G.GameStore.StoreBuyResult.SBR_OK then
			UI:ShowMsgOnSalvage2Error( result )
		end

		self.salvage2RequestId = 0

	end

end


--
function UI.EquipmentWnd:MasterServer_OnAccountAuras( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	UI.Equipment_TradeWnd:MasterServer_OnAccountAuras( result, requestId, param1, param2 )
	UI.Equipment_BuyWnd:MasterServer_OnAccountAuras( result, requestId, param1, param2 )
	UI.Equipment_BuyWithInventoryWnd:MasterServer_OnAccountAuras( result, requestId, param1, param2 )

	if result ~= 0 then
		return
	end

	if self:IsItemsPanelVisible() then
	    self.itemsListWnd:OnAccountAurasChanged()
	end

end


--
function UI.EquipmentWnd:MasterServer_OnAddAccountAura( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	UI.Equipment_TradeWnd:MasterServer_OnAddAccountAura( result, requestId, param1, param2 )
	UI.Equipment_BuyWnd:MasterServer_OnAddAccountAura( result, requestId, param1, param2 )
	UI.Equipment_BuyWithInventoryWnd:MasterServer_OnAddAccountAura( result, requestId, param1, param2 )

	if result ~= 0 then
		return
	end

	if self:IsItemsPanelVisible() then
	    self.itemsListWnd:OnAccountAurasChanged()
	end

end


--
function UI.EquipmentWnd:MasterServer_OnCancelAccountAura( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	UI.Equipment_TradeWnd:MasterServer_OnCancelAccountAura( result, requestId, param1, param2 )
	UI.Equipment_BuyWnd:MasterServer_OnCancelAccountAura( result, requestId, param1, param2 )
	UI.Equipment_BuyWithInventoryWnd:MasterServer_OnCancelAccountAura( result, requestId, param1, param2 )

	if result ~= 0 then
		return
	end

	if self:IsItemsPanelVisible() then
	    self.itemsListWnd:OnAccountAurasChanged()
	end

end


--
function UI.EquipmentWnd:MasterServer_OnVesselBudgetLevelUp( result, requestId, param1, param2, u64Param )

	if result == _G.GameStore.StoreBuyResult.SBR_OK then

		if self:IsOnScreen() then

        	local vid = u64Param

        	if self.selShipItem and self.selShipItem.vid == vid then

            	if self:IsItemsPanelVisible() then
            		self.itemsListWnd:OnVesselBudgetLevelUp()
            	end

			end

		end

	else

		if requestId ~= 0 and requestId == self.vesselBudgetLevelUpRequestId then
			self:ShowMsgOnVesselBudgetLevelUpError( result )
		end

	end

	if requestId ~= 0 and requestId == self.vesselBudgetLevelUpRequestId then
		self.vesselBudgetLevelUpRequestId = 0
		self:UpdateWaitEquipmentEffect()
	end

end


--
function UI.EquipmentWnd:MasterServer_OnVesselBudgetChanged( vid )

	if not self:IsOnScreen() then
		return
	end

	if not self.selShipItem or self.selShipItem.vid ~= vid then
		return
	end

	if self:IsItemsPanelVisible() then
		self.itemsListWnd:OnVesselBudgetChanged()
	end

	if UI.BuyBundleWnd:IsOnScreen() and UI.BuyBundleWnd:GetMainWndName() == self:GetScriptTableName() then

		local isParts		= UI:GetShipSpecModuleParts( self.selShipItem )
		local unlockedLevel	= UI:GetShipUnlockedSpecModuleLevel( self.selShipItem )
		local nextlevel		= unlockedLevel == -1 and 1 or unlockedLevel + 1
		local needParts		= UI:GetShipSpecModuleLevelCost( self.selShipItem.defName, nextlevel )

		if isParts >= needParts then
			UI.BuyBundleWnd:Hide()
		end

	end

end


--
function UI.EquipmentWnd:MasterServer_OnVesselBudgetActivate( result, requestId, param1, param2, u64Param )

	if result == _G.GameStore.StoreBuyResult.SBR_OK then

		if self:IsOnScreen() then

        	if self:IsItemsPanelVisible() then
        		self.itemsListWnd:OnVesselBudgetActivate()
        	end

		end

	else

		if requestId ~= 0 and requestId == self.vesselBudgetActivateRequestId then
			self:ShowMsgOnVesselBudgetActivateError( result )
		end

	end

	if requestId ~= 0 and requestId == self.vesselBudgetActivateRequestId then
		self.vesselBudgetActivateRequestId = 0
		self:UpdateWaitEquipmentEffect()
	end

end


--
function UI.EquipmentWnd:GameStore_OnRecraftVessel( result, requestId, param1, param2, u64Param )

	if result == _G.GameStore.StoreBuyResult.SBR_OK then
		-- апдейт происходит в self:OnHangarSelShipChanged(), которая вызывается и ангара
	else
		if requestId == self.recraftVesselRequestId then
			self:ShowMsgOnRecraftVesselError( result )
		end
	end

	if requestId == self.recraftVesselRequestId then
		self.recraftVesselRequestId = 0
		self:UpdateWaitEquipmentEffect()
	end

end


--
function UI.EquipmentWnd:OnBuyBundleWndResult( result, defName, data )
end


--
function UI.EquipmentWnd:OnBuyWithInventoryWndResult( result, data )

	if result == true then
		self:BuyInventory( data.inventoryLevels )
	else
		self:ResetBuyInfo()
	end

end


--
function UI.EquipmentWnd:OnUpgradeItemWndResult( result, iid, vid, equipSlot, customData )

	if not self:IsOnScreen() then
		sys.log( "UI.EquipmentWnd:OnUpgradeItemWndResult()[ERROR]: not on screen" )
		return
	end

	if result == false then
		return
	end

	-- вау-эффект апгрейда на иконке модуля

	if customData.bInShipSlot then
		-- на слоте корабля
		self:ShowUpgradeItemWowEffect( { iid } )

	else
		-- на конке в списке
		if self.itemsListWnd:IsOnScreen() then
			self.itemsListWnd:ShowUpgradeItemWowEffect( iid )
		end
	end

end


--
function UI.EquipmentWnd:ShowUpgradeItemWowEffect( iids )

	if not self:IsOnScreen() then
		return
	end
	
	if type( iids ) ~= "table" then
		sys.log( "UI.EquipmentWnd:ShowUpgradeItemWowEffect[ERROR]: invalid type of the 1-st param (\"iids\"); \"table\" expected, got \"%s\"", type( iids ) )
		return
	end
	
	for idx, iid in pairs( iids ) do
		if type( idx ) ~= "number" or type( iid ) ~= "userdata" then
			sys.log( "UI.EquipmentWnd:ShowUpgradeItemWowEffect()[ERROR]: invalid format od table \"iids\"; <number>=<userdata> expected, got <%s>=<%s>", type( idx ), type( iid ) )
			return
		end
	end

	for itemIdx, iid in pairs( iids ) do
	
		local bSlotFound = false

		for slotId, slotWnd in pairs( self.shipSlots ) do
		
			if UI:IsWndKindOf( slotWnd, "Equipment_ModuleShipSlotWnd" ) and slotWnd:GetItemId() == iid then
				
				slotWnd:GetParent():MoveChildToLastPosition( slotWnd )	-- вау-эффект залазит на соседние слоты, надо чтобы он рисовался над ними, а не под
				slotWnd:ShowUpgradeItemWowEffect()
				
				bSlotFound = true
				break
				
			end
			
		end
		
		if not bSlotFound then
			sys.log( "UI.EquipmentWnd:ShowUpgradeItemWowEffect()[ERROR]: slot for iid %s not found", _G.U64ToStr( iid ) )
		end
		
	end

end


--
function UI.EquipmentWnd:ShowModule( iid )

	if not self:IsOnScreen() then
		sys.log( "UI.EquipmentWnd:ShowModule()[ERROR]: not on screen" )
		return
	end

	if type( iid ) ~= "userdata" then
		sys.log( "UI.EquipmentWnd:ShowModule()[ERROR]: invalid type of the 1-st parameter (\"iid\"); \"userdata\" expected, got \"%s\"", type( iid ) )
		return
	end

	local shipItem, slotId = UI:GetEquippedShipItemAndSlot( iid )

	if not( self.selShipItem and shipItem and self.selShipItem.vid == shipItem.vid ) then
		sys.log( "UI.EquipmentWnd:ShowModule()[ERROR]: module is not equipped on this ship" )
		return
	end

	local slotWnd = self:GetShipSlotForModuleId( slotId ) 

	if not slotWnd then
		sys.log( "UI.EquipmentWnd:ShowModule()[ERROR]: cannot find ship slot" )
		return
	end

	if self:CanShipSlotBeSelected( slotWnd ) then
		self:SelectShipSlot( slotWnd )
	else
		sys.log( "UI.EquipmentWnd:ShowModule()[ERROR]: cannot select ship slot right now" )
		return
	end


	local bSuccess = false

	if UI.Equipment_ItemsListWnd:IsOnScreen() then

    	for recordIdx = 1, UI.Equipment_ItemsListWnd:GetNumRecords() do

    		local data = UI.Equipment_ItemsListWnd:GetRecordData( recordIdx )

        	local item = data.item
        	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
        		item = item.subItemToShow
        	end

			if item.itemType == UI.EquipmentWnd.itemTypes.INVENTORY then
				if item.inventoryItems then
					for idx, item in pairs( item.inventoryItems ) do
						if item.iid == iid then

							UI.Equipment_ItemsListWnd:SetScrollPos( recordIdx )
							bSuccess = true
							break

						end
					end
				end
			end

		end		

	end

	if not bSuccess then
		sys.log( "UI.EquipmentWnd:ShowModule()[ERROR]: fail to show module" )
	end

end


--
function UI.EquipmentWnd:GameStore_OnExtractVesselExp( result, requestId, vids )

	UI.EquipmentShipUpgradeWnd:GameStore_OnExtractVesselExp( result, requestId, vids )

end


--
function UI.EquipmentWnd:GameStore_OnVesselUnlockNode( result, requestId, param1, param2, u64Param )

	UI.EquipmentShipUpgradeWnd:GameStore_OnVesselUnlockNode( result, requestId, param1, param2, u64Param )

end


--
function UI.EquipmentWnd:GameStore_OnVesselLevelUp( result, requestId, param1, param2 )

	UI.EquipmentShipUpgradeWnd:GameStore_OnVesselLevelUp( result, requestId, param1, param2 )
	
	if self:IsOnScreen() then
	
		local vid = u64( param1, param2 )
		if self.selShipItem and self.selShipItem.vid == vid then
			
			if UI.EquipmentShipInfoWnd:IsChildOf( self ) then
				UI.EquipmentShipInfoWnd:OnVesselLevelUp()
			end
			
			if UI.EquipmentShipMainParamsWnd:IsChildOf( self ) then
				UI.EquipmentShipMainParamsWnd:OnVesselLevelUp()
			end
			
			if UI.EquipmentShipSurvivabilityWnd:IsChildOf( self ) then
				UI.EquipmentShipSurvivabilityWnd:OnVesselLevelUp()
			end
			
			if UI.EquipmentShipParamsWnd:IsChildOf( self ) then
				UI.EquipmentShipParamsWnd:OnVesselLevelUp()
			end
			
		end
			
	end

end


--
function UI.EquipmentWnd:MasterServer_OnCraftResources( result, requestId, param1, param2 )

	UI.EquipmentShipUpgradeWnd:MasterServer_OnCraftResources( result, requestId, param1, param2 )

end


--
function UI.EquipmentWnd:MasterServer_OnUseCraftResource( result, requestId, param1, param2 )

	UI.EquipmentShipUpgradeWnd:MasterServer_OnUseCraftResource( result, requestId, param1, param2 )

end


--
function UI.EquipmentWnd:MasterServer_OnSellCraftResource( result, requestId, param1, param2 )

	UI.EquipmentShipUpgradeWnd:MasterServer_OnSellCraftResource( result, requestId, param1, param2 )

end


--
function UI.EquipmentWnd:MasterServer_OnSellCraftResources( result, requestId, param1, param2 )

	UI.EquipmentShipUpgradeWnd:MasterServer_OnSellCraftResources( result, requestId, param1, param2 )

end


--
function UI.EquipmentWnd:GameStore_OnCraftUpgradeItem( result, requestId, param1, param2 )

	UI.EquipmentShipUpgradeWnd:GameStore_OnCraftUpgradeItem( result, requestId, param1, param2 )

end


--
function UI.EquipmentWnd:MasterServer_OnLearnBlueprints( result, requestId, defName )

	UI.EquipmentShipUpgradeWnd:MasterServer_OnLearnBlueprints( result, requestId, defName )

end


--
function UI.EquipmentWnd:MasterServer_OnAdvertCreate( result, requestId, param1, param2, u64Param )

	UI.EquipmentShipUpgradeWnd:MasterServer_OnAdvertCreate( result, requestId, param1, param2, u64Param )
	
end


--
function UI.EquipmentWnd:MasterServer_OnAdvertDelete( result, requestId, param1, param2, u64Param )

	UI.EquipmentShipUpgradeWnd:MasterServer_OnAdvertDelete( result, requestId, param1, param2, u64Param )	
	
end


--
function UI.EquipmentWnd:MasterServer_OnAdvertExpired( result, requestId, param1, param2, u64Param )

	UI.EquipmentShipUpgradeWnd:MasterServer_OnAdvertExpired( result, requestId, param1, param2, u64Param )
	
end


--
function UI.EquipmentWnd:MasterServer_OnQuests( result, requestId, param1, param2 )

	UI.EquipmentShipUpgradeWnd:MasterServer_OnQuests( result, requestId, param1, param2 )

end


--
function UI.EquipmentWnd:MasterServer_OnAcceptQuest( result, requestId, param1, param2 )

	UI.EquipmentShipUpgradeWnd:MasterServer_OnAcceptQuest( result, requestId, param1, param2 )

end


--
function UI.EquipmentWnd:MasterServer_OnCompleteQuest( result, requestId, param1, param2 )

	UI.EquipmentShipUpgradeWnd:MasterServer_OnCompleteQuest( result, requestId, param1, param2 )

end


--
function UI.EquipmentWnd:MasterServer_OnChangeQuest( result, requestId, param1, param2 )

	UI.EquipmentShipUpgradeWnd:MasterServer_OnChangeQuest( result, requestId, param1, param2 )

end


--
function UI.EquipmentWnd:ShipPreset_OnSaveCurrentToPreset( vid, presetId )

	UI.ShipPresetsWnd:ShipPreset_OnSaveCurrentToPreset( vid, presetId )
	
end


--
function UI.EquipmentWnd:ShipPreset_OnAddPreset( vid, id )

	UI.ShipPresetsWnd:ShipPreset_OnAddPreset( vid, id )
	
end


--
function UI.EquipmentWnd:ShipPreset_OnRemovePreset( shipDefName, presetId )

	UI.ShipPresetsWnd:ShipPreset_OnRemovePreset( shipDefName, presetId )
	
end


--
function UI.EquipmentWnd:ShipPreset_OnSetSelPreset( shipDefName, presetId )

	UI.ShipPresetsWnd:ShipPreset_OnSetSelPreset( shipDefName, presetId )
	
end


--
function UI.EquipmentWnd:GameStore_OnChangeEquipmentMulti( result, requestId, param1, param2, u64Param )

	UI.ShipPresetsWnd:GameStore_OnChangeEquipmentMulti( result, requestId, param1, param2, u64Param )
	
end


--
function UI.EquipmentWnd:OnAutogenUnequipWnd( items, cancelMode, customData )

	if not self:IsOnScreen() then
		return
	end

	-- проверяем, что всё, что нужно было снять, было снято
	if cancelMode == UI.AutogenUnequipWnd.cancelModes.BREAK then
	
		local bAllUnequipped = true
		for itemIdx, item in pairs( items ) do
			if not( item.result == UI.AutogenUnequipWnd.itemResults.DESTROYED or item.result == UI.AutogenUnequipWnd.itemResults.DISMANTLED ) then
				bAllUnequipped = false
				break
			end
		end
		
		if not bAllUnequipped then
			return
		end
		
	end
	
	-- вызываем снова ту же функцию и с теми же параметрами, которую пытались вызвать до показа окна снятия автогена
	if customData.fnName and customData.fnName ~= "" then
		self[ customData.fnName ]( self, unpack( customData.params ) )
	end

end


--
function UI.EquipmentWnd:GetShipParamsBottom()

	local btm = self:GetHeight()

	local autogenEffect = UI:GetEffectFromLayer( self, self.layers.SHIP_SLOTS_AUTOGEN_EFFECT )
	if autogenEffect then
		btm = autogenEffect:GetPos().y - self.SPACE_SHIP_PARAMS_AUTOGEN
	end
	
	return btm

end


-- в экранных координатах
function UI.EquipmentWnd:GetPassiveShipSlotsLeft()

	local x = 1024

	--[[
	local groupEffect = UI:GetEffectFromLayer( self, self.layers.SHIP_SLOTS_PASSIVE_ENGINE_MOD_EFFECT )
	if groupEffect then
		x = groupEffect:GetObjPos( string.format( "%s%d", self.effectInfo.passiveGroup.slotLocatorPrefix, 3 ) ).x
		x = x + groupEffect:GetScreenPos().x
	end
	]]
	
	local groupEffect = UI:GetEffectFromLayer( self, self.layers.SHIP_SLOTS_PASSIVE_EFFECT )
	if groupEffect then
		x = groupEffect:GetScreenPos().x
	end
	
	return x

end


--
function UI.EquipmentWnd:GameStore_OnVesselActivateNode( result, requestId, param1, param2, u64Param )

	if result ~= _G.GameStore.StoreBuyResult.SBR_OK then
		return
	end

    if not self:IsOnScreen() then
		return
	end
	
	local vid = u64Param
	
	if self.selShipItem and u64Param.vid == vid then
		UI.EquipmentShipInfoWnd:GameStore_OnVesselActivateNode( result, requestId, param1, param2, u64Param )
	end

end


--
function UI.EquipmentWnd:GameStore_OnAutogenDestroy( result, requestId, params )

	-- здесь только показ сообщения оьб ошибке, апдейт будет в F_OnEventInvItemsChanged()
	
	if requestId == self.autogenDestroyRequestId then

		if result ~= _G.GameStore.ModuleEquipResult.MER_OK then
			self:ShowMsgOnAutogenDestroyError( result )
		end
		
		self.autogenDestroyRequestId = 0
		self:UpdateWaitEquipmentEffect()
		
	end

end


-- ------------------------------
-- const
-- ------------------------------

ew.effectInfo =
{
	shipSlots =
	{
		layoutByType =
		{
			[ UI.shipSlotTypes.WEAPON ]			= { effectLayer = ew.layers.SHIP_SLOTS_EFFECT,			locator = "weap_module" },
			[ UI.shipSlotTypes.AMMO_PRIMARY ]	= { effectLayer = ew.layers.SHIP_SLOTS_EFFECT,			locator = "ammo_module" },
			[ UI.shipSlotTypes.AMMO_SECONDARY ]	= { effectLayer = ew.layers.SHIP_SLOTS_EFFECT,			locator = "rocket_module" },
			[ UI.shipSlotTypes.SPECIAL ]		= { effectLayer = ew.layers.SHIP_SLOTS_EFFECT,			locator = "sp_icon" },
			[ UI.shipSlotTypes.ACTIVE ]			= { effectLayer = ew.layers.SHIP_SLOTS_ACTIVE_EFFECT,	locator = "active_module_" },
		},
	},
	
	passive =
	{
		groupLocatorPrefix = "slots_line_"
	},
	
	passiveGroup =
	{
		slotLocatorPrefix = "pas_slot_"
	},
	
	autogen =
	{
		slotLocatorPrefix = "aren_slot_"
	}
}

ew.DD_MOUSE_THRESHOLD	= 5	-- в пределах смещения мыши на это расстояние drag_and_drop не начинается

ew.ddStates =
{
	NONE		= 1,
	WAIT_MOUSE	= 2,
	DRAG		= 3,
}

ew.itemTypes =
{
	SHOP		= 1,
	INVENTORY	= 2,
	SUB_TYPE	= 3,
	SPEC_MODULE	= 4,
}

ew.sounds =
{
	shipSlotSelect						= "sound/ui/btnClick",
	ddStart								= "",
	ddStop								= "",
	equip								= "sound/ui/moduleEquip",
	unequip								= "sound/ui/cancel",
	cannotEquip							= UI.sounds.invalid,
	tradeWndShow						= "sound/ui/btnClick",
	cannotSelectShipSlot				= UI.sounds.invalid,
	openSubType							= UI.sounds.btnClick,
	hideItemsList						= "sound/ui/MsgHide",
	salvage								= "sound/ui/lootScanSuccess",	-- TODO: звук
	unlockSpecModule					= "sound/ui/apply",
	setSpecModulePartsCollectingShip	= UI.sounds.btnClick,
	tradeWndHide						= "sound/ui/MsgHide",
	buyBundle							= UI.sounds.btnClick,
}

ew.shipSlotType2ModuleType =
{
	[ UI.shipSlotTypes.WEAPON ]			= { "PRIMARY_WEAPON_01" },
	[ UI.shipSlotTypes.ACTIVE ]			= { "ACTIVE_01", "ACTIVE_02","ACTIVE_03", "ACTIVE_04" },
	[ UI.shipSlotTypes.ARMOR_MOD ]		= { "ARMOR_MOD_01", "ARMOR_MOD_02", "ARMOR_MOD_03" },
	[ UI.shipSlotTypes.SHIELD_MOD ]		= { "SHIELD_MOD_01", "SHIELD_MOD_02", "SHIELD_MOD_03" },
	[ UI.shipSlotTypes.CAPACITOR_MOD ]	= { "CAPACITOR_MOD_01", "CAPACITOR_MOD_02","CAPACITOR_MOD_03" },
	[ UI.shipSlotTypes.ENGINE_MOD]		= { "ENGINE_MOD_01", "ENGINE_MOD_02", "ENGINE_MOD_03" },
	[ UI.shipSlotTypes.CPU_MOD ]		= { "CPU_MOD_01", "CPU_MOD_02", "CPU_MOD_03" },
	[ UI.shipSlotTypes.SPECIAL ]		= { "SPECIAL" },
	[ UI.shipSlotTypes.AUTOGEN ]		= { "AUTOGEN_01", "AUTOGEN_02", "AUTOGEN_03", "AUTOGEN_04", "AUTOGEN_05" },
}

ew.shipSlotType2AmmoType =
{
	[ UI.shipSlotTypes.AMMO_PRIMARY ]	= "MBT_PRIMARY",
	[ UI.shipSlotTypes.AMMO_SECONDARY ]	= "MBT_SECONDARY",
}

ew.passsiveShipSlotTypes =
{
	UI.shipSlotTypes.ENGINE_MOD,
	UI.shipSlotTypes.CAPACITOR_MOD, 
	UI.shipSlotTypes.SHIELD_MOD,
	UI.shipSlotTypes.ARMOR_MOD,
	UI.shipSlotTypes.CPU_MOD,
}

ew.sortModes =
{
	ASC		= 1,
	DESC	= 2,
}

ew.DEFAULT_SORT_MODE = ew.sortModes.DESC	-- #0065534,комм.(0269650)

ew.SPACE_SHIP_PARAMS_AUTOGEN = UI:YTo1024x768( 10 )

-- ------------------------------
-- vars
-- ------------------------------

ew.shipSlots					= {}
ew.bLockItemsUpdate				= false
ew.hMsgTimeOut					= UI.INVALID_UI_HANDLE
ew.hMsgRemoveItemFromOtherShip	= UI.INVALID_UI_HANDLE
ew.hMsgUneqipAmmo				= UI.INVALID_UI_HANDLE
ew.ddInfo =
{
	ddState		= ew.ddStates.NONE,
	shipSlot	= nil,
	mouseX_abs	= 0,
	mouseY_abs	= 0,
}
ew.ddIco								= nil
ew.ddMouseThreshold_abs					= 0
ew.ddAcceptShipSlot						= nil
ew.selShipItem							= nil
ew.selShipEntId							= -1
ew.itemForQuickEquip					= nil
ew.popMenuDataToEquip					= nil
ew.selShipSlot							= nil
ew.buyInfo								= {}
ew.itemsListWnd							= nil
ew.requestId_buyInventory				= 0
ew.buyRequestId							= 0
ew.sortMode								= -1
ew.treeItems							= {}
ew.equipTransferInfo					= nil
ew.savedItemsUpLevelLayout				= nil
ew.wndUnderLastMouseDown				= nil
ew.vesselBudgetActivateRequestId		= 0
ew.vesselBudgetLevelUpRequestId			= 0
ew.recraftVesselRequestId				= 0
ew.hMsgSetSpecModulePartsCollectingShip	= UI.INVALID_UI_HANDLE
ew.bLockBuyBundleHide					= false
ew.bLockAutogenUnequipHide				= false
ew.autogenLabelMetaText					= nil
ew.autogenDestroyRequestId				= 0
ew.autogenIidToDestroy					= nil
ew.hMsgAutogenDestroy					= UI.INVALID_UI_HANDLE
ew.hMsgAutogenEquipConfirm				= UI.INVALID_UI_HANDLE
ew.moduleToEquipData					= nil

-- ------------------------------
-- work functions
-- ------------------------------

--
function UI.EquipmentWnd:F_PostLoad()

	UI.FullScreenSelectionWnd.F_PostLoad( self )

	UI.Equipment_DDIco:UnlinkFromParent()
	self.ddIco = UI.Equipment_DDIco

	self.itemsListWnd = UI.Equipment_ItemsListWnd
	
	self.autogenLabelMetaText = UI.MetaText.GetNewInstance()
	self.autogenLabelMetaText:InitFromLayer( self, self.layers.SHIP_SLOTS_LABEL_AUTOGEN ) 

	self:ResetBuyInfo()

	local handle = self:GetUiHandle()
    UI:SubscribeUiObjOnEvent( handle, UI.EV_MSGBOX_RET )
    UI:SubscribeUiObjOnEvent( handle, UI.EV_INV_ITEMS_CHANGED )
    UI:SubscribeUiObjOnEvent( handle, UI.EV_START_WAITING_REQUESTS )
    UI:SubscribeUiObjOnEvent( handle, UI.EV_STOP_WAITING_REQUESTS )
	UI:SubscribeUiObjOnEvent( handle, UI.EV_LIST_ACTIVATE_RECORD )	

end


--
function UI.EquipmentWnd:F_Shutdown()

	if self.autogenLabelMetaText then
		self.autogenLabelMetaText:Clear()
	end

	UI.Wnd.F_Shutdown( self )

end


--
function UI.EquipmentWnd:F_OnScreenPosChanged( oldScreenX, oldScreenY )

	self:OnScreenPosChanged( oldScreenX, oldScreenY )

	-- может вызываеться при инициализации окна, когда еще слои не созданы
	if self:GetNumLayers() == 0 then
		return
	end

	if self:IsOnScreen() then
		self:UpdateMetaTextPos()
	end

end


--
function UI.EquipmentWnd:UpdateMetaTextPos()

	self.autogenLabelMetaText:UpdateScreenOrgFromLayer( self, self.layers.SHIP_SLOTS_LABEL_AUTOGEN )

end


--
function UI.EquipmentWnd:F_DrawLayer( x0, y0, width, height, clipX0, clipY0, clipWidth, clipHeight, layerIdx )

	if layerIdx == self.layers.SHIP_SLOTS_LABEL_AUTOGEN then
		self.autogenLabelMetaText:Draw( clipX0, clipY0, clipWidth, clipHeight )
	end

end


--
function UI.EquipmentWnd:CreateShipSlots()

	for slotTypeName, slotType in pairs( UI.shipSlotTypes ) do

		local bAmmo = self:IsShipSlotTypeAmmo( slotType )
		local bPassive = self:IsShipSlotTypePassive( slotType )
		
		local proto = nil
		
		if bAmmo then
			proto = UI.Equipment_AmmoShipSlotWnd_new
			
		elseif bPassive then
			proto = UI.Equipment_PassiveModuleShipSlotWnd
		
		elseif slotType == UI.shipSlotTypes.WEAPON then
			proto = UI.Equipment_WeaponShipSlotWnd
		
		elseif slotType == UI.shipSlotTypes.SPECIAL then
			proto = UI.Equipment_SpecModuleShipSlotWnd
		
		elseif slotType == UI.shipSlotTypes.AUTOGEN then
			proto = UI.Equipment_AutogenShipSlotWnd
		
		else
			proto = UI.Equipment_ActiveModuleShipSlotWnd
		end

		for inTypeIdx = 1, self:GetMaxShipSlotsOfType( slotType ) do

			local slotWnd = UI:CreateChildWnd( self, proto, string.format( "%s_%d", slotTypeName, inTypeIdx ) )

			local slotId = bAmmo and self:ShipSlot2AmmoId( slotType, inTypeIdx ) or self:ShipSlot2ModuleId( slotType, inTypeIdx )
			slotWnd:Init( slotType, slotId )

			table.insert( self.shipSlots, slotWnd )

		end

	end

end


--
function UI.EquipmentWnd:IsShipSlotTypeAmmo( slotType )

	return slotType == UI.shipSlotTypes.AMMO_PRIMARY or slotType == UI.shipSlotTypes.AMMO_SECONDARY

end


--
function UI.EquipmentWnd:IsShipSlotTypePassive( slotType )

	return UI:Val2Key( self.passsiveShipSlotTypes, slotType ) ~= ""
	
end


--
function UI.EquipmentWnd:Reset()

	self.bLockItemsUpdate = true
	self:ResetSelShip()
	self:ResetSelShipEnt()
	self:ResetItemsList()
	self.bLockItemsUpdate = false
	self:ResetDD()
	self.itemForQuickEquip = nil
	self.popMenuDataToEquip = nil
	self:ResetBuyInfo()
	self.requestId_buyInventory = 0
	self:SetSortMode( -1 )
	self.equipTransferInfo = nil
	self.savedItemsUpLevelLayout = nil
	self.wndUnderLastMouseDown = nil

end


--
function UI.EquipmentWnd:ResetSelShip()

	self.selShipItem		= nil

	self:ResetShipSlots()
	self:ResetDD()
	self:UpdateItemsPanelVisibility()
	UI.ShipPresetsWnd:UnlinkFromParent()
	
	UI.EquipmentShipInfoWnd:Reset()
	UI.EquipmentShipInfoWnd:UnlinkFromParent()
	
	UI.EquipmentShipMainParamsWnd:Reset()
	UI.EquipmentShipMainParamsWnd:UnlinkFromParent()
	
	UI.EquipmentShipSurvivabilityWnd:Reset()
	UI.EquipmentShipSurvivabilityWnd:UnlinkFromParent()
	
	UI.EquipmentShipParamsWnd:Reset()
	UI.EquipmentShipParamsWnd:UnlinkFromParent()

end


--
function UI.EquipmentWnd:ResetSelShipEnt()

	self.selShipEntId = -1

end


--
function UI.EquipmentWnd:ResetShipSlots()

	for idx, slotWnd in pairs( self.shipSlots ) do
		slotWnd:Reset()
		slotWnd:UnlinkFromParent()
	end

	self:SelectShipSlot( nil )

	for slotTypeName, slotType in pairs( UI.shipSlotTypes ) do
		local labelLayer = self:GetLabelLayerForShipSlotType( slotType )
		if labelLayer ~= -1 then
			self:SetLayerVisible( false, labelLayer )
		end
	end
	
	self.autogenLabelMetaText:SetText( "", true )
	
	self:SetLayerVisible( false, self.layers.SHIP_SLOTS_EFFECT )
	self:SetLayerVisible( false, self.layers.SHIP_SLOTS_AUTOGEN_EFFECT ) 
	self:SetLayerVisible( false, self.layers.SHIP_SLOTS_PASSIVE_EFFECT )
	
	for slotTypeIdx, slotType in pairs( self.passsiveShipSlotTypes ) do
		local layer = self:GetPassiveGroupLayerForShipSlotType( slotType )
		if layer ~= -1 then
			self:SetLayerVisible( false, layer )
		end
	end

end


--
function UI.EquipmentWnd:FullUpdate()

	self:Reset()

	self.bLockItemsUpdate = true

	self:ValidateSortMode()
	self:UpdateSelShip()
	self:UpdateSelShipEnt()

	self.bLockItemsUpdate = false	
	self:UpdateItems( false )

	self:UpdateWaitEquipmentEffect()
	
	self:UpdateShipPresetsVisibility()

end


--
function UI.EquipmentWnd:UpdateSelShip()

	-- может вызываться, когда vid тот же, но shipItem поменялся (например, при рекрафте корабля)

	local oldSelShipSlot = self.selShipSlot
	local oldVid = self.selShipItem and self.selShipItem.vid or UI.INVALID_U64_ID

	self:ResetSelShip()

	self.selShipItem = UI.HangarWnd:GetSelShipItem()

	self:UpdateShipUpgradeWnd()

	if not self.selShipItem then
		return
	end

	self:UpdateItemsPanelVisibility()

	local bLockItemsUpdate_old = self.bLockItemsUpdate
	self.bLockItemsUpdate = true

	self:UpdateShipSlots()

	if oldVid ~= self.selShipItem.vid then
		oldSelShipSlot = nil
	end
	self:ValidateShipSlotSelection( oldSelShipSlot )

	self.bLockItemsUpdate = bLockItemsUpdate_old

	self:UpdateItems( oldVid == self.selShipItem.vid )
	
	self:UpdateShipPresetsVisibility()
	
	self:AddChild( UI.EquipmentShipInfoWnd )
	UI.EquipmentShipInfoWnd:Setup( self.selShipItem.defName )
	
	self:AddChild( UI.EquipmentShipMainParamsWnd )
	UI.EquipmentShipMainParamsWnd:Setup( self.selShipItem.defName, nil )

	self:AddChild( UI.EquipmentShipSurvivabilityWnd )
	UI.EquipmentShipSurvivabilityWnd:Setup( self.selShipItem.defName, nil )
	
	self:AddChild( UI.EquipmentShipParamsWnd )
	UI.EquipmentShipParamsWnd:Setup( self.selShipItem.defName, nil, false--[[не показывать бонусы]], true--[[скрывать если нет измененных параметров]] )
	
end


--
function UI.EquipmentWnd:UpdateSelShipEnt()

	self:ResetSelShipEnt()

	self.selShipEntId = UI.HangarWnd:GetSelShipEntId()
	if self.selShipEntId == -1 then
		return
	end

end


--
function UI.EquipmentWnd:UpdateShipSlots()

	self:ResetShipSlots()

	if not self.selShipItem then
		return
	end
	
	self:SetLayerVisible( true, self.layers.SHIP_SLOTS_EFFECT )

	-- модули

	local evolvingShipStlosMask = u64( 0 )
	if UI:IsShipEvolving( self.selShipItem.defName ) then
		evolvingShipStlosMask = UI:GetEvolvingShipSlotsMask( self.selShipItem )	-- #0107501 - показываются только разлоченные и активированные слоты
	end

	for slotId = 0, ai.SpaceShipModuleSlot.NUM - 1 do

		local bNeedShowSlot = false

		if UI:IsShipEvolving( self.selShipItem.defName ) then
			bNeedShowSlot = UI:BitTstU64( evolvingShipStlosMask, slotId )
		else
			bNeedShowSlot = UI:HasShipModuleSlot( self.selShipItem, slotId )
	    end

		if bNeedShowSlot then
			self:UpdateModuleShipSlot( slotId )
		end

	end  


	-- аммуниция

	for ammoIdName, ammoId in pairs( ai.MunitionBayType ) do
		if ammoId ~= ai.MunitionBayType.MBT_NUM then
			self:UpdateAmmoShipSlot( ammoId )
		end
	end

	self:LayoutShipSlots()
	self:UpdateShipSlotsControlsVisibility()

end


--
function UI.EquipmentWnd:UpdateModuleShipSlot( moduleId )

	local slotWnd = self:GetShipSlotForModuleId( moduleId )
	if not slotWnd then
		return
	end

	local itemId		= UI.INVALID_U64_ID
	local itemDefName	= ""

	if moduleId == ai.SpaceShipModuleSlot.SPECIAL then

		itemDefName = UI:GetShipSpecModule( self.selShipItem )

	else

    	itemId = self.selShipItem.equipModules[ moduleId ] or UI.INVALID_U64_ID

    	local moduleItem = nil
    	if itemId ~= UI.INVALID_U64_ID then
    		moduleItem = UI:GetInventoryItemEx( itemId )
    	end

    	itemDefName = moduleItem and moduleItem.defName or ""

	end


	local activeState	= UI.Equipment_ShipSlotWnd.activeStates.ACTIVE
	local nodeName		= ""

	if UI:IsShipEvolving( self.selShipItem.defName ) then

		nodeName = UI:GetEvolvingShipNodeForShipSlot( self.selShipItem.defName, moduleId )

		if nodeName ~= "" then

			if not UI:IsEvolvingShipNodeUnlocked( nodeName, self.selShipItem.vid ) then
				activeState	= UI.Equipment_ShipSlotWnd.activeStates.LOCKED_FOR_NOT_LEARNED_NODE

			elseif not UI:IsEvolvingShipNodeActive( nodeName, self.selShipItem.vid ) then
				activeState	= UI.Equipment_ShipSlotWnd.activeStates.LOCKED_FOR_INACTIVE_NODE
			end

		end

	end

	self:AddChild( slotWnd )
	slotWnd:Setup( activeState, nodeName )

	if itemDefName ~= "" then
		slotWnd:SetItem( itemId, itemDefName )
	end

end


--
function UI.EquipmentWnd:UpdateAmmoShipSlot( ammoId )

	local slotWnd = self:GetShipSlotForAmmoId( ammoId )
	if not slotWnd then
		sys.log( "UI.EquipmentWnd:UpdateAmmoShipSlot()[ERROR]: cannot find ship slot for ammunition type %s", tostring( ammoId ) )
		return
	end

    local ammoInfo = self.selShipItem.equipAmmo[ ammoId ]
	local itemDefName = ammoInfo and ammoInfo.def or ""

	-- Аммуниция для основного оружия должна соответствовать текущему установленному оружию, поэтому если оружия нет, то слот аммуниции для него неактивен.
	-- Исключение - если в слоте уже почему-то стоит неподходящая аммуниция; в этом случае слот не блокируется, чтобы эту аммуницию можно было оттуда снять.

	local slotActiveState = UI.Equipment_ShipSlotWnd.activeStates.ACTIVE

	if ammoId == ai.MunitionBayType.MBT_PRIMARY then

		local curWeaponClass = self:GetCurWeaponClass()
		if curWeaponClass == ai.WeaponClass.UNKNOWN then

			if itemDefName == "" then
				slotActiveState = UI.Equipment_ShipSlotWnd.activeStates.LOCKED_FOR_WEAPON
			else
				sys.log( "UI.EquipmentWnd:UpdateAmmoShipSlot()[ERROR]: primary ammo slot is filled with ammo unfit for cur weapon" )
			end

		else

			if itemDefName ~= "" then
				local itemWeaponClass = UI:GetWeaponClass( itemDefName )
				if itemWeaponClass ~= curWeaponClass then
					sys.log( "UI.EquipmentWnd:UpdateAmmoShipSlot()[ERROR]: primary ammo slot is filled with ammo unfit for cur weapon" )
				end 
			end

		end


		local curWeaponAmmoSubType = self:GetCurWeaponAmmoSubType()
		if curWeaponAmmoSubType == -1 then

			if itemDefName == "" then
				slotActiveState = UI.Equipment_ShipSlotWnd.activeStates.LOCKED_FOR_WEAPON
			else
				sys.log( "UI.EquipmentWnd:UpdateAmmoShipSlot()[ERROR]: primary ammo slot is filled with ammo unfit for cur weapon" )
			end

		-- если 0 - значит этот параметр не используется для данного оружия
		elseif curWeaponAmmoSubType ~= 0 then

			if itemDefName ~= "" then
				local itemSubType = UI:GetItemSubType( itemDefName )
				if itemSubType ~= curWeaponAmmoSubType then
					sys.log( "UI.EquipmentWnd:UpdateAmmoShipSlot()[ERROR]: primary ammo slot is filled with ammo unfit for cur weapon" )
				end 
			end

		end

	end

	self:AddChild( slotWnd )
	slotWnd:Setup( slotActiveState )

	if itemDefName ~= "" then
		slotWnd:SetItem( itemDefName, ammoInfo.amount or 0 )
	end

end


--
function UI.EquipmentWnd:GetShipSlotForModuleId( moduleId )

	for idx, shipSlot in pairs( self.shipSlots ) do
		if not self:IsShipSlotTypeAmmo( shipSlot:GetShipSlotType() ) and shipSlot:GetSlotId() == moduleId then
			return shipSlot
		end
	end

	return nil

end


--
function UI.EquipmentWnd:GetShipSlotForAmmoId( ammoId )

	for idx, shipSlot in pairs( self.shipSlots ) do
		if self:IsShipSlotTypeAmmo( shipSlot:GetShipSlotType() ) and shipSlot:GetSlotId() == ammoId then
			return shipSlot
		end
	end

	return nil

end


--
function UI.EquipmentWnd:ShipSlot2ModuleId( shipSlotType, slotIdx )

	local moduleId = -1	

	local moduleTypes = self.shipSlotType2ModuleType[ shipSlotType ]
	if moduleTypes then

		local moduleIdName = moduleTypes[ slotIdx ]

		if moduleIdName then

			moduleId = ai.SpaceShipModuleSlot[ moduleIdName ]
			if not moduleId then
				sys.log( "UI.EquipmentWnd:ShipSlot2ModuleId()[ERROR]: invalid module slot name: %s", moduleIdName )
				moduleId = -1
			end

		else
			sys.log( "UI.EquipmentWnd:ShipSlot2ModuleId()[ERROR]: cannot find UI.EquipmentWnd.shipSlotType2ModuleType[%d][%s]", shipSlotType, tostring( slotIdx ) )
		end

	else
		sys.log( "UI.EquipmentWnd:ShipSlot2ModuleId()[ERROR]: cannot find UI.EquipmentWnd.shipSlotType2ModuleType[%s]", tostring( shipSlotType ) )
	end

	return moduleId

end


--
function UI.EquipmentWnd:ShipSlot2AmmoId( shipSlotType, slotIdx )

	local ammoId = -1

	local ammoIdName = self.shipSlotType2AmmoType[ shipSlotType ]
	if ammoIdName then

		ammoId = ai.MunitionBayType[ ammoIdName ]
		if not ammoId then
			sys.log( "UI.EquipmentWnd:ShipSlot2AmmoId()[ERROR]: invalid ammo name: %s", ammoIdName )
			ammoId = -1
		end

	else
		sys.log( "UI.EquipmentWnd:ShipSlot2AmmoId()[ERROR]: cannot find UI.EquipmentWnd.shipSlotType2AmmoType[%s]", tostring( shipSlotType ) )
	end

	return ammoId

end


--
function UI.EquipmentWnd:GetMaxShipSlotsOfType( shipSlotType )

	if self:IsShipSlotTypeAmmo( shipSlotType ) then
		return 1

	else
		local moduleTypes = self.shipSlotType2ModuleType[ shipSlotType ]

		if moduleTypes then
			return #moduleTypes
		else
			sys.log( "UI.EquipmentWnd:GetMaxShipSlotsOfType()[ERROR]: cannot find UI.EquipmentWnd.shipSlotType2ModuleType[%s]", tostring( shipSlotType ) )
			return 0
		end
	end	

end


--
function UI.EquipmentWnd:LayoutShipSlots()

	self:LayoutSlotsDefault( UI.shipSlotTypes.WEAPON )
	self:LayoutSlotsDefault( UI.shipSlotTypes.AMMO_PRIMARY )
	self:LayoutSlotsDefault( UI.shipSlotTypes.AMMO_SECONDARY )
	self:LayoutSlotsDefault( UI.shipSlotTypes.SPECIAL )

	self:LayoutActiveShipSlots()
	self:LayoutPassiveShipSlots()
	self:LayoutAutogenShipSlots()

end


--
function UI.EquipmentWnd:LayoutSlotsDefault( shipSlotType )

	local maxSlots = self:GetMaxShipSlotsOfType( shipSlotType )
	local bAmmo = self:IsShipSlotTypeAmmo( shipSlotType )

	for inTypeIdx = 1, maxSlots do

		local slotId = bAmmo and self:ShipSlot2AmmoId( shipSlotType, inTypeIdx ) or self:ShipSlot2ModuleId( shipSlotType, inTypeIdx )
		local slotWnd = bAmmo and self:GetShipSlotForAmmoId( slotId ) or self:GetShipSlotForModuleId( slotId ) 

		if slotWnd and slotWnd:IsVisible( self ) then

    		local layoutInfo = self.effectInfo.shipSlots.layoutByType[ shipSlotType ]
    		if layoutInfo then

    			local effect = UI:GetEffectFromLayer( self, layoutInfo.effectLayer )
    			if effect then

    				local locator = maxSlots > 1 and string.format( "%s%d", layoutInfo.locator, idx ) or layoutInfo.locator
    				effect:LinkWnd( slotWnd:GetUiHandle(), locator, UI.EffectAnimParams.POS )

    			end		

    		else
    			sys.log( "UI.EquipmentWnd:LayoutSlotsDefault()[ERROR]: cannot find UI.EquipmentWnd.effectInfo.shipSlots.layoutByType[%s]", tostring( shipSlotType ) )
    		end

		end

	end

end


-- Активные слоты рисуются посредине между спецмодулем и бустерами;
-- при этом слот спепцмодуля может быть разной ширины
function UI.EquipmentWnd:LayoutActiveShipSlots()

	local activeSlots = {}
	for idx, slotWnd in ipairs( self.shipSlots ) do
		if slotWnd:GetShipSlotType() == UI.shipSlotTypes.ACTIVE and slotWnd:IsVisible() then
			table.insert( activeSlots, slotWnd )
		end
	end

	if not next( activeSlots ) then
		return
	end

	local numActiveSlots		= #activeSlots
	local activeSlotWidth		= activeSlots[ 1 ]:GetWidth() or 0
	local activeSlotsLayoutInfo	= self.effectInfo.shipSlots.layoutByType[ UI.shipSlotTypes.ACTIVE ]
	local activeSlotsEffect		= UI:GetEffectFromLayer( self, activeSlotsLayoutInfo.effectLayer )
	local activeSlotsEffectPos	= activeSlotsEffect and activeSlotsEffect:GetPos() or Vec2( 0, 0 )
	local activeSlotsEffectSize	= activeSlotsEffect and activeSlotsEffect:GetObjSize( "self" ) or Vec2( 0, 0 )
	local firstActiveSlotPos 	= activeSlotsEffect and activeSlotsEffect:GetObjPos( string.format( "%s%d", activeSlotsLayoutInfo.locator, 1 ) ) or Vec2( 0, 0 )
	local secondActiveSlotPos	= activeSlotsEffect and activeSlotsEffect:GetObjPos( string.format( "%s%d", activeSlotsLayoutInfo.locator, 2 ) ) or Vec2( 0, 0 )
	local activeSlotsSpace		= secondActiveSlotPos.x - ( firstActiveSlotPos.x + activeSlotWidth )

	local activeSlotsWidth		= activeSlotWidth * numActiveSlots + activeSlotsSpace * ( numActiveSlots - 1 )
	local activeSlotsCenter		= activeSlotsEffectPos.x + activeSlotsEffectSize.x / 2
	
	local x	= activeSlotsCenter - activeSlotsWidth / 2
	local y	= firstActiveSlotPos.y + activeSlotsEffectPos.y

	for idx = 1, numActiveSlots do	

		local slotWnd = activeSlots[ idx ]

		slotWnd:SetLeft( x )				
		slotWnd:SetTop( y )

		x = x + activeSlotWidth + activeSlotsSpace

	end

end


--
function UI.EquipmentWnd:LayoutPassiveShipSlots()

	local passiveEffect = UI:GetEffectFromLayer( self, self.layers.SHIP_SLOTS_PASSIVE_EFFECT )
	if not passiveEffect then
		return
	end
	
	local handle = self:GetUiHandle()
	
	local existGroups = {}
	for groupIdx, slotType in ipairs( self.passsiveShipSlotTypes ) do
		if self:HasShipSlotsOfType( slotType ) then
			table.insert( existGroups, slotType )
		end
	end
	
	local numGroupsTotal = #self.passsiveShipSlotTypes
	local numGroupsExist = #existGroups
	
	local groupPrefix = self.effectInfo.passive.groupLocatorPrefix

	-- center the existing groups: shift by half the missing groups instead of all of them
	local groupShift = ( numGroupsTotal - numGroupsExist ) / 2

	for groupIdx, slotType in ipairs( existGroups ) do

			local groupLayer = self:GetPassiveGroupLayerForShipSlotType( slotType )
			passiveEffect:UnlinkLayer( handle, groupLayer, "" )

			local locPos = groupIdx + groupShift
			local locIdx = math.floor( locPos )

			if locPos == locIdx then
					-- lands on a real locator
					passiveEffect:LinkLayer( handle, groupLayer, string.format( "%s%d", groupPrefix, locIdx ), UI.EffectAnimParams.POS )
			else
					-- halfway between two locators
					local groupEffectToMove = UI:GetEffectFromLayer( self, groupLayer )
					if groupEffectToMove then
							local a   = passiveEffect:GetObjPos( string.format( "%s%d", groupPrefix, locIdx ) )
							local b   = passiveEffect:GetObjPos( string.format( "%s%d", groupPrefix, locIdx + 1 ) )
							local org = passiveEffect:GetPos()
							groupEffectToMove:SetPos( UI:Vec2( org.x + ( a.x + b.x ) / 2, org.y + ( a.y + b.y ) / 2 ) )
					end
			end
		
		local groupEffect = UI:GetEffectFromLayer( self, groupLayer )
		if groupEffect then
			
			local numSlotsInGroupTotal = self:GetMaxShipSlotsOfType( slotType )
			
			local slotWnds = {}
			for slotIdx = 1, numSlotsInGroupTotal do
			
				local moduleId = self:ShipSlot2ModuleId( slotType, slotIdx )
				local slotWnd = self:GetShipSlotForModuleId( moduleId )
				
				if slotWnd and slotWnd:IsVisible() then
					table.insert( slotWnds, slotWnd )
				end
				
			end
			
			local numSlotsInGroupExist = #slotWnds
			
			local numSlotsInGroupExist = #slotWnds
                        local prefix = self.effectInfo.passiveGroup.slotLocatorPrefix

                        -- center the used slots within the bank: 1 -> {2}, 2 -> {1.5, 2.5}, 3 -> {1, 2, 3}
                        local shift = ( numSlotsInGroupTotal - numSlotsInGroupExist ) / 2

                        for slotIdx, slotWnd in ipairs( slotWnds ) do

                                local slotHandle = slotWnd:GetUiHandle()
                                groupEffect:UnlinkWnd( slotHandle, "" )

                                local locPos = slotIdx + shift
                                local locIdx = math.floor( locPos )

                                if locPos == locIdx then
                                        -- lands on a real locator
                                        groupEffect:LinkWnd( slotHandle, string.format( "%s%d", prefix, locIdx ), UI.EffectAnimParams.POS )
                                else
                                        -- halfway between two locators
                                        local a   = groupEffect:GetObjPos( string.format( "%s%d", prefix, locIdx ) )
                                        local b   = groupEffect:GetObjPos( string.format( "%s%d", prefix, locIdx + 1 ) )
                                        local org = groupEffect:GetPos()
                                        slotWnd:SetPos( org.x + ( a.x + b.x ) / 2, org.y + ( a.y + b.y ) / 2 )
                                end

                        end
		
		end
	
	end

end


--
function UI.EquipmentWnd:LayoutAutogenShipSlots()

	local autogenEffect = UI:GetEffectFromLayer( self, self.layers.SHIP_SLOTS_AUTOGEN_EFFECT )
	if not autogenEffect then
		return
	end
	
	local autogenSlots = {}
	for idx, slotWnd in ipairs( self.shipSlots ) do
		if slotWnd:GetShipSlotType() == UI.shipSlotTypes.AUTOGEN and slotWnd:IsVisible() then
			table.insert( autogenSlots, slotWnd )
		end
	end

	if not next( autogenSlots ) then
		return
	end
	
	local autogenEffectPos	= autogenEffect:GetPos()
	local firstSlotPos		= autogenEffect:GetObjPos( string.format( "%s%d", self.effectInfo.autogen.slotLocatorPrefix, 1 ) )
	local secondSlotPos		= autogenEffect:GetObjPos( string.format( "%s%d", self.effectInfo.autogen.slotLocatorPrefix, 2 ) )
	local slotWidth			= autogenSlots[ 1 ]:GetWidth()
	
	local space = secondSlotPos.x - ( firstSlotPos.x + slotWidth )
	
	for idx, slotWnd in ipairs( autogenSlots ) do
		local x = firstSlotPos.x + ( slotWidth + space ) * ( idx - 1 ) + autogenEffectPos.x
		local y = firstSlotPos.y + autogenEffectPos.y
		slotWnd:SetPos( x, y )
	end
	
end


--
function UI.EquipmentWnd:F_OnMouseLButtonDown( mouseX, mouseY, wndThatReceivedInput )

	if self:IsInputBlocked() then
		return false
	end

	if self:OnMouseLButtonDown( mouseX, mouseY, wndThatReceivedInput ) then
		return false
	end

	self:ResetDD()

	local wnd = UI:GetUiObjByHandleT( wndThatReceivedInput )

	local itemSlotWnd = nil
	if UI:IsWndKindOf( wnd, "Equipment_Items_SlotWnd" ) then
		itemSlotWnd = wnd
	else
		itemSlotWnd = UI:GetAncestorKindOf( wnd, "Equipment_Items_SlotWnd" )
	end

	if UI:IsWndKindOf( wnd, "Equipment_Items_ActionBtn" ) then

		if not wnd:IsGray() then

        	local itemSlotWnd = self:GetItemSlotByActionBtn( wnd )
    		if itemSlotWnd then

    			local data = itemSlotWnd:GetRecordData()

    			local item = data.item
    			if item.itemType == self.itemTypes.SUB_TYPE then
    				item = item.subItemToShow
    			end

				if item then

        			if item.itemType == self.itemTypes.SHOP then

                   		if not self:IsWaitingRequests() then

							if UI:CantItemBeBought( item.shopItem ) then

								self:LaunchItemCraftWnd( item.shopItem.defName, false )
								return true		-- обязательно, иначе мышь будет обработана ангаром, и окно крафта закроется

							else
	                   			self:TryQuickEquip( item )
							end

                   		else
                   			UI:PlayGlobalSound( self.sounds.cannotEquip )
                   		end

        			elseif item.itemType == self.itemTypes.INVENTORY then

                   		if not self:IsWaitingRequests() then

        					if item.inventoryItems then
        						local inventoryItem = item.inventoryItems[ 1 ]
        						if inventoryItem then

									local btnMode = wnd:GetMode()

									if btnMode == UI.Equipment_Items_ActionBtn.modes.CRAFT or btnMode == UI.Equipment_Items_ActionBtn.modes.CRAFT_UPGRADE then

										local nextDefName = UI:GetItemUpgradeNextDef( inventoryItem.defName )
										if nextDefName ~= "" then

											self:LaunchItemCraftWnd( nextDefName, true, inventoryItem.iid )
											return true		-- обязательно, иначе мышь будет обработана ангаром, и окно крафта закроется

										else
											sys.log( "UI.EquipmentWnd:F_OnMouseLButtonDown()[ERROR]: cannot find def for next upgrade for item \"%s\"", inventoryItem.defName )
										end

									elseif btnMode == UI.Equipment_Items_ActionBtn.modes.UPGRADE then

										--if UI:GetItemUpgradeCreditsPrice( inventoryItem.defName ) <= UI:GetPlayerCredits() then
		        							self:LaunchUpgradeItemWnd( inventoryItem.iid, false )
										--else
										--	self:ShowMsgBoxOnNotEnoughMoney( _G.GameStore.CreditsType.CT_CREDITS )
										--end
										
									elseif btnMode == UI.Equipment_Items_ActionBtn.modes.UPGRADE_AUTOGEN then
										
		        						self:LaunchAutogenUpgradeWnd( inventoryItem.iid )

									else
										sys.log( "UI.EquipmentWnd:F_OnMouseLButtonDown()[ERROR]: unhandled btn mode %d", btnMode )
									end

        						end
        					end

        				end

        			elseif item.itemType == self.itemTypes.SPEC_MODULE then

                   		if not self:IsWaitingRequests() then

							local btnMode = wnd:GetMode()
							if btnMode == UI.Equipment_Items_ActionBtn.modes.ACTIVATE_SHIP then

								self:TrySetSpecModulePartsCollectingShip()

							elseif btnMode == UI.Equipment_Items_ActionBtn.modes.UNLOCK_SPEC_MODULE then

								self:UnlockSpecModule( item.defName )
								UI:PlayGlobalSound( self.sounds.unlockSpecModule )

							elseif btnMode == UI.Equipment_Items_ActionBtn.modes.BUY_BUNDLE then

								local bundleDefName = UI:GetBundleWithSpecModuleParts()
								self:LaunchBuyBundleWnd( bundleDefName )

							else
								sys.log( "UI.EquipmentWnd:F_OnMouseLButtonDown()[ERROR]: unhandled btn mode %d", btnMode )
							end

						end

        			else
        				sys.log( "UI.EquipmentWnd:F_OnMouseLButtonDown()[ERROR]: unhandled item type: %s", tostring( item.itemType ) )
        			end

				end

    		else
    			sys.log( "UI.EquipmentWnd:F_OnMouseLButtonDown()[ERROR]: cannot find slot" )
    		end	

		end

	elseif UI:IsWndKindOf( wnd, "Equipment_Items_OpenSubTreeBtn" ) then

		if not wnd:IsGray() then

        	local itemSlotWnd = self:GetItemSlotByOpenSubTreeBtn( wnd )
    		if itemSlotWnd then

            	local data = itemSlotWnd:GetRecordData()
    			if data.item.itemType == self.itemTypes.SUB_TYPE then

    				if self:IsItemSubTypeAvailable( data.item.subType ) then

        				if not data.item.bOpen then

        					self:OpenItemsSubType( data.item.subType, data.item.rank, true )
							UI:PlayGlobalSound( self.sounds.openSubType )
					
        				end

    				else
    	        		UI:PlayGlobalSound( self.sounds.cannotEquip )
    				end

    			else
    				sys.log( "UI.EquipmentWnd:F_OnMouseLButtonDown()[ERROR]: wrong slot type" )
    			end

    		else
    			sys.log( "UI.EquipmentWnd:F_OnMouseLButtonDown()[ERROR]: cannot find slot" )
    		end	

		end  

	elseif itemSlotWnd then

    	local data = itemSlotWnd:GetRecordData()

		local item = data.item
		if item.itemType == self.itemTypes.SUB_TYPE then
			item = item.subItemToShow
		end

		if item then

			if item.itemType == self.itemTypes.INVENTORY then

        		if not self:IsWaitingRequests() then
        			self:TryQuickEquip( item )
        		else
        			UI:PlayGlobalSound( self.sounds.cannotEquip )
        		end

			elseif item.itemType == self.itemTypes.SPEC_MODULE then

				if self:IsSpecModuleUnlocked( item.defName ) and UI:GetShipSpecModule( self.selShipItem ) ~= item.defName then

					if not self:IsWaitingRequests() then

						if not UI:IsCyberSportRestrictionsNow() or not UI:IsItemForbiddenInLeague( item.defName ) then
            				self:EquipSpecModule( item.defName )
							UI:PlayGlobalSound( self.sounds.equip )
						else
							UI:ShowErrorOnSetLeagueForbiddenEquipment()
							UI:PlayGlobalSound( self.sounds.cannotEquip )
						end

            		else
            			UI:PlayGlobalSound( self.sounds.cannotEquip )
            		end

				end

			end

		end

	elseif wnd.EQUIP_SHIP_SLOT then

		local bInBattle		= self.selShipItem and ( UI:IsShipInBattle( self.selShipItem ) or UI:IsShipOnShipQuest( self.selShipItem ) )
		local activeState	= wnd:GetActiveState()

    	if	( activeState == UI.Equipment_ShipSlotWnd.activeStates.ACTIVE or activeState == UI.Equipment_ShipSlotWnd.activeStates.LOCKED_FOR_INACTIVE_NODE )
			and wnd:GetDefName() ~= ""
			and not bInBattle
			and not self:IsWaitingRequests()
			and wnd:GetShipSlotType() ~= UI.shipSlotTypes.SPECIAL then
            	self:SetDDState_WAIT_MOUSE( wnd, mouseX, mouseY )
		end

	elseif UI:IsWndKindOf( wnd, "Equipment_ItemsList_BackBtn" ) then

    	self:OpenItemsSubType( -1, -1, true )
		UI:PlayGlobalSound( self.sounds.openSubType )

	elseif UI:IsWndKindOf( wnd, "Equipment_ItemsList_CrossBtn" ) then

		self:SelectShipSlot( nil )
		UI:PlayGlobalSound( self.sounds.hideItemsList )

	elseif wnd == UI.EquipmentShipUpgrade_Btn then
		UI.EquipmentShipUpgrade_Btn:OnMouseClick()

	elseif wnd == UI.EquipmentShipUpgrade_OpenAlienEditBtn then
		local launchData = self:MakeDefaultLaunchData()
		launchData.bReturnFromEvolvingEdit = true
		UI.HangarWnd:OpenShips( self.selShipItem.defName, true, true, nil, launchData )
		return true		-- обязательно, иначе мышь будет обработана ангаром, и окно кораблей закроется
		
	elseif UI:IsWndKindOf( wnd, "ItemIco_UpgradeArrowBtn" ) then
	
		if not self:IsWaitingRequests() and not UI:IsShipInBattle( self.selShipItem ) and not UI:IsShipOnShipQuest( self.selShipItem ) then
	
			local shipSlotWnd = UI:GetAncestorKindOf( wnd, "Equipment_ModuleShipSlotWnd" )
			if shipSlotWnd then
			
				local iid = shipSlotWnd:GetItemId()
				if iid ~= UI.INVALID_U64_ID then
				
					if UI:GetAutogenInventoryItem( iid ) then
						self:LaunchAutogenUpgradeWnd( iid )
					else
						self:LaunchUpgradeItemWnd( iid, true )
					end
					
				else
					sys.log( "UI.EquipmentWnd:F_OnMouseLButtonDown()[ERROR]: invalid iid" )
				end

			else
				sys.log( "UI.EquipmentWnd:F_OnMouseLButtonDown()[ERROR]: cannot find parent of type 'Equipment_ModuleShipSlotWnd'" )
			end
			
		end

	end

	-- HangarWnd нуждается в обработке мыши
	return false

end


--
function UI.EquipmentWnd:F_OnMouseRButtonDown( mouseX, mouseY, wndThatReceivedInput )

	if self:IsInputBlocked() then
		return false
	end

	if self:OnMouseRButtonDown( mouseX, mouseY, wndThatReceivedInput ) then
		return true
	end

	local wnd = UI:GetUiObjByHandleT( wndThatReceivedInput )

	local itemSlotWnd = nil
	if UI:IsWndKindOf( wnd, "Equipment_Items_SlotWnd" ) then
		itemSlotWnd = wnd
	else
		itemSlotWnd = UI:GetAncestorKindOf( wnd, "Equipment_Items_SlotWnd" )
	end

	if wnd.EQUIP_SHIP_SLOT then

		local activeState	= wnd:GetActiveState()
		local bInBattle		= self.selShipItem and ( UI:IsShipInBattle( self.selShipItem ) or UI:IsShipOnShipQuest( self.selShipItem ) )
		local itemDefName	= wnd:GetDefName()

    	if	( activeState == UI.Equipment_ShipSlotWnd.activeStates.ACTIVE or activeState == UI.Equipment_ShipSlotWnd.activeStates.LOCKED_FOR_INACTIVE_NODE )
			and not bInBattle
			and not self:IsWaitingRequests()
			and itemDefName ~= ""
			and wnd:GetShipSlotType() ~= UI.shipSlotTypes.SPECIAL then

			local menuDatas = {}

			local bAmmo = self:IsShipSlotTypeAmmo( wnd:GetShipSlotType() )
			local slotId = wnd:GetSlotId()
			local bAutogen = UI:IsDefAutogen( itemDefName )

			-- снять

			local unequipData = {}

    		unequipData.slotType	= UI.popUpMenuSlotTypes.REMOVE_EQUIPPED_ITEM
			unequipData.text		= UI:GetStringByName( "popUpMenu_unequipItem" )
			unequipData.vid			= self.selShipItem.vid
			unequipData.slotId		= slotId
			unequipData.defName 	= itemDefName

			if not bAmmo then
				unequipData.iid = wnd:GetItemId()
			end

			table.insert( menuDatas, unequipData )


			-- продать (кроме аммуниции и автогена)

			if not bAmmo and not bAutogen then

				local sellData = {}

    			sellData.slotType	= UI.popUpMenuSlotTypes.SELL_ITEM
				sellData.text		= UI:GetStringByName( "popUpMenu_sellItem" )
				sellData.vid		= self.selShipItem.vid
				sellData.defName	= itemDefName
				sellData.count		= 1
				sellData.iids		= { wnd:GetItemId() }

				table.insert( menuDatas, sellData )

			end
			
			
			-- уничтожить автоген (установленный атоген нельзя просто демонтировать)
			
			if bAutogen then
			
				local destroyData = {}

    			destroyData.slotType	= UI.popUpMenuSlotTypes.AUTOGEN_DESTROY
				destroyData.text		= UI:GetStringByName( "popUpMenu_autogenDestroy" )
				destroyData.iid			= wnd:GetItemId()

				table.insert( menuDatas, destroyData )
			
			end


			-- пополнить аммуницию

			if bAmmo and wnd:GetCount() == 0 then

				local refillData = {}

				if self:CanRefillAmmoFropmInventory( itemDefName ) then

        			refillData.slotType		= UI.popUpMenuSlotTypes.REFILL_AMMO_FROM_INVENTORY
					refillData.text			= UI:GetStringByName( "popUpMenu_refillAmmoFromInventory" )
					refillData.vid			= self.selShipItem.vid
					refillData.slotId		= slotId
					refillData.defName		= itemDefName

					table.insert( menuDatas, refillData )

				elseif self:CanRefillAmmoFromShop( itemDefName ) then

        			refillData.slotType		= UI.popUpMenuSlotTypes.REFILL_AMMO_FROM_SHOP
					refillData.text			= UI:GetStringByName( "popUpMenu_refillAmmoFromShop" )
					refillData.vid			= self.selShipItem.vid
					refillData.slotId		= slotId
					refillData.defName		= itemDefName

					table.insert( menuDatas, refillData )

				end

			end


			-- разобрать

			if UI:CanItemBeSalvaged( itemDefName ) or UI:CanItemBeSalvaged2( itemDefName ) then

				local salvageData = {}

    			salvageData.slotType	= UI.popUpMenuSlotTypes.SALVAGE_ITEM
				salvageData.text		= UI:GetStringByName( "popUpMenu_salvageItem" )
				salvageData.iid			= wnd:GetItemId()

				table.insert( menuDatas, salvageData )

			end


			-- апгрейдить

			if UI:IsItemUpgradable( itemDefName ) then

				local upgradeData = UI:GetItemPopUpMenuDataForUpgrade( wnd:GetItemId() )
				if upgradeData then

					upgradeData.customData = { bInShipSlot = true }
					table.insert( menuDatas, upgradeData )

				end

			end
			
			
			-- показать в атласе
			
			if UI:IsItemVisibleInAtlas( UI:GetItemUpgradeBaseDef( itemDefName ) ) then
			
				local atlasData = {}

    			atlasData.slotType	= UI.popUpMenuSlotTypes.SHOW_ATLAS
				atlasData.text		= UI:GetStringByName( "popUpMenu_showAtlas" )
				atlasData.defName	= itemDefName

				table.insert( menuDatas, atlasData )

			end
			
			
			-- открыть окно торговли с другими игроками
			
			if UI:IsItemTrading( itemDefName ) then
			
				local tradingData = {}

    			tradingData.slotType	= UI.popUpMenuSlotTypes.TRADING_ITEM
				tradingData.text		= UI:GetStringByName( "popUpMenu_tradingItem" )
				tradingData.defName		= itemDefName

				table.insert( menuDatas, tradingData )

			end


			if next( menuDatas ) then

	        	UI.PopUpMenuWnd:Setup( self:GetUiHandle(), UI.popUpMenuTypes.ITEM, UI:GetEntityLocalizedNameByDef( itemDefName, true, false, true ) )

				for idx, data in ipairs( menuDatas ) do
					UI.PopUpMenuWnd:AddRecord( data )
				end

			else
				UI:PlayGlobalSound( self.sounds.cannotSelectShipSlot )
			end

		end

	elseif itemSlotWnd then

    	local data = itemSlotWnd:GetRecordData()

    	local item = data.item
    	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
    		item = item.subItemToShow
    	end			

		local bNeedPopUpMenu = item and item.itemType ~= self.itemTypes.SUB_TYPE and self:IsItemAvailable( item ) and not self:IsWaitingRequests()
		if bNeedPopUpMenu then

			local itemDefName	= item.defName
			local bAmmo			= UI:IsDefAmmo( itemDefName )
			local selSlotId		= self.selShipSlot:GetSlotId()
			local bAutogen		= UI:IsDefAutogen( itemDefName )

			local menuDatas = {}

			-- купить (и после этого экипировать)

			if item.itemType == self.itemTypes.SHOP and not UI:CantItemBeBought( item.shopItem ) then

				local buyData = {}

        		buyData.slotType	= UI.popUpMenuSlotTypes.BUY_AND_EQUIP_ITEM
				buyData.text		= UI:GetStringByName( "popUpMenu_buyItem" )
				buyData.vid			= self.selShipItem.vid
				buyData.slotId		= selSlotId
				buyData.shopItem	= item.shopItem

				table.insert( menuDatas, buyData )

			end

			-- экипировать

			if item.itemType == self.itemTypes.INVENTORY and item.equipShipItem ~= self.selShipItem then

				local equipData = {}

        		equipData.slotType		= UI.popUpMenuSlotTypes.EQUIP_ITEM
				equipData.text			= UI:GetStringByName( "popUpMenu_equipItem" )
				equipData.dstVid		= self.selShipItem.vid
				equipData.dstSlotId		= selSlotId
				equipData.srcVid   		= item.equipShipItem and item.equipShipItem.vid or UI.INVALID_U64_ID
				equipData.srcSlotId		= item.equipShipItem and item.slotId or -1
				equipData.defName		= itemDefName

				if not bAmmo then
					local idx, inventoryItem = next( item.inventoryItems )
					equipData.iid = inventoryItem.iid
				end

				table.insert( menuDatas, equipData )

			end

			-- снять

			if item.itemType == self.itemTypes.INVENTORY and item.equipShipItem then

				local unequipData = {}

        		unequipData.slotType	= UI.popUpMenuSlotTypes.REMOVE_EQUIPPED_ITEM
				unequipData.text		= UI:GetStringByName( "popUpMenu_unequipItem" )
				unequipData.vid			= item.equipShipItem.vid
				unequipData.slotId		= item.slotId
				unequipData.defName 	= itemDefName

				if not bAmmo then
					local idx, inventoryItem = next( item.inventoryItems )
					unequipData.iid = inventoryItem.iid
				end

				table.insert( menuDatas, unequipData )

			end

			-- продать (кроме установленной аммуниции и установленного автогена)

			if item.itemType == self.itemTypes.INVENTORY and not( ( bAmmo or bAutogen ) and item.equipShipItem ) then

				local sellData = {}

    			sellData.slotType	= UI.popUpMenuSlotTypes.SELL_ITEM
				sellData.text		= UI:GetStringByName( "popUpMenu_sellItem" )
				sellData.vid		= item.equipShipItem and item.equipShipItem.vid or UI.INVALID_U64_ID
				sellData.defName	= itemDefName
				sellData.count		= 0

				sellData.iids		= {}
				for idx, inventoryItem in pairs( item.inventoryItems ) do
					table.insert( sellData.iids, inventoryItem.iid )
					local itemCount = inventoryItem.amount or 1	-- если итем автоген, то в нем нет поля amount
					sellData.count = sellData.count + itemCount
				end

				table.insert( menuDatas, sellData )

			end
			
			-- уничтожить установленный автоген
			
			if item.itemType == self.itemTypes.INVENTORY and bAutogen and item.equipShipItem then
			
				local destroyData = {}

    			destroyData.slotType	= UI.popUpMenuSlotTypes.AUTOGEN_DESTROY
				destroyData.text		= UI:GetStringByName( "popUpMenu_autogenDestroy" )
				destroyData.iid			= item.inventoryItems[1].iid

				table.insert( menuDatas, destroyData )

			end

			-- разобрать

			if item.itemType == self.itemTypes.INVENTORY and ( UI:CanItemBeSalvaged( itemDefName ) or UI:CanItemBeSalvaged2( itemDefName ) ) then

				local salvageData = {}

    			salvageData.slotType	= UI.popUpMenuSlotTypes.SALVAGE_ITEM
				salvageData.text		= UI:GetStringByName( "popUpMenu_salvageItem" )

				local idx, inventoryItem = next( item.inventoryItems )
				salvageData.iid = inventoryItem.iid

				table.insert( menuDatas, salvageData )

			end    

			-- апгрейдить

			if item.itemType == self.itemTypes.INVENTORY and UI:IsItemUpgradable( item.defName ) then

				local inventoryItem = item.inventoryItems and item.inventoryItems[ 1 ]
				local iid = inventoryItem and inventoryItem.iid or UI.INVALID_U64_ID

				if iid ~= UI.INVALID_U64_ID then

    				local upgradeData = UI:GetItemPopUpMenuDataForUpgrade( iid )
    				if upgradeData then
						upgradeData.customData = { bInShipSlot = false }
    					table.insert( menuDatas, upgradeData )
    				end

				end

			end
			
			-- показать в атласе
			
			if UI:IsItemVisibleInAtlas( UI:GetItemUpgradeBaseDef( itemDefName ) ) then
			
				local atlasData = {}

    			atlasData.slotType	= UI.popUpMenuSlotTypes.SHOW_ATLAS
				atlasData.text		= UI:GetStringByName( "popUpMenu_showAtlas" )
				atlasData.defName	= itemDefName

				table.insert( menuDatas, atlasData )

			end
			
			
			-- открыть окно торговли с другими игроками
			
			if UI:IsItemTrading( itemDefName ) then
			
				local tradingData = {}

    			tradingData.slotType	= UI.popUpMenuSlotTypes.TRADING_ITEM
				tradingData.text		= UI:GetStringByName( "popUpMenu_tradingItem" )
				tradingData.defName		= itemDefName

				table.insert( menuDatas, tradingData )

			end


			if next( menuDatas ) then

	        	UI.PopUpMenuWnd:Setup( self:GetUiHandle(), UI.popUpMenuTypes.ITEM, UI:GetEntityLocalizedNameByDef( itemDefName, true, false, true ) )

				for idx = 1, #menuDatas do
					UI.PopUpMenuWnd:AddRecord( menuDatas[ idx ] )
				end

			end

		end

	end

	-- HangarWnd нуждается в обработке мыши
	return false

end


--
function UI.EquipmentWnd:F_OnEventMouseButtonDown( hSender, btnIdx )

	if not self:IsOnScreen() then
		return
	end

	self.wndUnderLastMouseDown = UI:FindWindowUnderMouse( UI.Root, UI:GetMouseX(), UI:GetMouseY(), true )

	self:CheckHideItemsListOnMouseClick( btnIdx )

end 


--
function UI.EquipmentWnd:CheckHideItemsListOnMouseClick( btnIdx )

	if not self.selShipSlot then
		return
	end

	local wndUnderMouse = self.wndUnderLastMouseDown

	if not wndUnderMouse then
		return
	end

	-- может быть, например, если открыто "модальное" окно типа продажи или апгрейда, или контекстное меню
	if not ( wndUnderMouse == UI.HangarWnd or wndUnderMouse:IsChildOf( UI.HangarWnd ) ) then
		return
	end

	if wndUnderMouse == UI.Equipment_ItemsListWnd or wndUnderMouse:IsChildOf( UI.Equipment_ItemsListWnd ) then
		return
	end


	if UI:IsWndKindOf( wndUnderMouse, "Equipment_ShipSlotWnd" ) or UI:HasWndAncestorKindOf( wndUnderMouse, "Equipment_ShipSlotWnd" ) then

		-- левый клик на слоте корабля обрабатывается в F_OnMouseLButtonDown
		if btnIdx == 0 then
			return
		end

	end	

	self:SelectShipSlot( nil )

end


--
function UI.EquipmentWnd:F_OnMouseLButtonUp( mouseX, mouseY, wndThatReceivedInput )

	if self:OnMouseLButtonUp( mouseX, mouseY, wndThatReceivedInput ) then
		return false
	end

	local w = UI:GetUiObjByHandleT( wndThatReceivedInput ) 

	if self.ddInfo.ddState == self.ddStates.DRAG then

		if not self:IsWaitingRequests() then

    		local slotWnd = self:GetShipSlotUnderMouse( mouseX, mouseY )

    		-- уронили над принимающим слотом -> экипировка
    		if self.ddAcceptShipSlot and self.ddAcceptShipSlot.EQUIP_SHIP_SLOT and slotWnd == self.ddAcceptShipSlot then
    			self:TryEquipDDItem()
    			UI:PlayGlobalSound( self.sounds.equip )
    			
    		-- уронили над непринимающим слотом -> без последствий
    		elseif slotWnd and slotWnd:IsVisible() then
    			self:ResetDD()
				if self.sounds.ddStop and self.sounds.ddStop ~= "" then
    				UI:PlayGlobalSound( self.sounds.ddStop )
				end

    		-- уронили в любом другом месте -> разэкипировка
    		else
    			self:TryUnequipDDItem()
    			UI:PlayGlobalSound( self.sounds.unequip )
    		end

		else
    		self:ResetDD()
			if self.sounds.ddStop and self.sounds.ddStop ~= "" then
    			UI:PlayGlobalSound( self.sounds.ddStop )
			end
		end

	else

    	local slotWnd = nil

		if self.ddInfo.ddState ~= self.ddStates.NONE then
			self:ResetDD()
    		slotWnd = self:GetShipSlotUnderMouse( mouseX, mouseY )	-- при драг-энд-дропе мышь капчурится окном эквипмента, поэтому mouse up приходит для него
		else
        	if UI:IsWndKindOf( w, "Equipment_ShipSlotWnd" ) and w:IsVisible() then
        		slotWnd = w
        	end
		end

		if slotWnd and slotWnd == self.wndUnderLastMouseDown then

        	if slotWnd == self.selShipSlot and self.itemsListWnd:IsChildOf( self ) then

            	self:SelectShipSlot( nil )

        	else

            	if slotWnd:IsActive() then                                                

        			local bCanBeSelected = true

					if bCanBeSelected then
        				local bInBattle = self.selShipItem and ( UI:IsShipInBattle( self.selShipItem ) or UI:IsShipOnShipQuest( self.selShipItem ) )
        				if bInBattle then
							bCanBeSelected = false
						end
					end

					if bCanBeSelected then
	        	    	if self:IsWaitingRequests() then
							bCanBeSelected = false
						end
					end

					if bCanBeSelected then
						if slotWnd:GetShipSlotType() == UI.shipSlotTypes.SPECIAL then
							if not UI:IsSpecModuleCustomizableOnShip( self.selShipItem.defName ) then
								bCanBeSelected = false
							end
						end
					end

        			if bCanBeSelected then

    					if slotWnd ~= self.selShipSlot then

    	    				self:SelectShipSlot( slotWnd )
    						UI:PlayGlobalSound( self.sounds.shipSlotSelect )

    					end

					else
        				UI:PlayGlobalSound( self.sounds.cannotSelectShipSlot )
        			end

        		end
        	end
		end
	end

	return false

end


--
function UI.EquipmentWnd:F_OnMouseMove( mouseX, mouseY, deltaX, deltaY, wndThatReceivedInput )

	if self:OnMouseMove( mouseX, mouseY, deltaX, deltaY, wndThatReceivedInput ) then
		return false
	end

	if self.ddInfo.ddState == self.ddStates.DRAG then

		self.ddIco:UpdatePos( self:XToScreen( mouseX ), self:YToScreen( mouseY ) )
		self:UpdateAcceptSlot( mouseX, mouseY )

	elseif self.ddInfo.ddState == self.ddStates.WAIT_MOUSE then

		local mouseX_abs	= UI:XToAbs( mouseX )
		local mouseY_abs 	= UI:YToAbs( mouseY )

		local dir = UI:Vec2( mouseX_abs - self.ddInfo.mouseX_abs, mouseY_abs - self.ddInfo.mouseY_abs )
		local distSq_abs = UI:V2LengthSq( dir )

		if distSq_abs > self.ddMouseThreshold_abs * self.ddMouseThreshold_abs then
			self:SetDDState_DRAG()
		end			

	end

	return false

end


--
function UI.EquipmentWnd:F_OnMouseWheel( ticks, mouseX, mouseY, wndThatReceivedInput )

	if self:IsInputBlocked() then
		return true
	end 

	if self:OnMouseWheel( ticks, mouseX, mouseY, wndThatReceivedInput ) then
		return true
	end	

	if not self.itemsListWnd then
		return true
	end	

	local wnd = UI:GetUiObjByHandleT( wndThatReceivedInput )
	if not( wnd == self.itemsListWnd or wnd:IsChildOf( self.itemsListWnd ) ) then
		return true
	end	

	self.timeSinceMouseWheel = 0
	self.itemsListWnd:ScrollVisibleRange( ticks < 0 )

	return true

end


--
function UI.EquipmentWnd:OnEditMissMouse( editWnd )

	if self:GetDefaultActivatableChildName() == editWnd:GetName() then
		self:SetDefaultActivatableChild( "" )
		UI:ValidateKeyboardFocus()
	end
	
end


--
function UI.EquipmentWnd:F_OnAfterHideFromScreen()

	if not UI:IsInRemovingAllWindows() then
		UI.FullScreenSelectionWnd.F_OnAfterHideFromScreen( self )
		self:HideChildModals()
	else
		self:OnAfterHideFromScreen()
	end

	if not UI:IsInRemovingAllWindows() and not UI:IsInShutdown() then
		self:Reset()
	end

	self.hMsgTimeOut 							= UI.INVALID_UI_HANDLE
	self.hMsgRemoveItemFromOtherShip			= UI.INVALID_UI_HANDLE
	self.hMsgUneqipAmmo							= UI.INVALID_UI_HANDLE
	self.hMsgSetSpecModulePartsCollectingShip	= UI.INVALID_UI_HANDLE
	
	if not UI:IsInRemovingAllWindows() then
		if self.hMsgAutogenDestroy ~= UI.INVALID_UI_HANDLE then
			UI:RemoveUiObj( self.hMsgAutogenDestroy )
			UI:Purge()
			self.hMsgAutogenDestroy = UI.INVALID_UI_HANDLE
			self.autogenIidToDestroy = nil
		end
	end

	if not UI:IsInShutdown() and not UI:IsInRemovingAllWindows() then
		UI:UnsubscribeUiObjFromEvent( self:GetUiHandle(), UI.EV_MOUSE_BUTTON_DOWN )
	end

end


--
function UI.EquipmentWnd:HideChildModals()

	if UI:IsInRemovingAllWindows() then
		sys.log( "UI.EquipmentWnd:HideChildModals()[ERROR]: UI:IsInRemovingAllWindows()" )
		return
	end

	if self.hMsgRemoveItemFromOtherShip ~= UI.INVALID_UI_HANDLE then
		UI:RemoveUiObj( self.hMsgRemoveItemFromOtherShip )
		UI:Purge()
		self.hMsgRemoveItemFromOtherShip = UI.INVALID_UI_HANDLE
	end

	if self.hMsgSetSpecModulePartsCollectingShip ~= UI.INVALID_UI_HANDLE then
		UI:RemoveUiObj( self.hMsgSetSpecModulePartsCollectingShip )
		UI:Purge()
		self.hMsgSetSpecModulePartsCollectingShip = UI.INVALID_UI_HANDLE
	end

	UI.Equipment_TradeWnd:UnlinkFromParent()
	UI.Equipment_BuyWnd:UnlinkFromParent()
	UI.Equipment_SalvageWnd:UnlinkFromParent()	
	UI.Equipment_UpgradeItemWnd:UnlinkFromParent()	
	UI.Equipment_BuyWithInventoryWnd:Hide()
	
	if UI.AutogenUpgradeWnd:GetMainWndName() == self:GetName() then
		UI.AutogenUpgradeWnd:Hide()
	end	

	if not self.bLockBuyBundleHide then
		if UI.BuyBundleWnd:IsOnScreen() and UI.BuyBundleWnd:GetMainWndName() == self:GetScriptTableName() then
			UI.BuyBundleWnd:Hide()
		end
	end
	
	if not self.bLockAutogenUnequipHide then
		if UI.AutogenUnequipWnd:GetMainWndName() == self:GetName() then
			UI.AutogenUnequipWnd:Hide()
		end
	end
	
	if self.hMsgAutogenDestroy ~= UI.INVALID_UI_HANDLE then
		UI:RemoveUiObj( self.hMsgAutogenDestroy )
		UI:Purge()
		self.hMsgAutogenDestroy = UI.INVALID_UI_HANDLE
		self.autogenIidToDestroy = nil
	end
	
	if self.hMsgAutogenEquipConfirm ~= UI.INVALID_UI_HANDLE then
		UI:RemoveUiObj( self.hMsgAutogenEquipConfirm )
		UI:Purge()
		self.hMsgAutogenEquipConfirm = UI.INVALID_UI_HANDLE
		self.moduleToEquipData = nil
	end
	
end


--
function UI.EquipmentWnd:F_OnAfterShowOnScreen()

	self:Reset()

	self:OnAfterShowOnScreen()

	-- здесь, а не в PostLoad, т.к. во время PostLoad еще не загружены скриптовые файлы с константами ai
	if not next( self.shipSlots ) then
		self:CreateShipSlots()
	end
	
	self:UpdateMetaTextPos()

	self:FullUpdate()

	UI:SubscribeUiObjOnEvent( self:GetUiHandle(), UI.EV_MOUSE_BUTTON_DOWN )

end


--
function UI.EquipmentWnd:ResetItemsList()

	if self.itemsListWnd then
		self.itemsListWnd:Reset()
	end

	self.treeItems = {}

end


--
function UI.EquipmentWnd:UpdateItems( bRestoreLayout )

	if self.bLockItemsUpdate then
		return
	end

	local oldOpenSubType, oldOpenRank = self:GetOpenItemsSubType()
	local oldScrollPos = self.itemsListWnd:GetScrollPos()

	self:ResetItemsList()

	if not self.selShipSlot then
		self.savedItemsUpLevelLayout = nil
		return
	end


	-- построение дерева

	self.treeItems = self:GetItemsFiltered()


	-- определяется открытая папка
	local openSubType = -1
	local openRank = -1

	-- существующая открытая папка сохраняется
	if bRestoreLayout then
		openSubType = oldOpenSubType
		openRank = oldOpenRank

	-- открытая папка по умолчанию - отсутствует
	else
		openSubType = -1
		openRank = -1
	end

	-- #0034304 не допускается открытие пустой папки
	if openSubType ~= -1 then

		local bHasSubTreeItems = false

		local subTypeItem = self:GetItemBySubType( openSubType, openRank )
		if subTypeItem then
		
			local subTreeItems = self:GetSubtreeItems( subTypeItem )
			bHasSubTreeItems = next( subTreeItems ) ~= nil

		end

		if not bHasSubTreeItems then
			openSubType = -1
			openRank = -1
		end

	end		

	self:SetItemTreeOpenSubTypeInternal( openSubType, openRank )
	openSubType, openRank = self:GetOpenItemsSubType()

	-- построение списка по дереву
	self:UpdateItemsListFromTree()


	-- установка позиции скролла

	if self.itemsListWnd:GetNumRecords() > 0 then

    	local scrollPos = 0

    	if bRestoreLayout then

    		if oldScrollPos ~= -1 then
    			scrollPos = oldScrollPos		
			end

    	else
    		local curItem = self:GetCurTreeItem( openSubType ~= -1 )
    		if curItem then
    			local recordIdx = self:GetRecordByItem( curItem )
    			if recordIdx ~= -1 then
    				scrollPos = recordIdx
    			end
    		end
    	end


    	self.itemsListWnd:SetScrollPos( scrollPos )

	end


	-- если лэйаут списка строится с нуля, то сброс запомненной информации о верхнем уровне лэйаута
	if not bRestoreLayout then
		self.savedItemsUpLevelLayout = nil
	end

end


--
function UI.EquipmentWnd:MakeTreeItemsIndices( treeItems )

	for idx, item in pairs( treeItems ) do
		item.treeIdx = idx
	end

	return treeItems	

end  


-- для аммуниции "субтайпом" считается ее деф, а не нстоящий субтайп, потому что на верхнем уровне списка именно дефы, а не настоящие субтайпы - #0036878,комм.(0135117)
-- SC-106162 для автогена вместо субтайпа используется деф (т.к. субтайп у всех одинаковый)
function UI.EquipmentWnd:GetItemSubTypeEx( item )

	if not item then
		return -1, -1
	end

	if item.itemType == self.itemTypes.SUB_TYPE then
		return item.subType, item.rank
	end

	return self:GetItemSubTypeExByDefName( item.defName )

end


--
function UI.EquipmentWnd:GetItemSubTypeExByDefName( defName )

	local bAmmo = UI:IsDefAmmo( defName )
	local bAutogen = UI:IsDefAutogen( defName )

	if bAmmo or bAutogen then
		return defName, -1

	else

	   	local def = UI:GetDef( defName )
		local subType = def.item_subtype or -1

		local rank = -1
		if self:NeedGroupByRank() then
			rank = UI:GetItemEquipMinRank( defName )
		end

		return subType, rank

	end

end


--
function UI.EquipmentWnd:OpenItemsSubType( subType, rank, bPreserveScrollPos )

	local oldSubType, oldRank = self:GetOpenItemsSubType()
	self:SetItemTreeOpenSubTypeInternal( subType, rank )
	local newSubType, newRank = self:GetOpenItemsSubType()

	-- при переходе на нижний уровень дерева сохраняется позиция скролла для последующего восстановления

	local bGoUp = oldSubType ~= -1 and newSubType == -1
	local bGoDown = oldSubType == -1 and newSubType ~= -1
	local bNeedSaveUpLevelLayout = false

	if bPreserveScrollPos then
    	if bGoDown then
			self.savedItemsUpLevelLayout = { subType = subType, rank = rank, scrollPos = self.itemsListWnd:GetScrollPos() }
			bNeedSaveUpLevelLayout = true
    	end
	end

	-- создание списка
	self:UpdateItemsListFromTree()

	-- при переходе на верхний уровень дерева восстанавливается сохраненная позиция скролла

	local scrollPos = 0

	local bScrollPosHandled = false
	if bPreserveScrollPos then
    	if bGoUp and self.savedItemsUpLevelLayout and self.savedItemsUpLevelLayout.subType == oldSubType and self.savedItemsUpLevelLayout.rank == oldRank then
			scrollPos = self.savedItemsUpLevelLayout.scrollPos
			bScrollPosHandled = true
		end
	end

	if not bScrollPosHandled then
		
		local curItem = self:GetCurTreeItem( newSubType ~= -1 )
		if curItem then
			local recordIdx = self:GetRecordByItem( curItem )
			if recordIdx ~= -1 then
				scrollPos = recordIdx
			end
		end		

	end

	self.itemsListWnd:SetScrollPos( scrollPos )


	-- сброс сохраненной позиции скролла при необходиости

	if not bNeedSaveUpLevelLayout then
		self.savedItemsUpLevelLayout = nil
	end	

end


--
function UI.EquipmentWnd:SetItemTreeOpenSubTypeInternal( subType, rank )

	if subType ~= -1 and not self:IsItemSubTypeAvailable( subType ) then
		subType = -1
	end

	local oldOpenItem	= nil
	local newOpenItem	= nil

	for idx, item in pairs( self.treeItems ) do

		if item.itemType == self.itemTypes.SUB_TYPE then

			if item.bOpen then
				oldOpenItem = item
			end

			if subType ~= -1 and item.subType == subType and item.rank == rank then
				newOpenItem = item
			end

		end

	end

	if newOpenItem == oldOpenItem then
		return
	end

	if oldOpenItem then
		oldOpenItem.bOpen = false
	end

	if newOpenItem then
		newOpenItem.bOpen = true
	end	

end


--
function UI.EquipmentWnd:GetOpenItem()

	for idx, item in pairs( self.treeItems ) do
		if item.bOpen then
			return item
		end
	end

	return nil

end


--
function UI.EquipmentWnd:GetOpenItemsSubType()

	local openItem = self:GetOpenItem()

	local subType = openItem and openItem.subType or -1
	local rank = openItem and openItem.rank or -1

	return subType, rank

end


--
function UI.EquipmentWnd:GetSubtreeFirstItem( rootItem )

	local nextItem = self.treeItems[ rootItem.treeIdx + 1 ]

	if nextItem.itemType ~= self.itemTypes.SUB_TYPE then
		return nextItem
	else
		return nil
	end

end


--
function UI.EquipmentWnd:GetSubtreeLastItem( rootItem )

	local lastSubtreeItem = nil

	for idx = rootItem.treeIdx + 1, #self.treeItems do

		local item = self.treeItems[ idx ]
		if item.itemType ~= self.itemTypes.SUB_TYPE then
			lastSubtreeItem = item
		else
			break
		end

	end

	return lastSubtreeItem

end   


--
function UI.EquipmentWnd:GetSubtreeItems( rootItem, items )

	if items == nil then
		items = self.treeItems
	end

	local subtreeItems = {}

	for idx = rootItem.treeIdx + 1, #items do

		local item = items[ idx ]
		if item.itemType ~= self.itemTypes.SUB_TYPE then
			table.insert( subtreeItems, item )
		else
			break
		end

	end

	return subtreeItems	

end


--
function UI.EquipmentWnd:GetCurTreeItem( bHasOpenSubType )

	local bFindSubTypeItem = not bHasOpenSubType

	if self.selShipSlot and self.selShipSlot:GetShipSlotType() == UI.shipSlotTypes.SPECIAL then
		bFindSubTypeItem = false
	end

	for idx, item in pairs( self.treeItems ) do

		if ( bFindSubTypeItem and item.itemType == self.itemTypes.SUB_TYPE ) or ( not bFindSubTypeItem and item.itemType ~= self.itemTypes.SUB_TYPE ) then
    		if self:IsItemCurrent( item ) then
    			return item
    		end
		end

	end

	return nil

end


--
function UI.EquipmentWnd:GetRecordByItem( item )

	for recordIdx = 1, self.itemsListWnd:GetNumRecords() do

		local data = self.itemsListWnd:GetRecordData( recordIdx )
		if data.item == item then
			return recordIdx
		end

	end

	return -1

end


--
function UI.EquipmentWnd:GetRecordBySubType( subType, rank )

	for recordIdx = 1, self.itemsListWnd:GetNumRecords() do

		local data = self.itemsListWnd:GetRecordData( recordIdx )
		if data.item.itemType == self.itemTypes.SUB_TYPE and data.item.subType == subType and data.item.rank == rank then
			return recordIdx
		end

	end

	return -1	

end


--
function UI.EquipmentWnd:GetItemBySubType( subType, rank )

	for idx, item in pairs( self.treeItems ) do

		if item.itemType == self.itemTypes.SUB_TYPE and item.subType == subType and item.rank == rank then
			return item
		end

	end

	return nil

end


--
function UI.EquipmentWnd:UpdateItemsListFromTree()	

	local openSubType, openRank = self:GetOpenItemsSubType()
	local shipSlotType = self.selShipSlot:GetShipSlotType()
	local bAmmo = self.selShipSlot and self:IsShipSlotTypeAmmo( shipSlotType )

	self.itemsListWnd:Reset()

	self.itemsListWnd:UpdateMaxSlots()

	local mode = shipSlotType == UI.shipSlotTypes.SPECIAL and self.itemsListWnd.modes.SPEC_MODULE or self.itemsListWnd.modes.REGULAR
	self.itemsListWnd:SetMode( mode )

	for idx = 1, #self.treeItems do

		local item = self.treeItems[ idx ] 

		local bShow = false

		if openSubType == -1 then
			bShow = item.itemType == self.itemTypes.SUB_TYPE or item.itemType == self.itemTypes.SPEC_MODULE
		else
			local subType, rank = self:GetItemSubTypeEx( item )
			bShow = item.itemType ~= self.itemTypes.SUB_TYPE and subType == openSubType and rank == openRank
		end

		if bShow then
			local data = { item = item }
			self.itemsListWnd:AddRecord( data )
		end

	end

	self.itemsListWnd:UpdateBackBtn()
	self:UpdateItemsCaption()
	self:UpdateItemsListLayout()

end


--
function UI.EquipmentWnd:AdjustItemsList()

	-- находится открытая папка

	local openItem = self:GetOpenItem()
	if not openItem then
		return
	end

	local openItemRecordIdx = self:GetRecordByItem( openItem )
	if openItemRecordIdx == -1 then
		sys.log( "UI.EquipmentWnd:AdjustItemsList()[ERROR]: cannot find record for open item" )
		return
	end


	-- находится последний элемент открытого поддерева

	local lastSubtreeItem = self:GetSubtreeLastItem( openItem )
	if not lastSubtreeItem then
		sys.log( "UI.EquipmentWnd:AdjustItemsList()[ERROR]: cannot find last subtree item" )
		return
	end

	local lastSubtreeRecordIdx = self:GetRecordByItem( lastSubtreeItem )
	if lastSubtreeRecordIdx == -1 then
		sys.log( "UI.EquipmentWnd:AdjustItemsList()[ERROR]: cannot find record for last subtree item" )
		return
	end


	-- если элемент открытой папки видим и последний элемент поддерева не является последний видимым, то ничего дополнительно делать не надо	

	local firstVisibleRecordIdx, lastVisibleRecordIdx = self.itemsListWnd:GetVisibleRange()
	if openItemRecordIdx >= firstVisibleRecordIdx and lastSubtreeRecordIdx < lastVisibleRecordIdx then
		return
	end


	local newFirstVisibleRecordIdx = -1

	-- не влазит сверху

	if openItemRecordIdx < firstVisibleRecordIdx then
		newFirstVisibleRecordIdx = openItemRecordIdx

	-- не влазит снизу
	else

		-- последним видимым делается последний элемент поддерева
    	
    	local newLastVisibleRecordIdx = lastSubtreeRecordIdx
    	if newLastVisibleRecordIdx > self.itemsListWnd:GetNumRecords() then
    		newLastVisibleRecordIdx = lastSubtreeRecordIdx
    	end

    	newFirstVisibleRecordIdx = newLastVisibleRecordIdx - self.itemsListWnd.MAX_SLOTS + 1
    	if newFirstVisibleRecordIdx < 1 then
    		newFirstVisibleRecordIdx = 1
    	end


    	-- если при этом перестал влезать сверху элемент открытой папки, то делаем его первым видимым,
    	-- а открытое поддерево покажется сколько получится

    	if openItemRecordIdx < newFirstVisibleRecordIdx then
    		newFirstVisibleRecordIdx = openItemRecordIdx
    	end

	end

	-- установка позиции
	self.itemsListWnd:SetScrollPos( newFirstVisibleRecordIdx, true, false )	

end


--
function UI.EquipmentWnd:GetItemVisScrollDelta( item )

	local recordIdx = self:GetRecordByItem( item )
	if recordIdx == -1 then
		return 0
	else
		return recordIdx - self.itemsListWnd:GetScrollPos()
	end

end


--
function UI.EquipmentWnd:SetItemVisScrollDelta( item, visScrollDelta )

	local recordIdx = self:GetRecordByItem( item )
	if recordIdx ~= -1 then
		self.itemsListWnd:SetScrollPos( recordIdx - visScrollDelta )
	end

end


--
local function SortEquipItemsPredicat( item1, item2 )

	-- вначале - вещи, экипированные на данный корабль
	if item1.equipShipItem == UI.EquipmentWnd.selShipItem and item2.equipShipItem ~= UI.EquipmentWnd.selShipItem then
		return true

	elseif item1.equipShipItem ~= UI.EquipmentWnd.selShipItem and item2.equipShipItem == UI.EquipmentWnd.selShipItem then
		return false

	-- далее сортировка по локализованному имени (не чувствительно к регистру)
	else
		return item1.equipShipItem.localizedName_lower < item2.equipShipItem.localizedName_lower		
	end

end


--
function UI.EquipmentWnd:GetItemsFiltered()

	if not self.selShipSlot then
		return {}
	end

	if self.selShipSlot:GetShipSlotType() == UI.shipSlotTypes.SPECIAL then
		return self:GetSpecModuleItems()
	else
		return self:GetRegularItems()
	end	

end


--
function UI.EquipmentWnd:GetRegularItems()

	if not self.selShipSlot then
		return {}
	end

	local bAmmo = self:IsShipSlotTypeAmmo( self.selShipSlot:GetShipSlotType() )

	local filterInfo = {}

	-- category
	-- категории убраны (#0030266, комм.(0099171))
	
	filterInfo.mainCategory	= ""
	filterInfo.subCategory	= ""

	-- other filters
	-- галки для фильтров были убраны, и сейчас это просто константы (#0029697, комм.(0098022))

	filterInfo.bHideShop			= false
	filterInfo.bHideOtherEquipped	= false		-- #0134923 - показываются установленные на других кораблях, но не показываются установленные в других слотах этого же корабля
	
	local curWeaponClass = self:GetCurWeaponClass()
	local curWeaponAmmoSubType = self:GetCurWeaponAmmoSubType()
	local selSlotId = self.selShipSlot:GetSlotId()

	-- список всех подходящих дефинишенов
	-- (дефинишены представлены shopItem-ами - предполагается, что любая вещь, которая может лежать в инвентаре или быть экипирована, есть в магазине)
	local allDefs = {}
	for defName, shopItem in pairs( UI.serverData.shopByDef ) do

		if self:TestItem( shopItem.defName, self.selShipSlot, filterInfo, curWeaponClass, curWeaponAmmoSubType ) then
			table.insert( allDefs, shopItem.defName )
		end

	end
	
	-- автоген
	for autogenItemIdx, autogenItem in pairs( UI.serverData.autogenInventory ) do
	
		if self:TestItem( autogenItem.defName, self.selShipSlot, filterInfo, curWeaponClass, curWeaponAmmoSubType ) then
			table.insert( allDefs, autogenItem.defName )
		end

	end

	-- при сортировке игнорируются категории, чтобы ни при каких обстоятельствах не оказалось, чтобы вещи с одинаковым item_subtype оказались не рядом
	UI:SortDefs( allDefs, self.sortMode == self.sortModes.DESC, true )


	-- список слотов (на один дефинишен может приходиться несколько слотов)
	local items				= {}

	local bGroupByRank		= self:NeedGroupByRank()
	local prevSubType		= bAmmo and "" or -1	-- для аммуниции вместо субтайпа используется деф - см.#0036878, комм.(0135117); -- SC-106162 для автогена вместо субтайпа используется деф (т.к. субтайп у всех одинаковый)
	local prevRank			= -1
	local prevSubTypeItem	= nil
	local prevSubItems		= {}
	local enchantedModes	= ( self.sortMode == self.sortModes.ASC ) and { false, true } or { true, false }

	local function fnCheckAddSubTypeItem( prevSubTypeItem )

		-- #0037258, комм.(0135978) - если в поддереве нет предмета, установленного в данный слот/на складе/можно купить,
		-- то данный сабтайп вообще не показывается
		-- SC-106162 исключение для автогена - можно модули, установленные на другие корабли

		local bHasGoodSubItem = false

		for subItemIdx, subItem in pairs( prevSubItems ) do

			-- установлен в текущий слот текущего корабля?
			if not bHasGoodSubItem then
				if self:IsItemCurrent( subItem ) then
					bHasGoodSubItem = true
				end
			end

			-- на складе?
			if not bHasGoodSubItem then
				if subItem.itemType == self.itemTypes.INVENTORY and not subItem.equipShipItem then
					bHasGoodSubItem = true
				end
			end

			-- в магазине?
			if not bHasGoodSubItem then
				if subItem.itemType == self.itemTypes.SHOP then
					bHasGoodSubItem = true
				end
			end
			
			-- автоген, утстановленный на другой корабль?
			if not bHasGoodSubItem then
				if UI:IsDefAutogen( subItem.defName ) and subItem.equipShipItem and subItem.equipShipItem ~= self.selShipItem then
					bHasGoodSubItem = true
				end
			end

			if bHasGoodSubItem then
				break
			end

		end

		local bNeedShowSubType = bHasGoodSubItem or next( prevSubTypeItem.shopItems ) ~= nil 
		if bNeedShowSubType then

	    	table.insert( items, prevSubTypeItem )

			for subItemIdx = 1, #prevSubItems do
				table.insert( items, prevSubItems[ subItemIdx ] )
			end				

		end

	end


	-- #0046636 -  если есть продаваемый за деньги, то крафтовые не показываются 
	local function fnValidateShopItems( shopItems )

		local bHasItemThatCanBeBought	= false
		local craftableOnlyItems		= nil

		for itemIdx, item in pairs( shopItems ) do

			if not UI:CantItemBeBought( item ) then
				bHasItemThatCanBeBought = true

			else

				if not craftableOnlyItems then
					craftableOnlyItems = {}
				end

				table.insert( craftableOnlyItems, item )

			end

		end

		if bHasItemThatCanBeBought and craftableOnlyItems then

			for craftableItemIdx, craftableItem in pairs( craftableOnlyItems ) do

				for itemIdx, item in pairs( shopItems ) do

					if item == craftableItem then
						table.remove( shopItems, itemIdx )
						break
					end

				end

			end

		end

	end


	for idx, defName in ipairs( allDefs ) do
		
		local def = UI:GetDef( defName )

		-- для аммуниции вместо субтайпа используется деф - см.#0036878, комм.(0135117)
		-- SC-106162 для автогена вместо субтайпа используется деф (т.к. субтайп у всех одинаковый)
		local subType = nil

		if bAmmo or UI:IsDefAutogen( defName ) then
			subType = defName
		else
			subType = def.item_subtype or -1
		end

		-- #0056479, комм.(0225187) - группировка по рангам, если включена данная логика (для аммуниции не надо, т.к. она не группируется, а показывается по дефам)
		local rank = -1
		if bGroupByRank and not bAmmo then
			rank = UI:GetItemEquipMinRank( defName )
		end

		local subTypeItem	= prevSubTypeItem
		local subItems		= prevSubItems

		if subType ~= prevSubType or rank ~= prevRank then

			subItems = {}

			subTypeItem =
			{
				itemType		= self.itemTypes.SUB_TYPE,
				subType			= subType,
				rank			= rank,
				bOpen			= false,
				shopItems		= {}
			}

			if prevSubTypeItem then
				fnCheckAddSubTypeItem( prevSubTypeItem )
			end

		end

		-- энчантед и не-энчантед трактуются как разные дефы, только энчантед не продаются в магазине

		for enchantedModeIdx = 1, #enchantedModes do

			local bEnchanted = enchantedModes[ enchantedModeIdx ]
			if bEnchanted then

        		if _G.GetStoreItemTypeByDef( defName ) == _G.GameStore.ItemType.IT_MODULE then
        			self:MakeSubTreeItems( defName, true, filterInfo, subItems )
        		end

			else
        		self:MakeSubTreeItems( defName, false, filterInfo, subItems )
			end

		end          

		if self:CanShowShopSlotForItem( defName ) then
			local shopItem = UI.serverData.shopByDef[ defName ]
			table.insert( subTypeItem.shopItems, shopItem )
			fnValidateShopItems( subTypeItem.shopItems )
		end

		prevSubType		= subType
		prevRank		= rank
		prevSubTypeItem	= subTypeItem
		prevSubItems	= subItems

	end

	if prevSubTypeItem then
		fnCheckAddSubTypeItem( prevSubTypeItem )
	end

	self:MakeTreeItemsIndices( items )

	for itemIdx, item in pairs( items ) do
		if item.itemType == self.itemTypes.SUB_TYPE then
			self:InitSubTypeItem( item, items )
		end
	end

	return items

end 


--
function UI.EquipmentWnd:GetSpecModuleItems()

	local items = {}

	if not self.selShipItem then
		sys.log( "UI.EquipmentWnd:GetSpecModuleItems()[ERROR]: no ship" )
		return items
	end

	local defaultItem = {}

	local defaultSpecModule = UI:GetShipDefaultSpecModule( self.selShipItem.defName )
	if defaultSpecModule ~= "" then

		defaultItem.itemType	= self.itemTypes.SPEC_MODULE
		defaultItem.defName		= defaultSpecModule

		table.insert( items, defaultItem )

	end

	local specModules = UI:GetShipCustomizableSpecModules( self.selShipItem.defName )
	for level, specModuleInfo in ipairs( specModules ) do

		local item =
		{
			itemType	= self.itemTypes.SPEC_MODULE,
			defName		= specModuleInfo.defName,
		}

		table.insert( items, item )

	end

	return items	

end


--
function UI.EquipmentWnd:NeedGroupByRank()

	-- (#0056479, (0225731) - от группировки по рангам отказались)
	-- #0095786 (0451322),(0451640) - снова вернули
	return true

end


--
function UI.EquipmentWnd:CanShowShopSlotForItem( defName )

	if UI:IsDefAutogen( defName ) or UI:IsDefAutogenBase( defName ) then
		return false
	end
	
	local itemBuyRank = UI:GetItemRequiredAccountRank( defName )
	if itemBuyRank ~= -1 then		

		local playerRank = UI:GetPlayerAccountRank()

		if playerRank < itemBuyRank then
			return false
		end

	end
	
	-- предмет можно:
	-- купить
	-- скрафтить
	-- "добыть"

	if UI:CantItemBeBoughtByDef( defName ) then
	
		local blueprintDefName = UI:GetBlueprintForItemCraft( defName, true )
		if blueprintDefName == "" then
		
			-- если нельзя купить или скрафтить, то предмет показывается с кнопкой "добыть"
			
			-- #0089469,комм.(0406379) - то, можно ли показать предмет с кнопкой "добыть", проверяется по наличию атлас id
			if UI:GetItemAtlasId( defName ) == -1 then
				return false
			end
			
		end
	
    	local upgradeLevel = UI:GetItemUpgradeLevel( defName )
    	if not( upgradeLevel == -1 or upgradeLevel == 1 ) then
    		return false
    	end
		
	end

	return true

end


--
function UI.EquipmentWnd:InitSubTypeItem( subTypeItem, items )
	
	subTypeItem.subItemToShow		= nil

	local curSubtreeItem			= nil
	local bestEquipOtherSlotItem	= nil
	local bestEquipOtherShipItem	= nil
	local bestInvSubtreeItem		= nil
	local bestShopItem				= nil

	local function l_IsItemBetter( item1, item2 )

		local bIsBetter = false

		if self.sortMode == self.sortModes.DESC then
			bIsBetter = item1.treeIdx < item2.treeIdx
		else
			bIsBetter = item1.treeIdx > item2.treeIdx
		end

		return bIsBetter

	end


	local subtreeItems = self:GetSubtreeItems( subTypeItem, items )
	for idx, subtreeItem in pairs( subtreeItems ) do

		if subtreeItem.itemType == self.itemTypes.INVENTORY then

			if subtreeItem.equipShipItem then
				
				if subtreeItem.equipShipItem == self.selShipItem then
					
					if self:IsItemCurrent( subtreeItem ) then
						curSubtreeItem = subtreeItem
					else
						if not bestEquipOtherSlotItem or l_IsItemBetter( subtreeItem, bestEquipOtherSlotItem ) then
							bestEquipOtherSlotItem = subtreeItem
						end
					end
					
				else
				
					if not bestEquipOtherShipItem or l_IsItemBetter( subtreeItem, bestEquipOtherShipItem ) then
						bestEquipOtherShipItem = subtreeItem
					end
					
				end

			else

				if not bestInvSubtreeItem or l_IsItemBetter( subtreeItem, bestInvSubtreeItem ) then
					bestInvSubtreeItem = subtreeItem
				end

			end

		elseif subtreeItem.itemType == self.itemTypes.SHOP then

			if not bestShopItem or l_IsItemBetter( subtreeItem, bestShopItem ) then
				bestShopItem = subtreeItem
			end

		end

	end

	if curSubtreeItem then
		subTypeItem.subItemToShow = curSubtreeItem

	elseif bestInvSubtreeItem then
		subTypeItem.subItemToShow = bestInvSubtreeItem

	elseif bestShopItem then
		subTypeItem.subItemToShow = bestShopItem

	-- магазин может не показываться в поддереве, поэтому магазинный итем создается здесь
	elseif subTypeItem.shopItems and next( subTypeItem.shopItems ) then

		local shopItem = nil

		if self.sortMode == self.sortModes.DESC then
			shopItem = subTypeItem.shopItems[ 1 ]
		else
			shopItem = subTypeItem.shopItems[ #subTypeItem.shopItems ]
		end

		local item = {}
		item.itemType		= self.itemTypes.SHOP
		item.defName		= shopItem.defName
		item.shopItem		= shopItem
		item.equipShipItem	= nil
		item.slotId			= -1
		item.count			= -1
		item.maxCount		= -1
		item.inventoryItems	= {}

		subTypeItem.subItemToShow = item
		
	elseif bestEquipOtherShipItem then
		subTypeItem.subItemToShow = bestEquipOtherShipItem
		
	-- но такие предметы (установленные в другой слот текущего корабля) сейчас вообще в список не добавляются;
	-- данная проверк просто на всякий случай, чтобы по охватить все возможные кейсы
	elseif bestEquipOtherSlotItem then
		subTypeItem.subItemToShow = bestEquipOtherSlotItem
	end

	if not subTypeItem.subItemToShow then
		sys.log( "UI.EquipmentWnd:UpdateItemsListFromTree()[ERROR]: cannot find subtree item to show on the folder level for subtype %s rank %s on ship %s", tostring( subTypeItem.subType ), tostring( subTypeItem.rank ), self.selShipItem.defName )
	end

end


-- энчантед и не-энчантед трактуются как разные дефы, только энчантед не продаются в магазине
function UI.EquipmentWnd:MakeSubTreeItems( defName, bEnchanted, filterInfo, items )
	
	local selSlotId = self.selShipSlot:GetSlotId()

	local bShowAllOfDef = true

	-- установлен в выделенный слот корабля -> в списке для данного дефа возможно будет только этот слот;

	local curItem = nil

	if self.selShipSlot:GetDefName() == defName then

		-- расстрелянная аммуниция не показывается как установленная
		if not( _G.GetStoreItemTypeByDef( defName ) == _G.GameStore.ItemType.IT_ROCKET and self.selShipSlot:GetCount() == 0 ) then

			local bEquippedItemEnchanted = false

			if _G.GetStoreItemTypeByDef( defName ) == _G.GameStore.ItemType.IT_MODULE then
				local equippedItemId = self.selShipSlot:GetItemId()
				bEquippedItemEnchanted = UI:IsInventoryItemEnchantedById( equippedItemId )				
			end

			if bEquippedItemEnchanted == bEnchanted then

    			local item = {}

    			item.itemType			= self.itemTypes.INVENTORY			
    			item.defName			= defName
    			item.shopItem			= nil
    			item.equipShipItem		= self.selShipItem
    			item.slotId				= selSlotId
    			item.count				= 1
    			item.maxCount			= 1
				item.countInInventory	= self:GetNumItemsInInventory( defName, bEnchanted )

    			if _G.GetStoreItemTypeByDef( defName ) == _G.GameStore.ItemType.IT_MODULE then
					local inventoryIem = UI:GetInventoryItemEx( self.selShipSlot:GetItemId() )
    				item.inventoryItems	= { inventoryIem }
    			else
    				item.inventoryItems	= {}
    			end

    			table.insert( items, item )

				curItem = item

--    			bShowAllOfDef = false	-- #0036878 - сейчас если есть установленный в данный слот предмет, то другие тоже показываются

			end

		end

	end

	-- for test
	if _EQ_ALL then
		bShowAllOfDef = true
	end


	-- НЕ установлен в выделенный слот корабля; либо установлен, но количество не максимальное -> в списке для данного дефа будет несколько слотов (установленные, на складе/в магазине)
	if bShowAllOfDef then

		local inStoreItems	= {}		-- НЕ экипированные вещи
		local equipItems	= {}		-- экипированные вещи

		-- все, что у нас есть в инвентаре с данным дефом (сюда входят установленные модули, но НЕ входит установленная аммуниция)
		local inventoryItemsByDef = UI.serverData.inventoryByDef[ defName ]
		if inventoryItemsByDef then

			for idx = 1, #inventoryItemsByDef do

				local inventoryItem = inventoryItemsByDef[ idx ]

				local bInventoryItemEnchanted = UI:IsInventoryItemEnchanted( inventoryItem )
				if bInventoryItemEnchanted == bEnchanted then

    				-- находится корабль, на который модуль установлен
    				local equipShipItem = UI:GetEquippedShipItem( inventoryItem.iid )

    				-- вещь установлена на корабль
    				if equipShipItem then

                		-- проверка фильтра, надо ли показывать вещи, установленные на других кораблях
						-- (#0036878 - флаг bHideOtherEquipped=false сейчас означает, что показываются утсановленные на других кораблях вещи,
						-- но не показываются вещи, установленные на том же корабле в другом слоте)

						if not filterInfo.bHideOtherEquipped and equipShipItem ~= self.selShipItem then

        					-- из установленного в инвентаре могут быть только модули, установленные ракеты в инвентаре не лежат
        					if _G.GetStoreItemTypeByDef( defName ) == _G.GameStore.ItemType.IT_MODULE then

            					-- находится слот, в который модуль установлен
    							local equipSlotId = -1	
        						for slotId, iid in pairs( equipShipItem.equipModules ) do
        							if iid == inventoryItem.iid then
    									equipSlotId = slotId
    									break
    								end
    							end					

                    			local item = {}

                    			item.itemType			= self.itemTypes.INVENTORY			
                    			item.defName			= defName
                    			item.shopItem			= nil
                    			item.equipShipItem		= equipShipItem
                    			item.slotId				= equipSlotId
                    			item.count				= 1
								item.maxCount			= -1
								item.inventoryItems		= { inventoryItem }
								item.countInInventory	= self:GetNumItemsInInventory( defName, bEnchanted )

                    			table.insert( equipItems, item )

        					else
        						sys.log( "UI.EquipmentWnd:MakeSubTreeItems()[ERROR]: equipped item in inventory is not IT_MODULE" )
        					end
						end
    					
    				-- вещь не установлена на корабль, т.е. "на складе"
    				else

						local bCanShow = true
						
						 -- итемы для аммуниции раньше могли лежать в инвентаре и с количеством 0, поэтому на всякий случай проверка
						if bCanShow then
							if inventoryItem.amount <= 0 then
								sys.log( "UI.EquipmentWnd:MakeSubTreeItems()[ERROR]: item \"%s\" in inventory with 0 amount", defName )
								bCanShow = false
							end
						end
						
						-- #0098460 - предметы, которые выставлены на продажу между игроками, не должны показываться больше нигде
						if bCanShow then
							local bAdverted = UI:IsItemAdverted( inventoryItem.iid )
							if bAdverted then
								bCanShow = false
							end
						end
						
						if bCanShow then

							local item = nil

							-- для модулей для каждого iid создается свой слот;
							-- для аммуниции, по идее, всегда существует только один iid, другие типы предметов в этом списке не присутствуют,
							-- но, на всякий случай, для них предусмотрен один сборный слот на все возможные iid

        					if _G.GetStoreItemTypeByDef( defName ) ~= _G.GameStore.ItemType.IT_MODULE then
								item = inStoreItems[ 1 ]
							end

    						if not item then

                    			item = {}

                    			item.itemType			= self.itemTypes.INVENTORY			
                    			item.defName			= defName
                    			item.shopItem			= nil
                    			item.equipShipItem		= nil
                    			item.slotId				= -1
                    			item.count				= 0
    							item.maxCount			= -1
    							item.inventoryItems		= {}
								item.countInInventory	= self:GetNumItemsInInventory( defName, bEnchanted )

    						end

    						item.count = item.count + inventoryItem.amount
    						table.insert( item.inventoryItems, inventoryItem )							

							table.insert( inStoreItems, item )

    					end

    				end	

				end				

			end				

		end


		-- экипированные ракеты не лежат в инвентаре, поэтому они собираются по кораблям	
		if _G.GetStoreItemTypeByDef( defName ) == _G.GameStore.ItemType.IT_ROCKET and not bEnchanted then

    		-- проверка фильтра, надо ли показывать вещи, установленные на других кораблях
			-- (#0036878 - флаг bHideOtherEquipped=false сейчас означает, что показываются утсановленные на других кораблях вещи,
			-- но не показываются вещи, установленные на том же корабле в другом слоте)

			if not filterInfo.bHideOtherEquipped then

				for idx = 1, #UI.serverData.ships do

					local shipItem = UI.serverData.ships[ idx ]
					if shipItem ~= self.selShipItem then

    					for slotId, ammoInfo in pairs( shipItem.equipAmmo ) do

    						-- аммуниция может быть "расстреляна" - количество 0; ее необходимо игнорировать
    						if ammoInfo.def == defName and ammoInfo.amount > 0 then

                    			local item = {}

                    			item.itemType			= self.itemTypes.INVENTORY			
                    			item.defName			= defName
                    			item.shopItem			= nil
                    			item.equipShipItem		= shipItem
                    			item.slotId				= slotId
                    			item.count				= ammoInfo.amount
    							item.maxCount			= -1
    							item.inventoryItems		= {}
								item.countInInventory	= self:GetNumItemsInInventory( defName, bEnchanted )

                    			table.insert( equipItems, item )

    						end

    					end
					end
				end
			end
		end
		
		
		-- автоген с данным дефом в инвентаре или установленный
		local autogenItem = not bEnchanted and UI.serverData.autogenInventoryByDef[ defName ]
		if autogenItem then

			-- находится корабль, на который модуль установлен
			local equipShipItem = UI:GetEquippedShipItem( autogenItem.iid )

			-- вещь установлена на корабль
			if equipShipItem then

				-- проверка фильтра, надо ли показывать вещи, установленные на других кораблях
				-- (#0036878 - флаг bHideOtherEquipped=false сейчас означает, что показываются утсановленные на других кораблях вещи,
				-- но не показываются вещи, установленные на том же корабле в другом слоте)

				if not filterInfo.bHideOtherEquipped and equipShipItem ~= self.selShipItem then

					-- из установленного в инвентаре могут быть только модули, установленные ракеты в инвентаре не лежат
					if _G.GetStoreItemTypeByDef( defName ) == _G.GameStore.ItemType.IT_MODULE then

						-- находится слот, в который модуль установлен
						local equipSlotId = -1	
						for slotId, iid in pairs( equipShipItem.equipModules ) do
							if iid == autogenItem.iid then
								equipSlotId = slotId
								break
							end
						end					

						local item = {}

						item.itemType			= self.itemTypes.INVENTORY			
						item.defName			= defName
						item.shopItem			= nil
						item.equipShipItem		= equipShipItem
						item.slotId				= equipSlotId
						item.count				= 1
						item.maxCount			= -1
						item.inventoryItems		= { autogenItem }
						item.countInInventory	= self:GetNumItemsInInventory( defName, bEnchanted )

						table.insert( equipItems, item )

					else
						sys.log( "UI.EquipmentWnd:MakeSubTreeItems()[ERROR]: equipped item in inventory is not IT_MODULE" )
					end
					
				end
				
			-- вещь не установлена на корабль, т.е. "на складе"
			else

				local item = {}

				item.itemType			= self.itemTypes.INVENTORY
				item.defName			= defName
				item.shopItem			= nil
				item.equipShipItem		= nil
				item.slotId				= -1
				item.count				= 1
				item.maxCount			= -1
				item.inventoryItems		= { autogenItem }
				item.countInInventory	= self:GetNumItemsInInventory( defName, bEnchanted )

				table.insert( inStoreItems, item )

			end

		end

		-- сортировка

		-- вещи на складе (отсортированы по iid)

		if next( inStoreItems ) then

        	if _G.GetStoreItemTypeByDef( defName ) == _G.GameStore.ItemType.IT_MODULE then

    			local function fnSort( item1, item2 )

					local inventoryItem1 = item1.inventoryItems[ 1 ]
					local inventoryItem2 = item2.inventoryItems[ 1 ]
  				
    				return inventoryItem1.iid < inventoryItem1.iid

    			end

    			table.sort( inStoreItems, fnSort )

			end

			for inStoreIdx, item in ipairs( inStoreItems ) do
				table.insert( items, item )
			end

		end

		-- если нет вещей на складе и данная вещь не является установленной в текущий слот, то первым показывается слот из магазина (если вещь в принципе покупаемая)

		if not next( inStoreItems ) and not bEnchanted and not filterInfo.bHideShop and not curItem then 

			if self:CanShowShopSlotForItem( defName ) then

    			local item = {}

    			item.itemType		= self.itemTypes.SHOP
    			item.defName		= defName
    			item.shopItem		= UI.serverData.shopByDef[ defName ]
    			item.equipShipItem	= nil
    			item.slotId			= -1
    			item.count			= -1
				item.maxCount		= -1
				item.inventoryItems	= {}
				item.countInInventory	= self:GetNumItemsInInventory( defName, bEnchanted )

                table.insert( items, item )

			end
		end

		-- далее показываются установленные вещи (отсортированные по кораблям, а корабли отсортированы по локализованному имени)
		if next( equipItems ) then
			table.sort( equipItems, SortEquipItemsPredicat )

			for idx = 1, #equipItems do
                table.insert( items, equipItems[ idx ] )
			end
		end

	end

end

-- количество неустановленных на корабли вещей данного дефа
function UI.EquipmentWnd:GetNumItemsInInventory( defName, bEnchanted )

	local selSlotId = self.selShipSlot and self.selShipSlot:GetSlotId() or -1
    local count = 0
	
	if UI:IsDefAutogen( defName ) then
	
		local inventoryItem = UI:GetAutogenInventoryItemByDef( defName )
		if inventoryItem and not UI:GetEquippedShipItem( inventoryItem.iid ) then
			count = 1
		end
	
	else

		local inventoryItemsByDef = UI.serverData.inventoryByDef[ defName ]
		if inventoryItemsByDef then

			for idx, inventoryItem in pairs( inventoryItemsByDef ) do

				if UI:IsInventoryItemEnchanted( inventoryItem ) == bEnchanted then

					local equipShipItem = UI:GetEquippedShipItem( inventoryItem.iid )
					if not equipShipItem then
					
						-- #0098460 - предметы, которые выставлены на продажу между игроками, не должны показываться больше нигде
						local bAdverted = UI:IsItemAdverted( inventoryItem.iid )
						if not bAdverted then
							count = count + inventoryItem.amount
						end
						
					end

				end

			end

		end
		
	end

	return count

end   


--
function UI.EquipmentWnd:TestItem( defName, shipSlot, filterInfo, curWeaponClass, curWeaponAmmoSubType )
	
	if UI:IsDefAutogenBase( defName ) then
		return false
	end

	-- не предназначен для экипировки
	if UI:CantItemBeEquippedByDef( defName ) then
		return false		
	end

	local itemType = self:IsShipSlotTypeAmmo( shipSlot:GetShipSlotType() ) and _G.GameStore.ItemType.IT_ROCKET or _G.GameStore.ItemType.IT_MODULE

	-- подходит тип товара (модуль/аммуниция)?
	if _G.GetStoreItemTypeByDef( defName ) ~= itemType then
		return false
	end

    local def = UI:GetDef( defName )
    if not def then
    	return false
    end

	-- если прописан единственный подходящий корабль, то проверка на него
	if not UI:IsItemFitForShipByRequiredShip( defName, self.selShipItem.defName ) then
		return false
	end

	-- подходит класс корабля?
	if not UI:IsItemFitForShipByClass( defName, self.selShipItem.defName ) then
		return false
	end

	-- подходит тир?
	if not UI:IsItemFitForShipByTierAndRank( defName, self.selShipItem.defName ) then
		return false
	end

	-- подходит раса?
	if not UI:IsItemFitForShipByRace( defName, self.selShipItem.defName ) then
		return false
	end

	-- подходит роль?
	if not UI:IsItemFitForShipByRole( defName, self.selShipItem.defName ) then
		return false
	end

	-- подходит слот?
	if itemType == _G.GameStore.ItemType.IT_ROCKET then

		local shopAmmoType = def.MunitionBayType or -1
		local shipSlotAmmoType = shipSlot:GetSlotId()

		if shopAmmoType ~= shipSlotAmmoType then
			return false
		end

	elseif itemType == _G.GameStore.ItemType.IT_MODULE then

		local shopItemModuleType = def.module_type or -1
		local shipSlotModuleId = shipSlot:GetSlotId()

		if ai.ModuleTypeOf[ shipSlotModuleId ] ~= shopItemModuleType then
    		return false
		end

	end

	-- для аммуниции основного оружия - проверка, подходит ли эта аммуниция к установленному на данный момент оружию
	if itemType == _G.GameStore.ItemType.IT_ROCKET and def.MunitionBayType == ai.MunitionBayType.MBT_PRIMARY then

		if def.weapon_class ~= curWeaponClass then
    		return false
		end

		-- елси 0 - значит этот параметр для данного оружия не используется
		if curWeaponAmmoSubType ~= 0 then
    		if def.item_subtype ~= curWeaponAmmoSubType then
        		return false
    		end
		end
		
	end

	-- подходит категория?
	if filterInfo.mainCategory ~= "" or filterInfo.subCategory ~= "" then
    	if not self:IsItemFitForCategory( defName, filterInfo.mainCategory, filterInfo.subCategory ) then
    		return false
    	end
	end

    local selSlotId = self.selShipSlot:GetSlotId()
    if ( selSlotId >= ai.SpaceShipModuleSlot.ACTIVE_01 and selSlotId <= ai.SpaceShipModuleSlot.CPU_MOD_03 and UI:IsItemUniqueEquip( defName ) ) then
		if UI:HasShipEquippedModuleOfSubType( self.selShipItem.vid, UI:GetItemSubType( defName ), selSlotId ) then
			return false
		end
	end

	-- для активных слотов один сабтайп может выставляться только в один слот
	if not self:IsItemSubTypeAvailable( UI:GetItemSubType( defName ) ) then
    	return false
	end

	return true

end


--
function UI.EquipmentWnd:IsItemFitForCategory( defName, mainCategory, subCategory )

    local def = UI:GetDef( defName )
    if not def then
    	return false
    end

	if def.shopCategory ~= mainCategory then
		return false
	end
	
	if subCategory ~= "" and def.shopSubCategory ~= subCategory then
		return false
	end

	return true

end


--
function UI.EquipmentWnd:F_OnEventMsgBoxRet( hSender, retCode, boxHandle )

	if not self:IsOnScreen() then
		return
	end

	if boxHandle == self.hMsgTimeOut then
		self.hMsgTimeOut = UI.INVALID_UI_HANDLE

	elseif boxHandle == self.hMsgRemoveItemFromOtherShip then
		self.hMsgRemoveItemFromOtherShip = UI.INVALID_UI_HANDLE

		if retCode == UI.MBRET_YES then

			if ( self.itemForQuickEquip and self.popMenuDataToEquip ) or ( not self.itemForQuickEquip and not self.popMenuDataToEquip ) then
				sys.log( "UI.EquipmentWnd:F_OnEventMsgBoxRet()[ERROR]: invalid data to equip" )

			else

    			if self.itemForQuickEquip then			
    				self:DoQuickEquip()

    			elseif self.popMenuDataToEquip then
					self:DoQuickEquipFromPopUp( self.popMenuDataToEquip )
					self.popMenuDataToEquip = nil
				end

    			UI:PlayGlobalSound( self.sounds.equip )

			end

		else
			self:ResetDD()
		end

	elseif boxHandle == self.hMsgUneqipAmmo then
		self.hMsgUneqipAmmo = UI.INVALID_UI_HANDLE

	elseif boxHandle == self.hMsgSetSpecModulePartsCollectingShip then

		self.hMsgSetSpecModulePartsCollectingShip = UI.INVALID_UI_HANDLE

		if retCode == UI.MBRET_YES then

			self:DoSetSpecModulePartsCollectingShip()
    		UI:PlayGlobalSound( self.sounds.setSpecModulePartsCollectingShip )

		end
		
	elseif boxHandle == self.hMsgAutogenDestroy then
	
		self.hMsgAutogenDestroy = UI.INVALID_UI_HANDLE
		
		if retCode == UI.MBRET_YES then
		
			if self.autogenIidToDestroy then
				self:DoDestroyAutogen( self.autogenIidToDestroy )
				self.autogenIidToDestroy = nil
			else
				sys.log( "UI.EquipmentWnd:F_OnEventMsgBoxRet no autogenIidToDestroy" )
			end
			
		end
		
	elseif boxHandle == self.hMsgAutogenEquipConfirm then
	
		self.hMsgAutogenEquipConfirm = UI.INVALID_UI_HANDLE
		
		if retCode == UI.MBRET_YES then
		
			if self.moduleToEquipData then
				self:EquipModuleInternal( self.moduleToEquipData.vid, self.moduleToEquipData.slotId, self.moduleToEquipData.iid, false )
				self.moduleToEquipData = nil
			else
				sys.log( "UI.EquipmentWnd:F_OnEventMsgBoxRet no moduleToEquipData" )
			end
		end
	
	end

end


--
function UI.EquipmentWnd:ShowMessageOnTimeOut()

	if self.hMsgTimeOut ~= UI.INVALID_UI_HANDLE then
		return
	end

	self.hMsgTimeOut = UI:ShowMessageOnTimeOut()

end


--
function UI.EquipmentWnd:IsItemAvailable( item )

	local bAvailable = true

	if item.itemType == self.itemTypes.INVENTORY then
    	bAvailable = not self:IsItemInBattle( item ) and not self:IsItemOnShipQuest( item )

	elseif item.itemType == self.itemTypes.SUB_TYPE then
		bAvailable = self:IsItemSubTypeAvailable( item.subType )

	elseif item.itemType == self.itemTypes.SPEC_MODULE then
    	bAvailable = not self:IsItemInBattle( item ) and not self:IsItemOnShipQuest( item )
	end

	return bAvailable

end


--
function UI.EquipmentWnd:IsItemSubTypeAvailable( subType )

	if self.selShipItem and self.selShipSlot and not self:IsShipSlotTypeAmmo( self.selShipSlot:GetShipSlotType() ) then

    	local selSlotId = self.selShipSlot:GetSlotId()
    	if ( selSlotId >= ai.SpaceShipModuleSlot.ACTIVE_01 and selSlotId <= ai.SpaceShipModuleSlot.ACTIVE_04 ) then

			if UI:HasShipEquippedModuleOfSubType( self.selShipItem.vid, subType, self.selShipSlot:GetSlotId() ) then
				return false
			end

    	end

	end

	return true

end


--
function UI.EquipmentWnd:IsSpecModuleUnlocked( defName )

	local bUnlocked = false

	local shipItem = self.selShipItem
	if not shipItem then
		return bUnlocked
	end

	if defName == UI:GetShipSpecModule( shipItem ) then

		bUnlocked = true

	else

		local specModuleLevel = UI:GetSpecModuleLevel( defName, shipItem.defName )
		if specModuleLevel ~= -1 then

			if specModuleLevel == 0 then
				bUnlocked = true
			else
				bUnlocked = specModuleLevel <= UI:GetShipUnlockedSpecModuleLevel( shipItem )
			end

		else
			sys.log( "UI.EquipmentWnd:IsSpecModuleUnlocked()[ERROR]: invalid spec module level" )
		end

	end

	return bUnlocked

end


--
function UI.EquipmentWnd:RecalcAbsVals()

	UI.FullScreenSelectionWnd.RecalcAbsVals( self )

	self.ddMouseThreshold_abs = UI:XToAbs( UI:XTo1024x768( self.DD_MOUSE_THRESHOLD, { x = 1280, y = 720 } ) )

end


--
function UI.EquipmentWnd:ResetDD()

	if self.ddInfo.ddState == self.ddStates.NONE then
		return
	end

	self.ddInfo.ddState		= self.ddStates.NONE
	self.ddInfo.shipSlot	= nil
	self.ddInfo.mouseX_abs	= 0
	self.ddInfo.mouseY_abs	= 0

	self.ddAcceptShipSlot = nil

	-- убирается подсветка слотов корабля
	for slotIdx, slotWnd in pairs( self.shipSlots ) do
		slotWnd:OnDDStop()
	end

	-- скрывается drag-and-drop иконка
	self.ddIco:Reset()
	self.ddIco:UnlinkFromParent()

	-- отаускается мышь
	self:ReleaseMouse()

end


--
function UI.EquipmentWnd:SetDDState_DRAG()

	if self.ddInfo.ddState ~= self.ddStates.WAIT_MOUSE then
		sys.log( "UI.EquipmentWnd:SetDDState_DRAG()[ERROR]: invalid states sequence" )
		return
	end

	self.ddInfo.ddState	= self.ddStates.DRAG

	-- показывается drag-and-drop иконка
	UI.Root:AddChild( self.ddIco )	-- линкуется к руту, т.к. д.б. поверх остальных чайлдов ангара, а не только эквипмента

	self.ddIco:SetupForShipSlot( self.ddInfo.shipSlot )

	self.ddIco:UpdatePos( UI:GetMouseX(), UI:GetMouseY() )


	-- подсветка подходящих слотов корабля
	for slotIdx, slotWnd in pairs( self.shipSlots ) do
		
		slotWnd:OnDDStart()

		if self:IsShipSlotDDFit( slotWnd ) then
			slotWnd:SetDDFit( true )
		end

	end	

	-- скрывается список предметов
	self:SelectShipSlot( nil )

	if self.sounds.ddStart and self.sounds.ddStart ~= "" then
		UI:PlayGlobalSound( self.sounds.ddStart )
	end

end 


--
function UI.EquipmentWnd:SetDDState_WAIT_MOUSE( shipSlot, mouseX, mouseY )

	if self.ddInfo.ddState ~= self.ddStates.NONE then
		sys.log( "UI.EquipmentWnd:SetDDState_WAIT_MOUSE()[ERROR]: invalid states sequence" )
		return
	end

	UI:ResetTooltip()

	self.ddInfo.ddState		= self.ddStates.WAIT_MOUSE
	self.ddInfo.mouseX_abs	= UI:XToAbs( mouseX )
	self.ddInfo.mouseY_abs	= UI:YToAbs( mouseY )
	self.ddInfo.shipSlot	= shipSlot

	self:CaptureMouse()

end


--
function UI.EquipmentWnd:IsShipSlotDDFit( slotWnd )

	if self.ddInfo.ddState == self.ddStates.NONE then
		return false
	end

	local ddDefName = self.ddInfo.shipSlot:GetDefName()
	return slotWnd ~= self.ddInfo.shipSlot and self:IsShipSlotFitForItem( ddDefName, slotWnd )

end


--
function UI.EquipmentWnd:IsShipSlotFitForItem( srcItemDefName, dstSlotWnd )

	if not dstSlotWnd:IsActive() then
		return false
	end

	local srcDef = UI:GetDef( srcItemDefName )
	if not srcDef then
		return false
	end

	local srcIsAmmo = UI:IsDefAmmo( srcItemDefName )

	if srcIsAmmo then
		return false

	else

		if self:IsShipSlotTypeAmmo( dstSlotWnd:GetShipSlotType() ) then
			return false

		else
    		local srcModuleType = srcDef.module_type or -1
			local dstSlotModuleId = dstSlotWnd:GetSlotId()

    		return ai.ModuleTypeOf[ dstSlotModuleId ] == srcModuleType
		end

	end

end



--
function UI.EquipmentWnd:CaptureMouse()

	self:RemoveStyle( UI.WS_NOT_MOUSE_REACT )
	UI:CaptureMouse( self:GetUiHandle() )

end


--
function UI.EquipmentWnd:ReleaseMouse()

	if UI:GetMouseCapture() == self:GetUiHandle() then
		UI:CaptureMouse( UI.INVALID_UI_HANDLE )
	end

	self:AddStyle( UI.WS_NOT_MOUSE_REACT )

end


--
function UI.EquipmentWnd:UpdateAcceptSlot( mouseX, mouseY )

	local acceptSlotWnd = nil

	local slotWnd = self:GetShipSlotUnderMouse( mouseX, mouseY )
	if slotWnd and slotWnd:IsDDFit() then
		acceptSlotWnd = slotWnd
	end

	self:SetAcceptShipSlot( acceptSlotWnd )

end


--
function UI.EquipmentWnd:SetAcceptShipSlot( slotWnd )

	if slotWnd == self.ddAcceptShipSlot then
		return
	end

	local oldAcceptSlot = self.ddAcceptShipSlot
	self.ddAcceptShipSlot = slotWnd

	if oldAcceptSlot then
		oldAcceptSlot:SetDDAccept( false )
	end

	if self.ddAcceptShipSlot then
		self.ddAcceptShipSlot:SetDDAccept( true )
	end

end


--
function UI.EquipmentWnd:GetShipSlotUnderMouse( mouseX, mouseY )

	for slotIdx, slotWnd in pairs( self.shipSlots ) do
		if slotWnd:IsVisible() and UI:IsPtInRect( slotWnd:GetRect(), mouseX, mouseY ) then
			return slotWnd
		end
	end

	return nil

end


--
function UI.EquipmentWnd:TryEquipDDItem()

    self:EquipSlot2Slot( self.ddInfo.shipSlot, self.ddAcceptShipSlot )

    self:ResetDD()		

end


--
function UI.EquipmentWnd:TryUnequipDDItem()

	local isAmmo = self:IsShipSlotTypeAmmo( self.ddInfo.shipSlot:GetShipSlotType() )

	if isAmmo then
		self:UnequipAmmoInternal( self.selShipItem.vid, self.ddInfo.shipSlot:GetSlotId() )
	else
		self:UnequipModuleInternal( self.selShipItem.vid, self.ddInfo.shipSlot:GetSlotId() )
	end

	self:ResetDD() 

end


--
function UI.EquipmentWnd:UnequipModuleInternal( vid, slotId )

	local iid = UI:GetShipItem( vid, false ).equipModules[ slotId ]
	if UI:GetAutogenInventoryItem( iid ) then
	
		UI.AutogenUnequipWnd:Setup( { { iid = iid, actions = UI.AutogenUnequipWnd.actions.DESTROY + UI.AutogenUnequipWnd.actions.DISMNANTLE } }, UI.AutogenUnequipWnd.cancelModes.BREAK, self:GetName(), {} )
		UI.AutogenUnequipWnd:Show()
		return
		
	end

	local requestId, bForbidden = UI:SafeChangeEquipment( vid, slotId, UI.INVALID_U64_ID )

	if requestId ~= 0 then

		UI:AddWaitingRequest( requestId )
		UI:AddWaitingRequest( UI.INVENTORY_REQUEST_ID ) -- ждем апдейта инвентаря, который будет вызван из кода cpp

    	if slotId == ai.SpaceShipModuleSlot.PRIMARY_WEAPON_01 then
    		self:CheckShowMsgOnUnequipPrimaryAmmo( UI:GetShipItem( vid ), ai.WeaponClass.UNKNOWN )
    	end

	elseif not bForbidden then
		UI:ShowMessageOnEquipError( _G.GameStore.ModuleEquipResult.MER_ERROR )
	end

end


--
function UI.EquipmentWnd:UnequipAmmoInternal( vid, slotId )

	local requestId, bForbidden = UI:SafeChangeMunition( vid, slotId, _G.GameStore.CreditsType.CT_INVALID, "" )

	if requestId ~= 0 then
		UI:AddWaitingRequest( requestId )
		UI:AddWaitingRequest( UI.INVENTORY_REQUEST_ID ) -- ждем апдейта инвентаря, который будет вызван из кода cpp
	elseif not bForbidden then
		UI:ShowMessageOnChangeMunitionError( _G.GameStore.MunitionResult.MR_ERROR )
	end

end


--
function UI.EquipmentWnd:TryQuickEquip( item )

	if not self.selShipSlot then
		UI:PlayGlobalSound( self.sounds.cannotEquip )
		return
	end

	if not self:IsItemAvailable( item ) then
		UI:PlayGlobalSound( self.sounds.cannotEquip )
		return
	end

	local bBuy = item.itemType == self.itemTypes.SHOP or ( item.itemType == self.itemTypes.INVENTORY and item.count < item.maxCount )

	-- уже экипировано в выделенный слот?
	if not bBuy and item.equipShipItem == self.selShipItem and item.slotId == self.selShipSlot:GetSlotId() then
		UI:PlayGlobalSound( self.sounds.cannotEquip )
		return
	end

	if bBuy then

		self:TryBuy( self.selShipItem, item.shopItem, self.selShipSlot:GetSlotId() )

	else

		self.itemForQuickEquip = item
	
    	if item.equipShipItem and item.equipShipItem ~= self.selShipItem then
    		self:ShowRequestTranspherFromOtherShipMsg( item.defName, item.equipShipItem.defName )
    	else
    		self:DoQuickEquip()
			UI:PlayGlobalSound( self.sounds.equip )
		end

	end

end


--
function UI.EquipmentWnd:TryBuy( equipShipItem, shopItem, slotId )

    self.buyInfo =
    {
		shopItem	= shopItem,
    	shipItem	= equipShipItem,
    	slotId		= slotId,
    	boughtIid	= UI.INVALID_U64_ID,
    }		

	if UI:IsEnoughPlaceInInventoryForItem( shopItem.defName ) then
		self:LaunchTradeWnd( shopItem, false )
	else
		if UI:CanIncreaseInventory() then
			self:LaunchBuyWnd( UI.Equipment_BuyWnd.modes.INVENTORY_AUTO )
		else
			UI:MessageBox( UI:GetStringByName( "buyInventory_caption_AUTO" ), UI:GetStringByName( "msg_cannotIncreaseInventory_AUTO" ), UI.MBS_OK )
		end
	end

end


--
function UI.EquipmentWnd:DoQuickEquip()

	if not self.itemForQuickEquip then
		sys.log( "UI.EquipmentWnd:DoQuickEquip()[ERROR]: no item" )
		return
	end

	local item = self.itemForQuickEquip
	self.itemForQuickEquip = nil

	if not self.selShipSlot then
		sys.log( "UI.EquipmentWnd:DoQuickEquip()[ERROR]: no sel slot" )
		return
	end

	self:EquipItem2Slot( item, self.selShipSlot )

	if self:GetOpenItemsSubType() ~= -1 then
		self:OpenItemsSubType( -1, -1, true )
	end

end


--
function UI.EquipmentWnd:DoQuickEquipFromPopUp( data )

	local bAmmo = UI:IsDefAmmo( data.defName )
	if bAmmo then
		self:EquipAmmoInternal( data.defName, data.dstVid, data.dstSlotId, data.srcVid, data.srcSlotId )
	else
		self:EquipModuleInternal( data.dstVid, data.dstSlotId, data.iid )
	end

	if self:GetOpenItemsSubType() ~= -1 then
		self:OpenItemsSubType( -1, -1, true )
	end	

end


--
function UI.EquipmentWnd:EquipItem2Slot( srcItem, dstShipSlot )

	if _G.GetStoreItemTypeByDef( srcItem.defName ) == _G.GameStore.ItemType.IT_ROCKET then
		self:EquipAmmoItem2Slot( srcItem, dstShipSlot )
	else
		self:EquipModuleItem2Slot( srcItem, dstShipSlot )
	end

end


--
function UI.EquipmentWnd:EquipSlot2Slot( srcShipSlot, dstShipSlot )

	if self:IsShipSlotTypeAmmo( srcShipSlot:GetShipSlotType() ) then
		sys.log( "UI.EquipmentWnd:EquipSlot2Slot()[ERROR]: cannot equip ammo slot from slot" )
	else
		self:EquipModuleSlot2Slot( srcShipSlot, dstShipSlot )
	end

end


--
function UI.EquipmentWnd:EquipAmmoItem2Slot( srcItem, dstShipSlot )

	if srcItem.defName == dstShipSlot:GetDefName() and dstShipSlot:GetCount() > 0 then
		return
	end

	self:EquipAmmoInternal( srcItem.defName, self.selShipItem.vid, dstShipSlot:GetSlotId(), srcItem.equipShipItem and srcItem.equipShipItem.vid or UI.INVALID_U64_ID, srcItem.equipShipItem and srcItem.slotId or -1 )

end 


--
function UI.EquipmentWnd:EquipAmmoInternal( defName, dstVid, dstSlotId, srcVid, srcSlotId )

	local bShowGoldAmmoWarning = false

	if UI:IsTrueEx( UI.serverData.userData.autoRefill ) then

    	local price, bGold = UI:GetShopBaseBuyPriceByDef( defName, false )
    	if bGold then
    		bShowGoldAmmoWarning = true
    	end

	end

	if srcVid ~= nil and srcVid ~= UI.INVALID_U64_ID then

		local requestId, bForbidden = UI:SafeTransferMunition( srcVid, dstVid, srcSlotId, dstSlotId )

		if requestId ~= 0 then
			UI:AddWaitingRequest( requestId )
    	  	UI:AddWaitingRequest( UI.INVENTORY_REQUEST_ID )	-- ждем апдейта инвентаря, который будет вызван из кода cpp
		else
			if not bForbidden then
				UI:ShowMessageOnChangeMunitionError( _G.GameStore.MunitionResult.MR_ERROR )
			end
			bShowGoldAmmoWarning = false
		end

	else

    	local priceType = UI:GetShopSmartBuyPriceOneByDef( defName )
		local requestId, bForbidden = UI:SafeChangeMunition( dstVid, dstSlotId, priceType, defName )

		if requestId ~= 0 then
			UI:AddWaitingRequest( requestId )
    	  	UI:AddWaitingRequest( UI.INVENTORY_REQUEST_ID )	-- ждем апдейта инвентаря, который будет вызван из кода cpp
		else
			if not bForbidden then
				UI:ShowMessageOnChangeMunitionError( _G.GameStore.MunitionResult.MR_ERROR )
			end
			bShowGoldAmmoWarning = false
		end

	end	

	if bShowGoldAmmoWarning then
		UI:MessageBox( UI:GetStringByName( "msgCapt_warning" ), UI:GetStringByName( "goldAmmoWarning" ), UI.MBS_OK )
	end

end


--
function UI.EquipmentWnd:EquipModuleItem2Slot( srcItem, dstShipSlot )

	local idx, inventoryItem = next( srcItem.inventoryItems )
	local iid = inventoryItem.iid

	self:EquipModuleInternal( self.selShipItem.vid, dstShipSlot:GetSlotId(), iid )

end


--
function UI.EquipmentWnd:EquipModuleInternal( vid, slotId, iid, bShowAutogenEquipConfirm )

	if bShowAutogenEquipConfirm == nil then
		bShowAutogenEquipConfirm = true
	end

	local oldEquipShip = UI:GetEquippedShipItem( iid )
	local newEquipShip = UI:GetShipItem( vid, false )
	
	-- SC-112719 перед установкой автоген предупреждаем о том, что за его снятие потом потребуются деньги
	if bShowAutogenEquipConfirm then
	
		if iid ~= UI.INVALID_U64_ID and UI:GetAutogenInventoryItem( iid ) and oldEquipShip ~= newEquipShip then
		
			self.hMsgAutogenEquipConfirm = UI:MessageBox( UI:GetStringByName( "msgCapt_actionConfirm" ), UI:GetStringByName( "msg_autogenEquipConfirm" ), UI.MBS_YES_NO )
			self.moduleToEquipData = { vid = vid, slotId = slotId, iid = iid }
			return
			
		end
	
	end

	-- автоген нельзя просто снять, переместить на другой корабль, снять при замещении другим модулем (можно только переставлять из слота в слот на одном корабле);
	-- если модуль надо предварительно снять, или снять тот, на место которого мы ставим, то показываем для них специальное окно
	local autogenItemsToUnequip = {}
	
	if oldEquipShip ~= newEquipShip then
	
		if iid ~= UI.INVALID_U64_ID and UI:GetAutogenInventoryItem( iid ) and oldEquipShip then
			table.insert( autogenItemsToUnequip, { iid = iid, actions = UI.AutogenUnequipWnd.actions.DISMNANTLE } )
		end
		
		local iidOnNewShip = newEquipShip.equipModules[ slotId ]
		if iidOnNewShip ~= UI.INVALID_U64_ID and UI:GetAutogenInventoryItem( iidOnNewShip ) then
			table.insert( autogenItemsToUnequip, { iid = iidOnNewShip, actions = UI.AutogenUnequipWnd.actions.DESTROY + UI.AutogenUnequipWnd.actions.DISMNANTLE } )
		end
	
	end
	
	if next( autogenItemsToUnequip ) then
		UI.AutogenUnequipWnd:Setup( autogenItemsToUnequip, UI.AutogenUnequipWnd.cancelModes.BREAK, self:GetName(), { fnName = "EquipModuleInternal", params = { vid, slotId, iid, false } } )
		UI.AutogenUnequipWnd:Show()
		return
	end
	
	local bSuccess = false

	-- модуль не был экипирован
	if not oldEquipShip then

		local requestId, bForbidden = UI:SafeChangeEquipment( vid, slotId, iid )

		if requestId ~= 0 then
			UI:AddWaitingRequest( requestId )
    	  	UI:AddWaitingRequest( UI.INVENTORY_REQUEST_ID )	-- ждем апдейта инвентаря, который будет вызван из кода cpp
			bSuccess = true
		elseif not bForbidden then
			UI:ShowMessageOnEquipError( _G.GameStore.ModuleEquipResult.MER_ERROR )
		end

	-- модуль был экипирован
	else
  		-- снятие тащимого модуля со старого корабля и установка на новый

		local oldSlotId = -1

		for slotId, moduleIid in pairs( oldEquipShip.equipModules ) do
			if moduleIid == iid then
				oldSlotId = slotId
				break
			end
		end

		local requestId, bForbidden = UI:SafeTransferEquipment( oldEquipShip.vid, vid, oldSlotId, slotId )

		if requestId ~= 0 then
			UI:AddWaitingRequest( requestId )
    	  	UI:AddWaitingRequest( UI.INVENTORY_REQUEST_ID )	-- ждем апдейта инвентаря, который будет вызван из кода cpp
			bSuccess = true
		elseif not bForbidden then
			UI:ShowMessageOnEquipError( _G.GameStore.ModuleEquipResult.MER_ERROR )
		end	

	end

	if slotId == ai.SpaceShipModuleSlot.PRIMARY_WEAPON_01 and bSuccess then

		if oldEquipShip then
			self:CheckShowMsgOnUnequipPrimaryAmmo( oldEquipShip, ai.WeaponClass.UNKNOWN )
		end

		local invItem = UI:GetInventoryItemEx( iid )
		self:CheckShowMsgOnUnequipPrimaryAmmo( UI:GetShipItem( vid ), UI:GetWeaponClass( invItem.defName ) )

	end

end


--
function UI.EquipmentWnd:EquipModuleSlot2Slot( srcShipSlot, dstShipSlot )

	self.equipTransferInfo = nil

	local requestId, bForbidden = UI:SafeTransferEquipment( self.selShipItem.vid, self.selShipItem.vid, srcShipSlot:GetSlotId(), dstShipSlot:GetSlotId() )
	if requestId ~= 0 then

		UI:AddWaitingRequest( requestId )
		UI:AddWaitingRequest( UI.INVENTORY_REQUEST_ID )	-- ждем апдейта инвентаря, который будет вызван из кода cpp

		self.equipTransferInfo = { slotType = dstShipSlot:GetShipSlotType(), slotId = dstShipSlot:GetSlotId() }

	elseif not bForbidden then
		UI:ShowMessageOnEquipError( _G.GameStore.ModuleEquipResult.MER_ERROR )
	end

end


--
function UI.EquipmentWnd:EquipBoughtModule( buyInfo )

	local oldIidInSlot = buyInfo.shipItem.equipModules[ buyInfo.slotId ]
	if oldIidInSlot ~= UI.INVALID_U64_ID and UI:GetAutogenInventoryItem( oldIidInSlot ) then
	
		UI.AutogenUnequipWnd:Setup( { { iid = oldIidInSlot, actions = UI.AutogenUnequipWnd.actions.DESTROY + UI.AutogenUnequipWnd.actions.DISMNANTLE } }, UI.AutogenUnequipWnd.cancelModes.BREAK, self:GetName(), { fnName = "EquipBoughtModule", params = { buyInfo } } )
		UI.AutogenUnequipWnd:Show()
		return
		
	end

	local changeEquipmentRequestId, bForbidden = UI:SafeChangeEquipment( buyInfo.shipItem.vid, buyInfo.slotId, buyInfo.boughtIid )
	if changeEquipmentRequestId ~= 0 then

		UI:AddWaitingRequest( changeEquipmentRequestId )
		UI:AddWaitingRequest( UI.INVENTORY_REQUEST_ID ) -- ждем апдейта инвентаря, который будет вызван из кода cpp

		if buyInfo.slotId == ai.SpaceShipModuleSlot.PRIMARY_WEAPON_01 then
			self:CheckShowMsgOnUnequipPrimaryAmmo( buyInfo.shipItem, UI:GetWeaponClass( self.buyInfo.shopItem.defName ) )
		end

		if self:GetOpenItemsSubType() ~= -1 then
			self:OpenItemsSubType( -1, -1, true )
		end
		
	end

end


--
function UI.EquipmentWnd:CheckShowMsgOnUnequipPrimaryAmmo( shipItem, dstWeaponClass )

	local bHasPrimaryAmmo = false

	local primaryAmmoInfo = shipItem.equipAmmo[ ai.MunitionBayType.MBT_PRIMARY ]
	if primaryAmmoInfo and primaryAmmoInfo.def ~= "" and primaryAmmoInfo.amount > 0 then
		bHasPrimaryAmmo = true
	end

	if not bHasPrimaryAmmo then
		return
	end

	local ammoWeaponClass = UI:GetWeaponClass( primaryAmmoInfo.def )
	if ammoWeaponClass == dstWeaponClass then
		return
	end

   	if self.hMsgUneqipAmmo == UI.INVALID_UI_HANDLE then
   		self.hMsgUneqipAmmo = UI:MessageBox( UI:GetStringByName( "msgCapt_warning" ), UI:GetStringByName( "msg_unfitModsDrop" ), UI.MBS_OK )
   	end

end       


-- TODO: найти замену - собственно invItems не используются
function UI.EquipmentWnd:F_OnEventInvItemsChanged()

	if not self:IsOnScreen() then
		return
	end

	self:ResetDD()

	local bLockItemsUpdate_old = self.bLockItemsUpdate
	self.bLockItemsUpdate = true

	local bLockBuyBundleHide_old = self.bLockBuyBundleHide
	self.bLockBuyBundleHide = true
	
	local bLockAutogenUnequipHide_old = self.bLockAutogenUnequipHide
	self.bLockAutogenUnequipHide = true

	local slotToSelect = self.selShipSlot	
	self:UpdateShipSlots()
	
	if self.equipTransferInfo then
		local bAmmo = self:IsShipSlotTypeAmmo( self.equipTransferInfo.slotType )
		slotToSelect = bAmmo and self:GetShipSlotForAmmoId( self.equipTransferInfo.slotId ) or self:GetShipSlotForModuleId( self.equipTransferInfo.slotId )
		self.equipTransferInfo = nil
	end

	self:ValidateShipSlotSelection( slotToSelect )

	self.bLockItemsUpdate = bLockItemsUpdate_old
	self:UpdateItems( true )

	self.bLockBuyBundleHide = bLockBuyBundleHide_old
	self.bLockAutogenUnequipHide = bLockAutogenUnequipHide_old
	
	if UI.EquipmentShipMainParamsWnd:IsChildOf( self ) then
		UI.EquipmentShipMainParamsWnd:OnEventInvItemsChanged()
	end
	
	if UI.EquipmentShipSurvivabilityWnd:IsChildOf( self ) then
		UI.EquipmentShipSurvivabilityWnd:OnEventInvItemsChanged()
	end
	
	if UI.EquipmentShipParamsWnd:IsChildOf( self ) then
		UI.EquipmentShipParamsWnd:OnEventInvItemsChanged()
	end

end


--
function UI.EquipmentWnd:ShowRequestTranspherFromOtherShipMsg( itemDefName, shipDefName )

	local strBaseColor = UI:Color2Str( UI.TEXT_BASE_COLOR )

	local shipName = UI:GetEntityLocalizedNameByDef( shipDefName, true )
	shipName = string.format( "\"%s\"%s", shipName, strBaseColor )

	local itemName = UI:GetEntityLocalizedNameByDef( itemDefName, true )
	itemName = string.format( "\"%s\"%s", itemName, strBaseColor )

	local tags =
	{
		ship	= shipName,
		item	= itemName,
	}

	local msg = UI:GetStringByName( "equip_msg_itemRemove" )
	msg = string.gsub( msg, "%$([%w_]+)%$", tags )			
	msg = string.format( "%s%s", strBaseColor, msg )

	self.hMsgRemoveItemFromOtherShip = UI:MessageBox( UI:GetStringByName( "equip_msgCapt_itemRemove" ), msg, UI.MBS_YES_NO )

end


--
function UI.EquipmentWnd:IsWaitingRequests()

	return
		UI:IsWaitingRequests()
		or self.vesselBudgetActivateRequestId ~= 0
		or self.vesselBudgetLevelUpRequestId ~= 0
		or self.recraftVesselRequestId ~= 0

end


--
function UI.EquipmentWnd:UpdateWaitEquipmentEffect()

	if self:IsWaitingRequests() then
		self.itemsListWnd:SetWaitEffectVisible( true )
	else
		self.itemsListWnd:SetWaitEffectVisible( false )
	end

end


--
function UI.EquipmentWnd:F_OnEventStartWaitingRequests()

	if not self:IsOnScreen() then
		return
	end

	self:UpdateWaitEquipmentEffect()

end


--
function UI.EquipmentWnd:F_OnEventStopWaitingRequests()

	if not self:IsOnScreen() then
		return
	end

	self:UpdateWaitEquipmentEffect()

end


--
function UI.EquipmentWnd:HandleTooltip( targetWnd, tooltipData )

	if self.ddInfo.ddState ~= self.ddStates.NONE then
		return true, UI.INVALID_UI_HANDLE
	end

	return UI.FullScreenSelectionWnd.HandleTooltip( self, targetWnd, tooltipData )

end


--
function UI.EquipmentWnd:ValidateShipSlotSelection( oldSelShipSlot )

	if not self.selShipItem then
		self:SelectShipSlot( nil )
		return
	end

	local bInBattle = UI:IsShipInBattle( self.selShipItem ) or UI:IsShipOnShipQuest( self.selShipItem )
	if bInBattle then
		self:SelectShipSlot( nil )
		return
	end

	if oldSelShipSlot and oldSelShipSlot:IsActive() then
		self:SelectShipSlot( oldSelShipSlot )
		return
	end

	self:SetDefaultShipSlotSelection()

end


--
function UI.EquipmentWnd:SetDefaultShipSlotSelection()

	self:SelectShipSlot( nil )

end


--
function UI.EquipmentWnd:CanShipSlotBeSelected( slotWnd )

	if not slotWnd then
		sys.log( "UI.EquipmentWnd:CanShipSlotBeSelected()[ERROR]: nil param" )
		return true
	end

    if not slotWnd:IsActive() then
		return false
	end

	local bInBattle = self.selShipItem and ( UI:IsShipInBattle( self.selShipItem ) or UI:IsShipOnShipQuest( self.selShipItem ) )
	if bInBattle then
		return false
	end

	if self:IsWaitingRequests() then
		return false
	end

	if slotWnd:GetShipSlotType() == UI.shipSlotTypes.SPECIAL then
		if not UI:IsSpecModuleCustomizableOnShip( self.selShipItem.defName ) then
			return false
		end
	end

	return true

end


--
function UI.EquipmentWnd:SelectShipSlot( shipSlot )

	if self.selShipSlot == shipSlot then
		return
	end

	local oldSelShipSlot = self.selShipSlot
	self.selShipSlot = shipSlot

	if oldSelShipSlot then
		oldSelShipSlot:Select( false )
	end

	if self.selShipSlot then
		self.selShipSlot:Select( true )
	end	

	self:OnShipSlotSelectionChanged()

end


--
function UI.EquipmentWnd:OnShipSlotSelectionChanged()

	self:UpdateItemsPanelVisibility()

	if self:IsItemsPanelVisible() then

		self:UpdateItems( false )
		
	end

	if self.itemsListWnd:IsOnScreen() and self.selShipSlot and UI:GetCurTooltipTarget() == self.selShipSlot then
		UI:ResetTooltip()
	end

	if self.selShipSlot and not self:IsShipSlotTypeAmmo( self.selShipSlot:GetShipSlotType() ) then
		_G.DirectHangarCameraToModule( UI.HangarWnd:GetSelShipEntId(), self.selShipSlot:GetSlotId() )
	end

end


--
function UI.EquipmentWnd:ResetBuyInfo()

    self.buyInfo =
    {
    	shopItem	= nil,
    	shipItem	= nil,
    	slotId		= -1,
    	boughtIid	= UI.INVALID_U64_ID,
    }

end


--
function UI.EquipmentWnd:IsItemCurrent( item )

	local bCurrent = false

	if item.itemType == self.itemTypes.SUB_TYPE then

		local subtreeItems = self:GetSubtreeItems( item )
		for idx, subtreeItem in pairs( subtreeItems ) do
			if self:IsItemCurrent( subtreeItem ) then
				bCurrent = true
				break
			end
		end

	elseif item.itemType == self.itemTypes.INVENTORY then

    	bCurrent =
    		self.selShipItem
    		and self.selShipSlot
    		and item.equipShipItem == self.selShipItem
    		and item.slotId == self.selShipSlot:GetSlotId()

	elseif item.itemType == self.itemTypes.SPEC_MODULE then

		bCurrent =
			self.selShipItem
			and UI:GetShipSpecModule( self.selShipItem ) == item.defName

	end

	return bCurrent

end


--
function UI.EquipmentWnd:UpdateItemsCaption()

	local text = ""

	local openSubType = self:GetOpenItemsSubType()
	if openSubType ~= -1 then

		if type( openSubType ) == "string" then
			text = UI:GetEntityLocalizedNameByDef( openSubType, true, false, true )
		else
			text = UI:ItemSubType2Str2( openSubType )
		end

	else
    	if self.selShipSlot then

    		local shipSlotType = self.selShipSlot:GetShipSlotType()

    		local shipSlotTypeName = UI:Val2Key( UI.shipSlotTypes, shipSlotType )
    		text = UI:GetStringByName( string.format( "equipSlot_%s_tipCaption", shipSlotTypeName ) )

    	end
	end	

	self.itemsListWnd:SetCaption( text )

end


--
function UI.EquipmentWnd:GetCurWeaponClass()

	local curWeaponClass = ai.WeaponClass.UNKNOWN

	local slotWnd = self:GetShipSlotForModuleId( ai.SpaceShipModuleSlot.PRIMARY_WEAPON_01 )
	if slotWnd and slotWnd:IsActive() then

		local defName = slotWnd:GetDefName()
		if defName ~= "" then
		   	curWeaponClass = UI:GetWeaponClass( defName )
		end

	end

	return curWeaponClass

end


--
function UI.EquipmentWnd:GetCurWeaponAmmoSubType()

	local curWeaponAmmoSubType = -1

	local slotWnd = self:GetShipSlotForModuleId( ai.SpaceShipModuleSlot.PRIMARY_WEAPON_01 )
	if slotWnd and slotWnd:IsActive() then

		local defName = slotWnd:GetDefName()
		if defName ~= "" then
		   	curWeaponAmmoSubType = UI:GetWeaponAmmoSubType( defName )	-- если без разницы, то вернет 0
		end

	end

	return curWeaponAmmoSubType

end


--
function UI.EquipmentWnd:IsItemInBattle( item )

	local bInBattle = false

	if item.itemType == UI.EquipmentWnd.itemTypes.INVENTORY then

    	if item.equipShipItem then
    		bInBattle = UI:IsShipInBattle( item.equipShipItem )
    	end

	elseif item.itemType == self.itemTypes.SPEC_MODULE then
    	bInBattle = UI:IsShipInBattle( self.selShipItem )
	end

	return bInBattle

end


--
function UI.EquipmentWnd:IsItemOnShipQuest( item )

	return self:GetItemShipQuest( item ) ~= -1

end


--
function UI.EquipmentWnd:GetItemShipQuest( item )

	local questId = -1

	if item.itemType == UI.EquipmentWnd.itemTypes.INVENTORY then

    	if item.equipShipItem then
    		questId = UI:GetShipQuestForShip( item.equipShipItem )
    	end		

	elseif item.itemType == self.itemTypes.SPEC_MODULE then
		questId = UI:GetShipQuestForShip( self.selShipItem )
	end

	return questId

end


--
function UI.EquipmentWnd:UpdateItemsPanelVisibility()

	local bInBattle = self.selShipItem and ( UI:IsShipInBattle( self.selShipItem ) or UI:IsShipOnShipQuest( self.selShipItem ) )

	local bNeedVisible = self.selShipItem and self.selShipSlot and not bInBattle
	local bIsVisible = self:IsItemsPanelVisible()

	if bNeedVisible and not bIsVisible then
		self:ShowItemsPanel()

	elseif not bNeedVisible and bIsVisible then
		self:HideItemsPanel()
	end	

end


--
function UI.EquipmentWnd:HideItemsPanel()

	self.itemsListWnd:UnlinkFromParent()
	self:HideChildModals()

end


--
function UI.EquipmentWnd:ShowItemsPanel()

	self:AddChild( self.itemsListWnd )

	self:UpdateItems( false )

end


--
function UI.EquipmentWnd:IsItemsPanelVisible()

	return self.itemsListWnd:IsChildOf( self )

end


--
function UI.EquipmentWnd:LaunchTradeWnd( item, bSell )

	if bSell then
		UI.Equipment_TradeWnd:SetupForSell( item )
	else
		UI.Equipment_TradeWnd:SetupForBuy( item, true, nil )
	end

	UI.Equipment_TradeWnd:Show()
	UI:PlayGlobalSound( self.sounds.tradeWndShow )

end


--
function UI.EquipmentWnd:LaunchBuyWnd( mode, data )

	UI.Equipment_BuyWnd:Setup( mode, nil, data )
	UI.Equipment_BuyWnd:Show()
	UI:PlayGlobalSound( self.sounds.tradeWndShow )

end


--
function UI.EquipmentWnd:LaunchSalvageWnd( iid )

	UI.Equipment_SalvageWnd:Setup( iid )
	UI.Equipment_SalvageWnd:Show()
	UI:PlayGlobalSound( self.sounds.tradeWndShow )

end


--
function UI.EquipmentWnd:LaunchSalvage2Wnd( iid )

	local data =
	{
		price	= 0,
		bGold	= false,
		iid		= iid,
	}

	self:LaunchBuyWnd( UI.BuyWnd.modes.SALVAGE, data )

end


--
function UI.EquipmentWnd:LaunchUpgradeItemWnd( iid, bInShipSlot )

	local slotId = -1

	if self.selShipSlot then
		slotId = self.selShipSlot:GetSlotId()
	else
		slotId = UI:GetEquippedSlot( iid )
	end

	if slotId == -1 then
		sys.log( "UI.EquipmentWnd:LaunchUpgradeItemWnd()[ERROR]: cannot find slot for compare info" )
	end
                                                                           	
	UI.Equipment_UpgradeItemWnd:Setup( iid, self:GetSelShipItem().vid, slotId, true, { bInShipSlot = bInShipSlot } )
	UI.Equipment_UpgradeItemWnd:Show()
	UI:PlayGlobalSound( self.sounds.tradeWndShow )

end


--
function UI.EquipmentWnd:LaunchAutogenUpgradeWnd( iid )

	UI.AutogenUpgradeWnd:Setup( iid, self:GetName() )
	UI.AutogenUpgradeWnd:Show()
	UI:PlayGlobalSound( self.sounds.tradeWndShow )

end


--
function UI.EquipmentWnd:ShowBuyErrorMsg( result )

	-- #0056553, комм.(0228526)
	if result == _G.GameStore.StoreBuyResult.SBR_NO_DISCOUNT then
		return
	end

	local msg = UI:GetStringByName( "msg_buyError" )

	local resultName = UI:Val2Key( _G.GameStore.StoreBuyResult, result )
	local resultStr = UI:GetStringByName( string.format( "buyError_%s", resultName ) )
	
	msg = string.format( msg, resultStr )
	UI:MessageBox( UI:GetStringByName( "msgCapt_error" ), msg, UI.MBS_OK )

end


--
function UI.EquipmentWnd:UpdateShipSlotsControlsVisibility()
	
	self:SetLayerVisible( true, self.layers.SHIP_SLOTS_EFFECT )
	
	local bHasPassiveSlots = false

	for slotTypeName, slotType in pairs( UI.shipSlotTypes ) do

		local bHasSlotOfType = self:HasShipSlotsOfType( slotType )

		local labelLayer = self:GetLabelLayerForShipSlotType( slotType )
		if labelLayer ~= -1 then
			self:SetLayerVisible( bHasSlotOfType, labelLayer )
		end
		
		if slotType == UI.shipSlotTypes.AUTOGEN then
		
			self:SetLayerVisible( bHasSlotOfType, self.layers.SHIP_SLOTS_AUTOGEN_EFFECT )
			
			if bHasSlotOfType then
				-- перед текстом рисуется иконка с тултипом
				local strLink = string.format( "$link [type CUSTOM_EFFECT] [params {effectName=\"helpBtn\", colorSel=UI.WHITE_COLOR, colorUnsel=UI.WHITE_COLOR, tooltipTextId=\"equipSlot_AUTOGEN_tooltipText\", tooltipCaptionId=\"equipSlot_AUTOGEN_tooltipCaption\"}]$" )
				local str = strLink .. UI:GetStringByName( "equipSlot_AUTOGEN_hangar" )
				self.autogenLabelMetaText:SetText( str, true )
			else
				self.autogenLabelMetaText:SetText( "", true )
			end

		end
		
		if self:IsShipSlotTypePassive( slotType ) then
		
			local groupLayer = self:GetPassiveGroupLayerForShipSlotType( slotType )
			if groupLayer ~= -1 then
				self:SetLayerVisible( bHasSlotOfType, groupLayer ) 
			end
			
			if bHasSlotOfType then
				bHasPassiveSlots = true
			end
			
		end

	end
	
	self:SetLayerVisible( bHasPassiveSlots, self.layers.SHIP_SLOTS_PASSIVE_EFFECT ) 

end


--
function UI.EquipmentWnd:GetLabelLayerForShipSlotType( shipSlotType )

	local slotTypeName = UI:Val2Key( UI.shipSlotTypes, shipSlotType )
	if slotTypeName ~= "" then

		local layerName = string.format( "SHIP_SLOTS_LABEL_%s", slotTypeName )

		local layer = self.layers[ layerName ]
		if layer then
			return layer
		end

	end

	return -1

end


--
function UI.EquipmentWnd:GetPassiveGroupLayerForShipSlotType( shipSlotType )

	local slotTypeName = UI:Val2Key( UI.shipSlotTypes, shipSlotType )
	if slotTypeName ~= "" then

		local layerName = string.format( "SHIP_SLOTS_PASSIVE_%s_EFFECT", slotTypeName )

		local layer = self.layers[ layerName ]
		if layer then
			return layer
		end

	end

	return -1

end


--
function UI.EquipmentWnd:HasShipSlotsOfType( shipSlotType )

	for slotIdx, slotWnd in pairs( self.shipSlots ) do
		if slotWnd:IsVisible() and slotWnd:GetShipSlotType() == shipSlotType then
			return true
		end
	end

	return false

end


--
function UI.EquipmentWnd:BuyInventory( inventoryLevels )

	if self:IsWaitingRequests() then
		sys.log( "UI.EquipmentWnd:BuyInventory()[ERROR]: is still waiting for some other request" )
	end

	local level = -1

	if inventoryLevels == nil then

		level = UI:GetInventoryCurLevel() + 1

	else

    	if type( inventoryLevels ) ~= "table" or not next( inventoryLevels ) then
			self:ResetBuyInfo()
    		sys.log( "UI.EquipmentWnd:BuyInventory()[ERROR]: invalid \"inventoryLevels\" param" )
    		return
    	end

		level = inventoryLevels[ #inventoryLevels ]

	end

	self.requestId_buyInventory = _G.GameStore_BuyInventoryExtension( level )

	if self.requestId_buyInventory ~= 0 then
		UI:AddWaitingRequest( self.requestId_buyInventory )
	else
		self:ResetBuyInfo()
		self:ShowBuyErrorMsg( _G.GameStore.StoreBuyResult.SBR_ERROR )
	end

end


--
function UI.EquipmentWnd:SetSortMode( sortMode )

	if sortMode == self.sortMode then
		return
	end

	self.sortMode = sortMode

	self:UpdateItems( true )

end


--
function UI.EquipmentWnd:ValidateSortMode()

	self:SetSortMode( self.DEFAULT_SORT_MODE )

end


--
function UI.EquipmentWnd:F_OnEventSaveUiState()	

	if self:IsOnScreen() then
		self:HideChildModals()
	end

	UI.store.EquipmentWnd =
	{
		salvage2RequestId				= self.salvage2RequestId,
		vesselBudgetActivateRequestId	= self.vesselBudgetActivateRequestId,
		vesselBudgetLevelUpRequestId	= self.vesselBudgetLevelUpRequestId,
		recraftVesselRequestId			= self.recraftVesselRequestId,
		autogenDestroyRequestId			= self.autogenDestroyRequestId,
	}

end


--
function UI.EquipmentWnd:F_OnEventRestoreUiState()

	if UI.store.EquipmentWnd then

		self.salvage2RequestId				= UI.store.EquipmentWnd.salvage2RequestId
		self.vesselBudgetActivateRequestId	= UI.store.EquipmentWnd.vesselBudgetActivateRequestId
		self.vesselBudgetLevelUpRequestId	= UI.store.EquipmentWnd.vesselBudgetLevelUpRequestId
		self.recraftVesselRequestId			= UI.store.EquipmentWnd.recraftVesselRequestId
		self.autogenDestroyRequestId		= UI.store.EquipmentWnd.autogenDestroyRequestId

		self:UpdateWaitEquipmentEffect()

		UI.store.EquipmentWnd = nil

	end

end


--
function UI.EquipmentWnd:F_OnEventListActivateRecord( hSender, iParam0, iParam1, fParam0, fParam1 )

	if not self:IsOnScreen() then
		return
	end

	if hSender == UI.PopUpMenuWnd:GetUiHandle() and UI.PopUpMenuWnd:GetOwner() == self:GetUiHandle() then

    	local menuType = UI.PopUpMenuWnd:GetMenuType()
    	if menuType == UI.popUpMenuTypes.ITEM then
    		self:OnEquippedItemPopUpMenu( iParam0 )
    	else
    		sys.log( "UI.EquipmentWnd:F_OnEventListActivateRecord()[ERROR]: unhandled pop-up menu type: \"%s\"", tostring( menuType ) )
    	end

	end

end  


--
function UI.EquipmentWnd:OnEquippedItemPopUpMenu( recordIdx )

	local data = UI.PopUpMenuWnd:GetRecordData( recordIdx )
	if not data then
		sys.log( "UI.EquipmentWnd:OnEquippedItemPopUpMenu()[ERROR]: cannot find pop-up menu data for record %d", recordIdx )
		return
	end

	if data.slotType == UI.popUpMenuSlotTypes.REMOVE_EQUIPPED_ITEM then

		local shipItem = UI:GetShipItem( data.vid )
		if shipItem then

			local bAmmo = UI:IsDefAmmo( data.defName )
        	if bAmmo then

				local curAmmoInfo = shipItem.equipAmmo[ data.slotId ]
				if curAmmoInfo and curAmmoInfo.def == data.defName then
			    	self:UnequipAmmoInternal( data.vid, data.slotId )					
	    			UI:PlayGlobalSound( self.sounds.unequip )
				else
					sys.log( "UI.EquipmentWnd:OnEquippedItemPopUpMenu()[ERROR]: ammo def name mismatch; probably equipment has been changed since initiation of poup menu" )
				end

        	else

				local curIid = shipItem.equipModules[ data.slotId ] or UI.INVALID_U64_ID

				if curIid == data.iid then
	    			self:UnequipModuleInternal( data.vid, data.slotId )
	    			UI:PlayGlobalSound( self.sounds.unequip )
				else
					sys.log( "UI.EquipmentWnd:OnEquippedItemPopUpMenu()[ERROR]: cannot remove - module iid mismatch; probably equipment has been changed since initiation of poup menu" )
				end					

        	end

		else
    		sys.log( "UI.EquipmentWnd:OnEquippedItemPopUpMenu()[ERROR]: cannot find ship item" )
		end


	elseif data.slotType == UI.popUpMenuSlotTypes.SELL_ITEM then

		local invItem = self:MakeInvItemForSell( data.defName, data.count, data.iids, data.vid )
		self:LaunchTradeWnd( invItem, true )
		
	elseif data.slotType == UI.popUpMenuSlotTypes.AUTOGEN_DESTROY then
	
		self:TryDestroyAutogen( data.iid )

	elseif data.slotType == UI.popUpMenuSlotTypes.REFILL_AMMO_FROM_INVENTORY then

		local shipItem = UI:GetShipItem( data.vid )
		if shipItem then

    		local curAmmoInfo = shipItem.equipAmmo[ data.slotId ]
    		if curAmmoInfo and curAmmoInfo.def == data.defName then

    			if curAmmoInfo.amount == 0 then

					if self:CanRefillAmmoFropmInventory( data.defName ) then
						self:EquipAmmoInternal( data.defName, data.vid, data.slotId )
					else
						sys.log( "UI.EquipmentWnd:OnEquippedItemPopUpMenu()[ERROR]: cannot refill ammo from inventory; probably equipment or inventory has been changed since initiation of poup menu" )
					end    				

    			else
    				sys.log( "UI.EquipmentWnd:OnEquippedItemPopUpMenu()[ERROR]: ammo already full; probably equipment has been changed since initiation of poup menu" )
    			end					    			
    		else
    			sys.log( "UI.EquipmentWnd:OnEquippedItemPopUpMenu()[ERROR]: cannot refill - ammo def name mismatch; probably equipment has been changed since initiation of poup menu" )
    		end
		else
    		sys.log( "UI.EquipmentWnd:OnEquippedItemPopUpMenu()[ERROR]: cannot find ship item" )
		end


	elseif data.slotType == UI.popUpMenuSlotTypes.REFILL_AMMO_FROM_SHOP then

		local shipItem = UI:GetShipItem( data.vid )
		if shipItem then

    		local curAmmoInfo = shipItem.equipAmmo[ data.slotId ]
    		if curAmmoInfo and curAmmoInfo.def == data.defName then

    			if curAmmoInfo.amount == 0 then

					if self:CanRefillAmmoFromShop( data.defName ) and not self:CanRefillAmmoFropmInventory( data.defName ) then
						self:TryBuy( shipItem, UI.serverData.shopByDef[ data.defName ], data.slotId )
					else
						sys.log( "UI.EquipmentWnd:OnEquippedItemPopUpMenu()[ERROR]: cannot refill ammo from shop; probably equipment or inventory has been changed since initiation of poup menu" )
					end    				

    			else
    				sys.log( "UI.EquipmentWnd:OnEquippedItemPopUpMenu()[ERROR]: ammo already full; probably equipment has been changed since initiation of poup menu" )
    			end					    			
    		else
    			sys.log( "UI.EquipmentWnd:OnEquippedItemPopUpMenu()[ERROR]: cannot refill - ammo def name mismatch; probably equipment has been changed since initiation of poup menu" )
    		end
		else
    		sys.log( "UI.EquipmentWnd:OnEquippedItemPopUpMenu()[ERROR]: cannot find ship item" )
		end


	elseif data.slotType == UI.popUpMenuSlotTypes.BUY_AND_EQUIP_ITEM then

		self:TryBuy( UI:GetShipItem( data.vid ), data.shopItem, data.slotId )


	elseif data.slotType == UI.popUpMenuSlotTypes.EQUIP_ITEM then		
	
    	if data.srcVid and data.srcVid ~= UI.INVALID_U64_ID and data.srcVid ~= self.selShipItem.vid then

			self.popMenuDataToEquip = data

			local srcEquipShipItem = UI:GetShipItem( data.srcVid )
    		self:ShowRequestTranspherFromOtherShipMsg( data.defName, srcEquipShipItem.defName )

    	else

			self:DoQuickEquipFromPopUp( data )
    		UI:PlayGlobalSound( self.sounds.equip )

		end

	elseif data.slotType == UI.popUpMenuSlotTypes.SALVAGE_ITEM then

		local invItem = UI:GetInventoryItem( data.iid )
		if UI:CanItemBeSalvaged( invItem.defName ) then
			self:LaunchSalvageWnd( data.iid )
		else
			self:LaunchSalvage2Wnd( data.iid )
		end

	elseif data.slotType == UI.popUpMenuSlotTypes.UPGRADE_ITEM then
	
		if UI:GetAutogenInventoryItem( data.iid ) then
			self:LaunchAutogenUpgradeWnd( data.iid )
		else
			self:LaunchUpgradeItemWnd( data.iid, data.customData and data.customData.bInShipSlot or false )
		end
		
	elseif data.slotType == UI.popUpMenuSlotTypes.SHOW_ATLAS then
		
		UI.HangarWnd:ShowProfile( UI:GetLocalPlayerUid(), "ATLAS", true, nil, self:MakeDefaultLaunchData() )
		UI.Profile_AtlasWnd:ShowItem( data.defName )
		
	elseif data.slotType == UI.popUpMenuSlotTypes.TRADING_ITEM then
	
		UI.TradingWnd:Setup( UI.TradingWnd.modes.COMMON, self:GetName() )
		UI.TradingWnd:Show()
		UI.TradingWnd:ShowItem( data.defName )

	else
		sys.log( "UI.EquipmentWnd:OnEquippedItemPopUpMenu()[ERROR]: unhandled slot type: \"%s\"", tostring( data.slotType ) )
	end

end


--
function UI.EquipmentWnd:CanRefillAmmoFropmInventory( defName )

	local itemsByDef = UI.serverData.inventoryByDef[ defName ]
	if not itemsByDef then
		return false
	end

	for idx, item in pairs( itemsByDef ) do
		if item.amount > 0 then
			return true
		end
	end

	return false

end


--
function UI.EquipmentWnd:CanRefillAmmoFromShop( defName )

	return not UI:CantItemBeBoughtByDef( defName )

end


--
function UI.EquipmentWnd:MakeInvItemForSell( defName, count, iids, equipVid )

	local equipShipItem = nil
	if equipVid ~= UI.INVALID_U64_ID then
		equipShipItem = UI:GetShipItem( equipVid )
	end

	local invItem = UI:CreateInvItem( UI:IsDefAmmo( defName ) and UI.invItemTypes.AMMO or UI.invItemTypes.MODULE, defName, equipShipItem, count, nil, nil, nil )
	invItem.iids = iids

	return invItem

end


--
function UI.EquipmentWnd:HandleEscape()

	if self.selShipSlot then
		self:SelectShipSlot( nil )
		return true
	else
		return false
	end

end


--
function UI.EquipmentWnd:UpdateItemsListLayout()

	if not self.selShipSlot then
		return
	end

	self.itemsListWnd:UpdateLayout()

	self:MoveChildToLastPosition( self.itemsListWnd )
	self:MoveChildToLastPosition( self.selShipSlot )	

end


--
function UI.EquipmentWnd:DoSalvageItem2( iid )

	self.salvage2RequestId = _G.MasterServer_DisassembleItem( iid, 1 )
	if self.salvage2RequestId ~= 0 then

		UI:AddWaitingRequest( self.salvage2RequestId )
		UI:AddWaitingRequest( UI.INVENTORY_REQUEST_ID )
		UI:AddWaitingRequest( UI.RESOURCES_REQUEST_ID )

		local bEquipped = UI:GetEquippedShipItem( iid ) ~= nil
		if bEquipped then
			UI:AddWaitingRequest( UI.VESSEL_EQUIPMENT_REQUEST_ID )
		end

		UI:PlayGlobalSound( self.sounds.salvage )

	else
		UI:ShowMsgOnSalvage2Error( _G.GameStore.StoreBuyResult.SBR_ERROR )
	end

end


--
function UI.EquipmentWnd:LaunchItemCraftWnd( itemDefNameToCraft, bUpgrade, upgradedIid )

	local launchData = self:MakeDefaultLaunchData()
	
	-- эти параметры нужны только если скрафченный предмет надо установить на корабль
	launchData.bUpgrade			= nil
	launchData.iid				= nil
	launchData.vidToEquip		= nil
	launchData.slotIdToEquip	= nil

	if bUpgrade then

		local equipShipItem = UI:GetEquippedShipItem( upgradedIid )
		if equipShipItem then
			
			launchData.bUpgrade			= true
			launchData.iid				= upgradedIid

		end

	else

		if self.selShipSlot then
			
			launchData.bUpgrade			= false
			launchData.vidToEquip		= self.selShipItem.vid
			launchData.slotIdToEquip	= self.selShipSlot:GetSlotId()

		else
			sys.log( "UI.EquipmentWnd:LaunchItemCraftWnd()[ERROR]: no selected ship slot" )
		end

	end

	UI.HangarWnd:ShowItemCraftSingle( itemDefNameToCraft, nil, launchData )

end


--
function UI.EquipmentWnd:MakeDefaultLaunchData()

	local launchData = 
	{
		bEquipment			= true,
		selInfo				= self:GetSelShipSlotInfo(),
		vid					= self.selShipItem.vid,
		bPreview			= false,	-- см.ниже
		previewLaunchData	= nil,		-- см.ниже
	}
	
	if UI.HangarWnd:GetMenuTab() == UI.HangarWnd.menuTabs.EQUIPMENT_PREVIEW then
	
		launchData.bPreview = true
		
		local previewLaunchData = UI.HangarWnd:GetPreviewLaunchData()
		if previewLaunchData then
			launchData.previewLaunchData = UI:CopyTable2( previewLaunchData )
		end
		
	end
	
	return launchData 

end


--
function UI.EquipmentWnd:ShowMsgBoxOnNotEnoughMoney( priceType )

    local priceTypeName = UI:Val2Key( _G.GameStore.CreditsType, priceType )

    local caption = UI:GetStringByName( string.format( "msg_notEnoughMoney_caption_%s", priceTypeName ) )

    local text = UI:GetStringByName( string.format( "msg_notEnoughMoney_text_%s", priceTypeName ) )

	local strBaseColor = UI:Color2Str( UI.TEXT_BASE_COLOR )
	text = string.format( "%s%s", strBaseColor, text )

	local desc = ""

	if priceType == _G.GameStore.CreditsType.CT_CREDITS then
		desc = UI:GetStringByName( "creditsPriceTooltip_desc" )

	elseif priceType == _G.GameStore.CreditsType.CT_GOLD then
		desc = UI:GetStringByName( "goldPriceTooltip_desc" )

	elseif priceType == _G.GameStore.CreditsType.CT_TOKENS then
		desc = UI:GetStringByName( "tokensPriceTooltip_desc" )

	else
		sys.log( "UI.EquipmentWnd:ShowMsgBoxOnNotEnoughMoney()[ERROR]: unhandled price type: %s", tostring( priceType ) )
	end

	if desc ~= "" then
	    text = string.format( "%s|%s", text, desc )
	end

    UI:MessageBox( caption, text, UI.MBS_OK )

end


--
function UI.EquipmentWnd:GetItemSlotByActionBtn( actionBtn )

	local fitSlotWnd = nil

	if not actionBtn then
		return fitSlotWnd
	end

	for recordIdx = 1, UI.Equipment_ItemsListWnd:GetNumRecords() do

		local slotWnd = UI.Equipment_ItemsListWnd:GetButtonForRecord( recordIdx )

		if slotWnd and slotWnd:GetActionBtnRaw() == actionBtn then
			fitSlotWnd = slotWnd
			break
		end

	end

	return fitSlotWnd

end


--
function UI.EquipmentWnd:GetItemSlotByOpenSubTreeBtn( subTreeBtn )

	local fitSlotWnd = nil

	if not subTreeBtn then
		return fitSlotWnd
	end

	for recordIdx = 1, UI.Equipment_ItemsListWnd:GetNumRecords() do

		local slotWnd = UI.Equipment_ItemsListWnd:GetButtonForRecord( recordIdx )

		if slotWnd and slotWnd:GetOpenSubTreeBtnRaw() == subTreeBtn then
			fitSlotWnd = slotWnd
			break
		end

	end

	return fitSlotWnd

end


--
function UI.EquipmentWnd:TrySetSpecModulePartsCollectingShip()

	if not self.selShipItem then
		sys.log( "UI.EquipmentWnd:TrySetSpecModulePartsCollectingShip()[ERROR]: invalid ship" )
		return
	end

	if self:IsWaitingRequests() then
		return
	end

	self.hMsgSetSpecModulePartsCollectingShip = UI:MessageBox( UI:GetStringByName( "msg_vesselBudgetActivate_confirm_caption" ), UI:GetStringByName( "msg_vesselBudgetActivate_confirm_text" ), UI.MBS_YES_NO )

end


--
function UI.EquipmentWnd:DoSetSpecModulePartsCollectingShip()

	if self:IsWaitingRequests() then
		sys.log( "UI.EquipmentWnd:TrySetSpecModulePartsCollectingShip()[ERROR]: still waiting for another request" )
		return
	end

	if not self.selShipItem then
		sys.log( "UI.EquipmentWnd:TrySetSpecModulePartsCollectingShip()[ERROR]: invalid ship" )
		return
	end

	self.vesselBudgetActivateRequestId = _G.GameStore_VesselBudgetActivate( self.selShipItem.vid )

	if self.vesselBudgetActivateRequestId == 0 then
		self:ShowMsgOnVesselBudgetActivateError( _G.GameStore.StoreBuyResult.SBR_ERROR )
	end

	self:UpdateWaitEquipmentEffect()

end


--
function UI.EquipmentWnd:UnlockSpecModule( defName )

	if self:IsWaitingRequests() then
		sys.log( "UI.EquipmentWnd:UnlockSpecModule()[ERROR]: still waiting for another request" )
		return
	end

	if not self.selShipItem then
		sys.log( "UI.EquipmentWnd:UnlockSpecModule()[ERROR]: invalid ship" )
		return
	end

	if not UI:IsShipCollectingSpecModuleParts( self.selShipItem.vid ) then
		sys.log( "UI.EquipmentWnd:UnlockSpecModule()[ERROR]: current ship is not active for collecting spec module parts" )
		return
	end

	local curShipLevel	= UI:GetShipUnlockedSpecModuleLevel( self.selShipItem )
	local nextShipLevel	= curShipLevel == -1 and 1 or ( curShipLevel + 1 )

	if UI:GetShipSpecModuleForLevel( self.selShipItem.defName, nextShipLevel ) ~= defName then
		sys.log( "UI.EquipmentWnd:UnlockSpecModule()[ERROR]: wrong spec module" )
		return
	end

	self.vesselBudgetLevelUpRequestId = _G.GameStore_VesselBudgetLevelUp()

	if self.vesselBudgetLevelUpRequestId == 0 then
		self:ShowMsgOnVesselBudgetLevelUpError( _G.GameStore.StoreBuyResult.SBR_ERROR )
	end

	self:UpdateWaitEquipmentEffect()

end


--
function UI.EquipmentWnd:EquipSpecModule( defName )

	if self:IsWaitingRequests() then
		sys.log( "UI.EquipmentWnd:EquipSpecModule()[ERROR]: still waiting for another request" )
		return
	end

	if not self.selShipItem then
		sys.log( "UI.EquipmentWnd:EquipSpecModule()[ERROR]: invalid ship" )
		return
	end

	self.recraftVesselRequestId = _G.GameStore_RecraftVessel( self.selShipItem.defName, defName, u64( 0 ) )

	if self.recraftVesselRequestId == 0 then
		self:ShowMsgOnRecraftVesselError( _G.GameStore.StoreBuyResult.SBR_ERROR )
	end

	self:UpdateWaitEquipmentEffect()

end


--
function UI.EquipmentWnd:ShowMsgOnVesselBudgetActivateError( result )

	UI:ShowErrorMsg( "msg_vesselBudgetActivate_error", result, "_G.GameStore.StoreBuyResult" )

end


--
function UI.EquipmentWnd:ShowMsgOnVesselBudgetLevelUpError( result )

	UI:ShowErrorMsg( "msg_vesselBudgetLevelUp_error", result, "_G.GameStore.StoreBuyResult" )

end


--
function UI.EquipmentWnd:ShowMsgOnRecraftVesselError( result )

	UI:ShowMsgOnShipCraftError( result )

end


--
function UI.EquipmentWnd:LaunchBuyBundleWnd( bundleDefName, data )

	UI.BuyBundleWnd:Setup( bundleDefName, data, self:GetScriptTableName(), false )
	UI.BuyBundleWnd:Show()
	UI:PlayGlobalSound( self.sounds.tradeWndShow )

end


--
function UI.EquipmentWnd:TryBuyBundle( bundleDefName )

	if self:IsWaitingRequests() then
		return
	end

	if type( bundleDefName ) ~= "string" then
		sys.log( "UI.EquipmentWnd:TryBuyBundle()[ERROR]: invalid type of the 1-st parameter (\"bundleDefName\"); \"string\" expected, got \"%s\"", type( bundleDefName ) )
		return
	end

	if UI:IsBundleContentFullyCollected( bundleDefName ) then
		sys.log( "UI.EquipmentWnd:TryBuyBundle()[ERROR]: bundle \"%s\" is considered to be fully collected", bundleDefName )
		UI:MessageBox( UI:GetStringByName( "msgBundleContentCollected_caption" ), UI:GetStringByName( "msgBundleContentCollected_text" ), UI.MBS_OK )
		return
	end

	local shopItem = UI:GetShopItemByDef( bundleDefName )
	if not shopItem then
		sys.log( "UI.EquipmentWnd:TryBuyBundle()[ERROR]: cannot find shop item for \"%s\"", bundleDefName )
		return
	end

	if UI:IsEnoughPlaceInInventoryForItem( bundleDefName ) then

		self:LaunchTradeWnd( shopItem, false )

	else

		if UI:CanIncreaseInventory() then

			self:ResetBuyInfo()
			self.buyInfo.shopItem = shopItem

			-- tODO проверка расширение автоген-инвентаря
    		local needSize		= UI:GetNeedInventorySizeForItem( bundleDefName )
    		local curLevel		= UI:GetInventoryCurLevel()
    		local curUsedSize	= UI:GetInventoryCurSize()

    		local inventoryLevelsToBuy = {}

    		for levelToBuy = curLevel + 1, UI:GetInventoryMaxLevel() do

    			table.insert( inventoryLevelsToBuy, levelToBuy )

    			local newCapacity = UI:GetInventoryMaxSizeForLevel( levelToBuy )
    			if ( curUsedSize + needSize ) <= newCapacity then
    				break
    			end

    		end		

			self:LaunchTradeWithInventoryWnd( shopItem, inventoryLevelsToBuy )

		else
			UI:MessageBox( UI:GetStringByName( "buyInventory_caption_AUTO" ), UI:GetStringByName( "msg_cannotIncreaseInventory_AUTO" ), UI.MBS_OK )
		end

	end

end


--
function UI.EquipmentWnd:DoBuyBundle( shopItem )

	if self:IsWaitingRequests() then
		sys.log( "UI.EquipmentWnd:DoBuyBundle()[ERROR]: still is waiting for some other request" )
		return
	end

	local price, priceType = UI:GetBundleRealBuyPrice( shopItem )
	self.buyRequestId = _G.GameStore_Buy( shopItem.id, 1, priceType )

	if self.buyRequestId ~= 0 then
		UI:AddWaitingRequest( self.buyRequestId )
	else
		self:ShowBuyErrorMsg( _G.GameStore.StoreBuyResult.SBR_ERROR )
	end

end


--
function UI.EquipmentWnd:LaunchTradeWithInventoryWnd( shopItem, inventoryLevelsToBuy )

	UI.Equipment_BuyWithInventoryWnd:Setup( shopItem, inventoryLevelsToBuy, nil )
	UI.Equipment_BuyWithInventoryWnd:Show()
	UI:PlayGlobalSound( self.sounds.tradeWndShow )

end


--
function UI.EquipmentWnd:UpdateShipUpgradeWnd()

	if self.selShipItem then
		self:AddChild( UI.EquipmentShipUpgradeWnd )
		UI.EquipmentShipUpgradeWnd:Update()
	else
		UI.EquipmentShipUpgradeWnd:UnlinkFromParent()
	end

end


--
function UI.EquipmentWnd:UpdateShipPresetsVisibility()
	
	local bNeedShow = self.selShipItem and UI.rankLocks.shipPresets ~= -1 and UI:GetPlayerAccountRank() >= UI.rankLocks.shipPresets
	if bNeedShow then
		self:AddChild( UI.ShipPresetsWnd )
	else
		UI.ShipPresetsWnd:UnlinkFromParent()
	end
	
end


--
function UI.EquipmentWnd:F_OnAfterAddChild( child )

	self:OnAfterAddChild( child )

	self:UpdateZOrder()

end


--
function UI.EquipmentWnd:UpdateZOrder()

	if UI.ShipPresetsWnd and UI.ShipPresetsWnd.w and UI.ShipPresetsWnd:IsChildOf( self ) then
		self:MoveChildToFirstPosition( UI.ShipPresetsWnd )	-- #0110260 пресеты не должны оказаться повер списка предметов
	end
	
end


--
function UI.EquipmentWnd:TryDestroyAutogen( iid )
	
	if self:IsWaitingRequests() then
		sys.log( "UI.EquipmentWnd:TryDestroyAutogen()[ERROR]: still waiting for another request" )
		return
	end
	
	if iid == UI.INVALID_U64_ID then
		sys.log( "UI.EquipmentWnd:TryDestroyAutogen()[ERROR]: invalid iid" )
		return
	end
	
	local defName = UI:Iid2DefName( iid )
	local strNameLink = string.format( "$link [type ITEM][params {defName=\"%s\"}]$", defName )
	
	local str = UI:GetStringByName( "autogenUnequip_destroyConfirm_text" )
	
	local numSubst = 0
	str, numSubst = string.gsub( str, "%$name%$", strNameLink )
	
	if numSubst == 0 then
		sys.log( "UI.EquipmentWnd:UpdateMsg()[ERROR]: cannot find placeholder '$name$' in string 'autogenUnequip_destroyMsg_text'" )
		str = string.format( "[INVALID STRING] Unequipping item %s", strNameLink )
	end
	
	self.autogenIidToDestroy = iid
	self.hMsgAutogenDestroy = UI:MessageBox( UI:GetStringByName( "autogenUnequip_destroyConfirm_caption" ), str, UI.MBS_YES_NO )

end


--
function UI.EquipmentWnd:DoDestroyAutogen( iid )

	if self:IsWaitingRequests() then
		sys.log( "UI.EquipmentWnd:DoDestroyAutogen()[ERROR]: still waiting for another request" )
		return
	end
	
	if iid == UI.INVALID_U64_ID then
		sys.log( "UI.EquipmentWnd:DoDestroyAutogen()[ERROR]: invalid iid" )
		return
	end
	
	self.autogenDestroyRequestId = _G.GameStore_AutogenDestroy( iid )
	
	if self.autogenDestroyRequestId ~= 0 then
		UI:AddWaitingRequest( self.autogenDestroyRequestId )
	else
		self:ShowMsgOnAutogenDestroyError( _G.GameStore.ModuleEquipResult.MER_ERROR )
	end
	
	self:UpdateWaitEquipmentEffect()
	
end


--
function UI.ShopWnd:ShowMsgOnAutogenDestroyError( result )

	UI:ShowErrorMsg( "msg_autogenDestroyError", result, "_G.GameStore.ModuleEquipResult" )
	
end


-- -----------------------------------------------------------------
-- UI.Equipment_ShipSlotWnd
-- -----------------------------------------------------------------

-- ********************************************************************************************************************
-- Внимание, хак! Этот "класс" и его дочерние используется также в окне UI.ShipsTreeWnd, для чего изначально не был предназначен.
-- Делая изменения здесь, нужно убедиться, что в дереве кораблей тоже не сломалось.

-- ********************************************************************************************************************

UI.Equipment_ShipSlotWnd = {}
local ss = UI.Equipment_ShipSlotWnd

-- ----------------------------------------
-- window definition
-- ----------------------------------------

UI.Equipment_ShipSlotWnd.def =
{
	className	= "Wnd",

	props =
	{
		name		= "Equipment_ShipSlotWnd",
		isPrototype	= true,
	}
}

-- ----------------------------------------
-- interface functions
-- ----------------------------------------

-- вызывается один раз при создании слота
function UI.Equipment_ShipSlotWnd:Init( shipSlotType, slotId )

	self.shipSlotType	= shipSlotType
	self.slotId			= slotId

end


--
function UI.Equipment_ShipSlotWnd:GetShipSlotType()

	return self.shipSlotType

end


--
function UI.Equipment_ShipSlotWnd:GetSlotId()

	return self.slotId

end


--
function UI.Equipment_ShipSlotWnd:Reset()

	self.icoWnd:Reset()
	self:SetWidth( self.icoWnd:GetWidth() )
	self:SetHeight( self.icoWnd:GetHeight() )

	self:Setup( self.activeStates.LOCKED_FOR_SHIP, "" )
	self:SetMouseOver( false )
	self:SetBgDefaultAnimation()

	if self.shipSlotType ~= -1 then
		self:SetupIcoForEmptyItem()
	end

	self.bDDFit		= false
	self.bDDAccept	= false
	self.bSelected	= false

end


-- вызывается при показе слота или смене его состояния;
-- здесь устанавливается именно состояние слота, а не модуля в нем;
-- (модуль ставится/снимается отдельной функцией - SetItem() в дочерних классах)
-- evolvingNodeName - это нод в "зеленом" корабле, который открывает данный слот

function UI.Equipment_ShipSlotWnd:Setup( activeState, evolvingNodeName )

	if evolvingNodeName == nil then
		evolvingNodeName = ""
	end

	self.activeState		= activeState
	self.evolvingNodeName	= evolvingNodeName

	if activeState == self.activeStates.ACTIVE then

		self:UpdateMouseOverState()
		self.icoWnd:AnimateMainIdle()
		self:SetupTooltipForEmptyItem()
		self.icoWnd:HideLock()
		self:UpdateInBattle()		
		self:SetVisible( true )
		self.icoWnd:HideDarkening()
		self.icoWnd:HideInactiveNode()
		self.icoWnd:HideNotLearnedNode()

	elseif activeState == self.activeStates.LOCKED_FOR_SHIP then

		self:SetMouseOver( false )
		self.icoWnd:AnimateMainInactive()
		self:SetupTooltipForLockedForShipState()
		self.icoWnd:ShowLock()
		self:UpdateInBattle()
		self:SetVisible( false )
		self.icoWnd:HideDarkening()
		self.icoWnd:HideInactiveNode()
		self.icoWnd:HideNotLearnedNode()

	-- актуально только для слота боеприпасов
	elseif activeState == self.activeStates.LOCKED_FOR_WEAPON then

		self:SetMouseOver( false )
		self.icoWnd:AnimateMainInactive()
		self:SetupTooltipForLockedForWeaponState()
		self.icoWnd:HideLock()
		self:UpdateInBattle()
		self:SetVisible( true )
		self.icoWnd:HideDarkening()
		self.icoWnd:HideInactiveNode()
		self.icoWnd:HideNotLearnedNode()

	elseif activeState == self.activeStates.LOCKED_FOR_INACTIVE_NODE then

		self:SetMouseOver( false )
		self.icoWnd:AnimateMainIdle()
		self:SetupTooltipForEmptyItem()
		self.icoWnd:HideLock()
		self:UpdateInBattle()
		self:SetVisible( true )
		self.icoWnd:ShowDarkening()
		self.icoWnd:ShowInactiveNode( evolvingNodeName, self:GetShipDefName() )
		self.icoWnd:HideNotLearnedNode()

	elseif activeState == self.activeStates.LOCKED_FOR_NOT_LEARNED_NODE then

		self:SetMouseOver( false )
		self.icoWnd:AnimateMainIdle()
		self:SetupTooltipForEmptyItem()
		self.icoWnd:HideLock()
		self:UpdateInBattle()
		self:SetVisible( true )
		self.icoWnd:ShowDarkening()
		self.icoWnd:HideInactiveNode()
		self.icoWnd:ShowNotLearnedNode( evolvingNodeName, self:GetShipDefName() )

	end	

end


--
function UI.Equipment_ShipSlotWnd:GetActiveState()

	return self.activeState

end


--
function UI.Equipment_ShipSlotWnd:GetEvolvingNodeName()

	return self.evolvingNodeName

end


--
function UI.Equipment_ShipSlotWnd:IsActive()

	return self.activeState == self.activeStates.ACTIVE

end


--
function UI.Equipment_ShipSlotWnd:OnDDStart()

	self:SetMouseOver( false )

end


--
function UI.Equipment_ShipSlotWnd:OnDDStop()

	self.bDDFit		= false
	self.bDDAccept	= false

	self:SetBgDefaultAnimation()
	self:UpdateMouseOverState()

end


--
function UI.Equipment_ShipSlotWnd:SetDDFit( bFit )

	self.bDDFit = bFit

	if bFit then
		self:SetBgDDFitAnimation()
	else
		self:SetBgDefaultAnimation()
	end	

end


--
function UI.Equipment_ShipSlotWnd:IsDDFit()

	return self.bDDFit

end


--
function UI.Equipment_ShipSlotWnd:SetDDAccept( bAccept )

	self.bDDAccept = bAccept
	self:SetMouseOver( bAccept )

end


--
function UI.Equipment_ShipSlotWnd:IsDDAccept()

	return self.bDDAccept

end


--
function UI.Equipment_ShipSlotWnd:Select( bSelected )

	self.bSelected = bSelected

	if self.bSelected then
		self.icoWnd:ShowSelection()
	else
		self.icoWnd:HideSelection()
	end

end


--
function UI.Equipment_ShipSlotWnd:IsSelected()

	return self.bSelected

end


--
function UI.Equipment_ShipSlotWnd:IsVisible()

	return self:GetParent() ~= nil and not self:HasStyle( UI.WS_NOT_DRAW )

end


--
function UI.Equipment_ShipSlotWnd:GetTooltipData()

	if self:IsSelected() then
		return nil
	else
		return self.icoWnd:GetTooltipData()
	end

end


--
function UI.Equipment_ShipSlotWnd:GetOrg()

	return self.icoWnd:GetOrg()

end


--
function UI.Equipment_ShipSlotWnd:ShowUpgradeItemWowEffect()

	self.icoWnd:ShowUpgradeItemWowEffect()
	
end


-- ----------------------------------------
-- const
-- ----------------------------------------

ss.EQUIP_SHIP_SLOT = true

ss.activeStates =
{
	ACTIVE						= 1,
	LOCKED_FOR_SHIP				= 2,
	LOCKED_FOR_WEAPON			= 3,
	LOCKED_FOR_INACTIVE_NODE	= 4,
	LOCKED_FOR_NOT_LEARNED_NODE	= 5,
}

ss.sounds =
{
	mouseOver	= "sound/ui/btnMouseOver",
}

ss.bNewVersion = false	-- внешний вид слотов поменялся в верфи, но этот базовый класс используется также в других окнах, где внешний вид остается старым

-- ----------------------------------------
-- vars
-- ----------------------------------------

ss.shipSlotType		= -1
ss.slotId			= -1
ss.activeState		= ss.activeStates.LOCKED_FOR_SHIP
ss.evolvingNodeName	= ""
ss.bDDFit			= false
ss.bDDAccept		= false
ss.bSelected		= false
ss.icoWnd			= nil

-- ----------------------------------------
-- work functions
-- ----------------------------------------

--
function UI.Equipment_ShipSlotWnd:F_PostLoad()

	UI.Wnd.F_PostLoad( self )
	
	if self:IsPrototype() then
		return
	end
	
	self:CreateControls()
	
	self:AddChild( self.icoWnd )
	self.icoWnd:AddStyle( UI.WS_NOT_MOUSE_REACT )
	
	self:SetWidth( self.icoWnd:GetWidth() )
	self:SetHeight( self.icoWnd:GetHeight() )

end


--
function UI.Equipment_ShipSlotWnd:CreateControls()

	self.icoWnd = UI:CreateChildWnd( self, UI.ItemIcoWnd, "" )	-- в базовом классе - иконка в разрешении 720 (используется в других окнах)

end


--
function UI.Equipment_ShipSlotWnd:UpdateMouseOverState()

	if not self:CanReactOnMouseOver() then
		self:SetMouseOver( false )
		return
	end

	local wndUnderMouse = UI:FindWindowUnderMouse( UI.Root, UI:GetMouseX(), UI:GetMouseY(), true )
	local bMouseOver = wndUnderMouse and wndUnderMouse == self or wndUnderMouse:IsChildOf( self ) and not UI:IsWndKindOf( wndUnderMouse, "ItemIco_UpgradeArrowBtn" )

	self:SetMouseOver( bMouseOver )

end


--
function UI.Equipment_ShipSlotWnd:SetMouseOver( bMouseOver )

	local bWasMouseOver = self.icoWnd:IsMouseOver()

	if bMouseOver then
		self.icoWnd:ShowMouseOver()
	else
		self.icoWnd:HideMouseOver()
	end

	if bMouseOver and not bWasMouseOver and self:IsOnScreen() then
		UI:PlayGlobalSound( self.sounds.mouseOver )
	end

end


--
function UI.Equipment_ShipSlotWnd:CanReactOnMouseOver()

	return
		( self.activeState == self.activeStates.ACTIVE or ( self.activeState == self.activeStates.LOCKED_FOR_INACTIVE_NODE and not self:IsEmpty() ) )
		and not self:IsItemDragging()
		and not self:IsInBattle()
		and not self:IsOnQuest()
		and not ( self.shipSlotType == UI.shipSlotTypes.SPECIAL and not UI:IsSpecModuleCustomizableOnShip( self:GetShipDefName() ) )

end


--
function UI.Equipment_ShipSlotWnd:F_OnMouseIn( mouseX, mouseY, wndThatReceivedInput )

	if self:OnMouseIn( mouseX, mouseY, wndThatReceivedInput ) then
		return true
	end

	self:UpdateMouseOverState()
	return true

end


--
function UI.Equipment_ShipSlotWnd:F_OnMouseOut( mouseX, mouseY, wndThatReceivedInput )

	if self:OnMouseOut( mouseX, mouseY, wndThatReceivedInput ) then
		return true
	end

	if UI:IsInRemovingAllWindows() or UI:IsInShutdown() then
		return true
	end

	self:UpdateMouseOverState()
	return true	

end


--
function UI.Equipment_ShipSlotWnd:F_OnScreenPosChanged( oldScreenX, oldScreenY )

	self:OnScreenPosChanged( oldScreenX, oldScreenY )

	-- может вызываеться при инициализации окна, когда еще слои не созданы
	if self:GetNumLayers() == 0 then
		return
	end

	-- #0089276 - если слоты были изначально созданы в позиции, где стоит мышь, а потом их разместили на нужные места,
	-- то выделение мыши надо снять
	if self:IsOnScreen() then
		self:UpdateMouseOverState()
	end

end


-- to override
function UI.Equipment_ShipSlotWnd:SetupIcoForEmptyItem()
end   



-- to override
function UI.Equipment_ShipSlotWnd:SetupTooltipForEmptyItem()
end


--
function UI.Equipment_ShipSlotWnd:SetupTooltipForLockedForShipState()

	self.icoWnd:SetTooltipData( nil )

end


-- to override
function UI.Equipment_ShipSlotWnd:SetupTooltipForLockedForWeaponState()
end


-- to override
function UI.Equipment_ShipSlotWnd:SetupTooltipForItem()
end


--
function UI.Equipment_ShipSlotWnd:UpdateInBattle()

	self.icoWnd:HideInBattleEffect()
	self.icoWnd:HideInBattleText()
	self.icoWnd:HideOnShipQuestEffect()

	if self.activeState ~= self.activeStates.ACTIVE and self.activeState ~= self.activeStates.LOCKED_FOR_INACTIVE_NODE and self.activeState ~= self.activeStates.LOCKED_FOR_NOT_LEARNED_NODE then
		return
	end

	if self:IsInBattle() then
		self.icoWnd:ShowInBattleEffect()
		self.icoWnd:ShowInBattleText()

	elseif self:IsOnQuest() then
		self.icoWnd:ShowOnShipQuestEffect()
	end

end


--
function UI.Equipment_ShipSlotWnd:IsInBattle()

	local selShipItem = self:GetShipItem()
	return selShipItem and UI:IsShipInBattle( selShipItem )

end


--
function UI.Equipment_ShipSlotWnd:IsOnQuest()

	local selShipItem = self:GetShipItem()
	return selShipItem and UI:IsShipOnShipQuest( selShipItem )

end


--
function UI.Equipment_ShipSlotWnd:SetVisible( bVisible )

	if bVisible then
		self:RemoveStyle( UI.WS_NOT_DRAW )
		self:RemoveStyle( UI.WS_NOT_MOUSE_REACT )
		self.icoWnd:RemoveStyle( UI.WS_NOT_DRAW )
	else
		self:AddStyle( UI.WS_NOT_DRAW )
		self:AddStyle( UI.WS_NOT_MOUSE_REACT )
		self.icoWnd:AddStyle( UI.WS_NOT_DRAW )
	end

end


-- for override
function UI.Equipment_ShipSlotWnd:IsEmpty()

	return true

end


--
function UI.Equipment_ShipSlotWnd:GetShipItem()

	return UI.EquipmentWnd:GetSelShipItem()

end


--
function UI.Equipment_ShipSlotWnd:GetShipDefName()

	local shipItem = self:GetShipItem()
	return shipItem and shipItem.defName or ""

end


--
function UI.Equipment_ShipSlotWnd:IsItemDragging()

	return UI.EquipmentWnd.ddInfo.ddState == UI.EquipmentWnd.ddStates.DRAG

end


--
function UI.Equipment_ShipSlotWnd:SetBgDefaultAnimation()

	self.icoWnd:AnimateIcoIdle()

end


--
function UI.Equipment_ShipSlotWnd:SetBgDDFitAnimation()

	self.icoWnd:AnimateIcoSel()

end


--
function UI.Equipment_ShipSlotWnd:ShowUpgradeArrow()
	
	if self.bNewVersion then
		self.icoWnd:ShowUpgradeArrow2()
		self:SetWidth( self.icoWnd:GetWidth() )		-- при показе стрелки-кнопки меняется размер иконки
		self:SetHeight( self.icoWnd:GetHeight() )
	else
		self.icoWnd:ShowUpgradeArrow()
	end

end


--
function UI.Equipment_ShipSlotWnd:HideUpgradeArrow()
	
	if self.bNewVersion then
		self.icoWnd:HideUpgradeArrow2()
		self:SetWidth( self.icoWnd:GetWidth() )		-- при показе стрелки-кнопки меняется размер иконки
		self:SetHeight( self.icoWnd:GetHeight() )
	else
		self.icoWnd:HideUpgradeArrow()
	end

end


-- -----------------------------------------------------------------
-- UI.Equipment_ModuleShipSlotWnd
-- -----------------------------------------------------------------

UI.Equipment_ModuleShipSlotWnd = {}
local mss = UI.Equipment_ModuleShipSlotWnd

-- ----------------------------------------
-- window definition
-- ----------------------------------------

UI.Equipment_ModuleShipSlotWnd.def =
{
	className	= "Wnd",
	prototype	= "Equipment_ShipSlotWnd",

	props =
	{
		name		= "Equipment_ModuleShipSlotWnd",
		isPrototype	= true,
	}
}

-- ----------------------------------------
-- interface functions
-- ----------------------------------------

--
function UI.Equipment_ModuleShipSlotWnd:Setup( activeState, evolvingNodeName )

	UI.Equipment_ShipSlotWnd.Setup( self, activeState, evolvingNodeName )

	if self:IsBig() then
		
		self.icoWnd:HideIcoMain()
		
		if self.bNewVersion then
			self.icoWnd:ShowSpecModuleArrow()
		else
			self.icoWnd:ShowBigBg()
		end
		
		self:SetWidth( self.icoWnd:GetWidth() )
		self:SetHeight( self.icoWnd:GetHeight() )
		
	end

end


--
function UI.Equipment_ModuleShipSlotWnd:SetItem( itemId, defName )

	self.itemId		= itemId
    self.defName	= defName
	
	self:UpdateMouseOverState()
	self:SetupTooltipForItem()
	self:UpdateUpgradeArrow()

	local bEnchanted = false
	if self.shipSlotType ~= UI.shipSlotTypes.SPECIAL then
		if self.itemId ~= UI.INVALID_U64_ID then
			bEnchanted = UI:IsInventoryItemEnchantedById( self.itemId )
		end
	end
	
	self.icoWnd:SetupForItem( defName, bEnchanted )
	
	-- автоген-модули могу стоять в слоте, но не подходить по рангу, рисуем ранг красным цветом
	local bRankFit = true
	
	local minRank = UI:GetItemEquipMinRank( defName )
	local maxRank = UI:GetItemEquipMaxRank( defName )
	
	if minRank ~= -1 and maxRank ~= -1 then	
	
		local shipDefName = self:GetShipDefName()
		local shipRank = UI:GetShipRank( shipDefName )
		
		if shipRank ~= -1 and shipRank < minRank or shipRank > maxRank then
			bRankFit = false
		end
		
	end
		
	self.icoWnd:SetupRank( defName, bRankFit, nil )

end


--
function UI.Equipment_ModuleShipSlotWnd:ResetItem()

    self.itemId		= UI.INVALID_U64_ID
	self.defName	= ""

	self:SetupIcoForEmptyItem()
	self.icoWnd:HideRank()
	self:UpdateMouseOverState()
	self:SetupTooltipForEmptyItem()
	self.icoWnd:HideColorBg()
	self:HideUpgradeArrow()

end


--
function UI.Equipment_ModuleShipSlotWnd:GetItemId()

	return self.itemId

end


--
function UI.Equipment_ModuleShipSlotWnd:GetDefName()

	return self.defName

end


--
function UI.Equipment_ModuleShipSlotWnd:Reset()

	UI.Equipment_ShipSlotWnd.Reset( self )

    self.itemId		= UI.INVALID_U64_ID
	self.defName	= ""

end 


--
function UI.Equipment_ModuleShipSlotWnd:OnPlayerCreditsChanged()

	if not self:IsVisible() then
		return
	end

	if self.defName == "" then
		return
	end

	self:UpdateUpgradeArrow()

end


--
function UI.Equipment_ModuleShipSlotWnd:OnDDStop()

	if self:IsBig() then
		return
	end

	UI.Equipment_ShipSlotWnd.OnDDStop( self )

end


--
function UI.Equipment_ModuleShipSlotWnd:SetDDFit( bFit )

	if self:IsBig() then

		if bFit then
			sys.log( "UI.Equipment_ModuleShipSlotWnd:SetDDFit()[ERROR]: drag and drop visualization for big icons is not supported" )
		end

		return

	end

	UI.Equipment_ShipSlotWnd.SetDDFit( self, bFit )

end


-- ----------------------------------------
-- vars
-- ----------------------------------------

mss.itemId		= UI.INVALID_U64_ID
mss.defName		= ""


-- ----------------------------------------
-- work functions
-- ----------------------------------------

--
function UI.Equipment_ModuleShipSlotWnd:SetupIcoForEmptyItem()

	local hTex = UI.INVALID_RESOURCE_HANDLE

	if self.shipSlotType ~= UI.shipSlotTypes.SPECIAL then

    	local typeName = UI:Val2Key( UI.shipSlotTypes, self.shipSlotType )
    	local texName = string.format( "equipSlot_%s", typeName )

    	hTex = UI:GetTex( texName )

	end
	
	self.icoWnd:SetupIco( hTex )

end


--
function UI.Equipment_ModuleShipSlotWnd:SetupTooltipForEmptyItem()

	-- для пустого слота оружия показывается большая подсказка дефолтного оружия
	if self.shipSlotType == UI.shipSlotTypes.WEAPON then
		self:SetupTooltipForItem()
		return
	end

	local shipSlotTypeName = UI:Val2Key( UI.shipSlotTypes, self.shipSlotType )

	local tooltipText		= UI:GetStringByName( string.format( "equipSlot_%s_tipMsg", shipSlotTypeName ) )
	local tooltipCaption	= UI:GetStringByName( string.format( "equipSlot_%s_tipCaption", shipSlotTypeName ) )

	self.icoWnd:SetTooltipData( { tooltipType = UI.tooltipTypes.TEXT_LARGE, text = tooltipText, caption = tooltipCaption } )

end


--
function UI.Equipment_ModuleShipSlotWnd:SetupTooltipForLockedForWeaponState()

	local shipSlotTypeName = UI:Val2Key( UI.shipSlotTypes, self.shipSlotType )

	local tooltipText		= UI:GetStringByName( "equipSlot_unfitForWeaponSlot_tipMsg" )
	local tooltipCaption	= UI:GetStringByName( string.format( "equipSlot_%s_tipCaption", shipSlotTypeName ) )

	self.icoWnd:SetTooltipData( { tooltipType = UI.tooltipTypes.TEXT_LARGE, text = tooltipText, caption = tooltipCaption } )

end


--
function UI.Equipment_ModuleShipSlotWnd:SetupTooltipForItem()

	local isActiveWeapon =
		self.shipSlotType == UI.shipSlotTypes.WEAPON
		and ( self.activeState == self.activeStates.ACTIVE or self.activeState == self.activeStates.LOCKED_FOR_INACTIVE_NODE or self.activeState == self.activeStates.LOCKED_FOR_NOT_LEARNED_NODE )

	local bDefaultActiveWeapon	= self.defName == "" and isActiveWeapon
	local selShipItem			= self:GetShipItem()

	local tooltipData = {}

	tooltipData.tooltipType		= UI.tooltipTypes.MODULE

	if selShipItem then
		tooltipData.dstShipData = UI.ModuleTooltipWnd.ShipData:CreateForVid( selShipItem.vid, self.slotId )
	else
		tooltipData.dstShipData = UI.ModuleTooltipWnd.ShipData:CreateForDef( self:GetShipDefName(), self.slotId )
	end

	tooltipData.iid				= self.itemId
	tooltipData.bWithTalents	= true

	tooltipData.defName =
		bDefaultActiveWeapon
			and UI:GetShipDefaultWeapon( self:GetShipDefName() )
			or self.defName

	self.icoWnd:SetTooltipData( tooltipData )

end


--
function UI.Equipment_ModuleShipSlotWnd:UpdateUpgradeArrow()

	local bCanUpgradeNow = false

	if self.itemId ~= UI.INVALID_U64_ID then
		bCanUpgradeNow = UI:CanItemUpgradeNow( self.itemId )
	end

	if bCanUpgradeNow then
		self:ShowUpgradeArrow()
	else
		self:HideUpgradeArrow()
	end

end


--
function UI.Equipment_ModuleShipSlotWnd:IsEmpty()

	return self.defName == ""

end


--
function UI.Equipment_ModuleShipSlotWnd:IsCustomizableSpecModule()

	local bCustomizableSpecModule = false

	if self.shipSlotType == UI.shipSlotTypes.SPECIAL then

		local selShipDefName = self:GetShipDefName()
		if selShipDefName ~= "" and UI:IsSpecModuleCustomizableOnShip( selShipDefName ) then
			bCustomizableSpecModule = true
		end

	end

	return bCustomizableSpecModule

end


--
function UI.Equipment_ModuleShipSlotWnd:IsBig()

	return self:IsCustomizableSpecModule()

end


--
function UI.Equipment_ModuleShipSlotWnd:SetMouseOver( bMouseOver )

	local bWasMouseOver = self.icoWnd:IsMouseOver()

	if bMouseOver then
		if self:IsBig() then
			self.icoWnd:ShowBigMouseOver()
		else
			self.icoWnd:ShowMouseOver()
		end
	else
		self.icoWnd:HideMouseOver()
		self.icoWnd:HideBigMouseOver()
	end

	if bMouseOver and not bWasMouseOver and self:IsOnScreen() then
		UI:PlayGlobalSound( self.sounds.mouseOver )
	end

end


-- -----------------------------------------------------------------
-- UI.Equipment_PassiveModuleShipSlotWnd
-- отличается от базового Equipment_ModuleShipSlotWnd разрешением 1080 и уменьшенным размером иконки
-- -----------------------------------------------------------------

UI.Equipment_PassiveModuleShipSlotWnd = {}

-- ----------------------------------------
-- window definition
-- ----------------------------------------

UI.Equipment_PassiveModuleShipSlotWnd.def =
{
	className	= "Wnd",
	prototype	= "Equipment_ModuleShipSlotWnd",

	props =
	{
		name		= "Equipment_PassiveModuleShipSlotWnd",
		isPrototype	= true,
	}
}

-- ----------------------------------------
-- const
-- ----------------------------------------

UI.Equipment_PassiveModuleShipSlotWnd.bNewVersion = true

-- ----------------------------------------
-- work functions
-- ----------------------------------------

--
function UI.Equipment_PassiveModuleShipSlotWnd:CreateControls()

	self.icoWnd = UI:CreateChildWnd( self, UI.ItemIcoWnd_Small_1080, "" )

end


--
function UI.Equipment_PassiveModuleShipSlotWnd:SetupIcoForEmptyItem()
	
	self.icoWnd:HideIco()
	self.icoWnd:HideIcoMain()
	
end


-- -----------------------------------------------------------------
-- UI.Equipment_ActiveModuleShipSlotWnd
-- отличается от базового Equipment_ModuleShipSlotWnd разрешением 1080
-- -----------------------------------------------------------------

UI.Equipment_ActiveModuleShipSlotWnd = {}

-- ----------------------------------------
-- window definition
-- ----------------------------------------

UI.Equipment_ActiveModuleShipSlotWnd.def =
{
	className	= "Wnd",
	prototype	= "Equipment_ModuleShipSlotWnd",

	props =
	{
		name		= "Equipment_ActiveModuleShipSlotWnd",
		isPrototype	= true,
	}
}

-- ----------------------------------------
-- const
-- ----------------------------------------

UI.Equipment_ActiveModuleShipSlotWnd.bNewVersion = true

-- ----------------------------------------
-- work functions
-- ----------------------------------------

--
function UI.Equipment_ActiveModuleShipSlotWnd:CreateControls()

	self.icoWnd = UI:CreateChildWnd( self, UI.ItemIcoWnd_1080_2, "" )

end


--
function UI.Equipment_ActiveModuleShipSlotWnd:SetupIcoForEmptyItem()
	
	self.icoWnd:HideIco()
	self.icoWnd:HideIcoMain()
	
end

-- -----------------------------------------------------------------
-- UI.Equipment_SpecModuleShipSlotWnd
-- отличается от базового Equipment_ModuleShipSlotWnd разрешением 1080 и другим размером
-- -----------------------------------------------------------------

UI.Equipment_SpecModuleShipSlotWnd = {}

-- ----------------------------------------
-- window definition
-- ----------------------------------------

UI.Equipment_SpecModuleShipSlotWnd.def =
{
	className	= "Wnd",
	prototype	= "Equipment_ModuleShipSlotWnd",

	props =
	{
		name		= "Equipment_SpecModuleShipSlotWnd",
		isPrototype	= true,
	}
}

-- ----------------------------------------
-- interface functions
-- ----------------------------------------

--
function UI.Equipment_SpecModuleShipSlotWnd:Reset()

	UI.Equipment_ModuleShipSlotWnd.Reset( self )
	
	self.icoWnd:HideIcoMain()	-- без фона
	self.icoWnd:HideMain() -- без фона

end


--
function UI.Equipment_SpecModuleShipSlotWnd:SetItem( itemId, defName )

	UI.Equipment_ModuleShipSlotWnd.SetItem( self, itemId, defName )
	
	self.icoWnd:HideColorBg2()	-- без полоски качества
	
end


-- ----------------------------------------
-- const
-- ----------------------------------------

UI.Equipment_SpecModuleShipSlotWnd.bNewVersion = true

-- ----------------------------------------
-- work functions
-- ----------------------------------------

--
function UI.Equipment_SpecModuleShipSlotWnd:CreateControls()

	self.icoWnd = UI:CreateChildWnd( self, UI.ItemIcoWnd_SpecModule_1080, "" )

end


--
function UI.Equipment_SpecModuleShipSlotWnd:SetupIcoForEmptyItem()
	
	self.icoWnd:HideIco()
	self.icoWnd:HideIcoMain()
	
end


-- -----------------------------------------------------------------
-- UI.Equipment_WeaponShipSlotWnd
-- отличается от базового Equipment_ModuleShipSlotWnd разрешением 1080 и другим размером
-- -----------------------------------------------------------------

UI.Equipment_WeaponShipSlotWnd = {}

-- ----------------------------------------
-- window definition
-- ----------------------------------------

UI.Equipment_WeaponShipSlotWnd.def =
{
	className	= "Wnd",
	prototype	= "Equipment_ModuleShipSlotWnd",

	props =
	{
		name		= "Equipment_WeaponShipSlotWnd",
		isPrototype	= true,
	}
}

-- ----------------------------------------
-- const
-- ----------------------------------------

UI.Equipment_WeaponShipSlotWnd.bNewVersion = true

-- ----------------------------------------
-- work functions
-- ----------------------------------------

--
function UI.Equipment_WeaponShipSlotWnd:CreateControls()

	self.icoWnd = UI:CreateChildWnd( self, UI.ItemIcoWnd_Weapon_1080, "" )

end


--
function UI.Equipment_WeaponShipSlotWnd:SetupIcoForEmptyItem()

	self.icoWnd:HideIco()
	self.icoWnd:HideIcoMain()

end


-- -----------------------------------------------------------------
-- UI.Equipment_AutogenShipSlotWnd
-- отличается от базового Equipment_ModuleShipSlotWnd разрешением 1080 и другим размером
-- -----------------------------------------------------------------

UI.Equipment_AutogenShipSlotWnd = {}

-- ----------------------------------------
-- window definition
-- ----------------------------------------

UI.Equipment_AutogenShipSlotWnd.def =
{
	className	= "Wnd",
	prototype	= "Equipment_ModuleShipSlotWnd",

	props =
	{
		name		= "Equipment_AutogenShipSlotWnd",
		isPrototype	= true,
	}
}

-- ----------------------------------------
-- const
-- ----------------------------------------

UI.Equipment_AutogenShipSlotWnd.bNewVersion = true

-- ----------------------------------------
-- work functions
-- ----------------------------------------

--
function UI.Equipment_AutogenShipSlotWnd:CreateControls()

	self.icoWnd = UI:CreateChildWnd( self, UI.ItemIcoWnd_Autogen_1080, "" )

end


--
function UI.Equipment_AutogenShipSlotWnd:SetupIcoForEmptyItem()

	self.icoWnd:HideIco()
	self.icoWnd:HideIcoMain()

end


-- -----------------------------------------------------------------
-- UI.Equipment_AmmoShipSlotWnd
-- -----------------------------------------------------------------

UI.Equipment_AmmoShipSlotWnd = {}
local ass = UI.Equipment_AmmoShipSlotWnd

-- ----------------------------------------
-- window definition
-- ----------------------------------------

UI.Equipment_AmmoShipSlotWnd.def =
{
	className	= "Wnd",
	prototype	= "Equipment_ShipSlotWnd",

	props =
	{
		name		= "Equipment_AmmoShipSlotWnd",
		isPrototype	= true,
	}
}

-- ----------------------------------------
-- interface functions
-- ----------------------------------------

--
function UI.Equipment_AmmoShipSlotWnd:SetItem( defName, count )

    self.defName	= defName
	self.count		= count

    self.icoWnd:SetupForItem( defName )    
	self:UpdateMouseOverState()
	self:SetupTooltipForItem()
	self:UpdateZeroCountEffect()

end


--
function UI.Equipment_AmmoShipSlotWnd:ResetItem()

    self.defName	= ""
	self.count		= 0

	self:SetupIcoForEmptyItem()
	self.icoWnd:HideRank()
	self:UpdateMouseOverState()
	self:SetupTooltipForEmptyItem()
	self.icoWnd:HideColorBg()
	self:UpdateZeroCountEffect()

end


--
function UI.Equipment_AmmoShipSlotWnd:GetDefName()

	return self.defName

end


--
function UI.Equipment_AmmoShipSlotWnd:GetCount()

	return self.count

end


--
function UI.Equipment_AmmoShipSlotWnd:Reset()
	
	UI.Equipment_ShipSlotWnd.Reset( self )

    self.defName		= ""
	self.count			= 0
	
end


-- ----------------------------------------
-- vars
-- ----------------------------------------

ass.defName		= ""
ass.count		= 0


-- ----------------------------------------
-- work functions
-- ----------------------------------------

--
function UI.Equipment_AmmoShipSlotWnd:SetupIcoForEmptyItem()

	local shipSlotTypeName	= UI:Val2Key( UI.shipSlotTypes, self.shipSlotType )
	local texName = string.format( "equipSlot_%s", shipSlotTypeName )
	
	local hTex = UI:GetTex( texName )
	self.icoWnd:SetupIco( hTex )

end


--
function UI.Equipment_AmmoShipSlotWnd:SetupTooltipForEmptyItem()

	local shipSlotTypeName = UI:Val2Key( UI.shipSlotTypes, self.shipSlotType )

	local tooltipText		= UI:GetStringByName( string.format( "equipSlot_%s_tipMsg", shipSlotTypeName ) )
	local tooltipCaption	= UI:GetStringByName( string.format( "equipSlot_%s_tipCaption", shipSlotTypeName ) )

	self.icoWnd:SetTooltipData( { tooltipType = UI.tooltipTypes.TEXT_LARGE, text = tooltipText, caption = tooltipCaption } )

end


--
function UI.Equipment_AmmoShipSlotWnd:SetupTooltipForLockedForWeaponState()

	local shipSlotTypeName = UI:Val2Key( UI.shipSlotTypes, self.shipSlotType )

	local tooltipText		= UI:GetStringByName( "equipSlot_unfitForWeaponSlot_tipMsg" )
	local tooltipCaption	= UI:GetStringByName( string.format( "equipSlot_%s_tipCaption", shipSlotTypeName ) )

	self.icoWnd:SetTooltipData( { tooltipType = UI.tooltipTypes.TEXT_LARGE, text = tooltipText, caption = tooltipCaption } )

end


--
function UI.Equipment_AmmoShipSlotWnd:UpdateZeroCountEffect()

	local bZeroCount = self.count == 0

	if bZeroCount then
		self.icoWnd:ShowNoAmmo()
		self.icoWnd:HideCount()
	else
		self.icoWnd:HideNoAmmo()
		self.icoWnd:HideCount()
	end

end


--
function UI.Equipment_AmmoShipSlotWnd:SetupTooltipForItem()

	local selShipItem = self:GetShipItem()

	local tooltipData = {}

	tooltipData.tooltipType		= UI.tooltipTypes.MODULE

	if selShipItem then
		tooltipData.dstShipData = UI.ModuleTooltipWnd.ShipData:CreateForVid( selShipItem.vid, self.slotId )
	else
		tooltipData.dstShipData = UI.ModuleTooltipWnd.ShipData:CreateForDef( self:GetShipDefName(), self.slotId )
	end

	tooltipData.defName			= self.defName
	tooltipData.bWithTalents	= true

	self.icoWnd:SetTooltipData( tooltipData )

end


--
function UI.Equipment_AmmoShipSlotWnd:IsEmpty()

	return self.defName == ""

end


-- -----------------------------------------------------------------
-- UI.Equipment_AmmoShipSlotWnd_new
-- отличается от базового Equipment_AmmoShipSlotWnd разрешением 1080
-- -----------------------------------------------------------------

UI.Equipment_AmmoShipSlotWnd_new = {}

-- ----------------------------------------
-- window definition
-- ----------------------------------------

UI.Equipment_AmmoShipSlotWnd_new.def =
{
	className	= "Wnd",
	prototype	= "Equipment_AmmoShipSlotWnd",

	props =
	{
		name		= "Equipment_AmmoShipSlotWnd_new",
		isPrototype	= true,
	}
}

-- ----------------------------------------
-- const
-- ----------------------------------------

UI.Equipment_AmmoShipSlotWnd_new.bNewVersion = true

-- ----------------------------------------
-- work functions
-- ----------------------------------------

--
function UI.Equipment_AmmoShipSlotWnd_new:CreateControls()

	self.icoWnd = UI:CreateChildWnd( self, UI.ItemIcoWnd_1080_2, "" )

end


--
function UI.Equipment_AmmoShipSlotWnd_new:SetupIcoForEmptyItem()
	
	self.icoWnd:HideIco()
	self.icoWnd:HideIcoMain()
	
end


-- ****************************************************************************
-- Внимание, хак!
-- Список предметов изначально не был предназначен для использования за пределами окна UI.EquipmentWnd.
-- Но сейчас он хаком превращен в прототип и испопльзуется также в дереве кораблей.
-- Меняя что-то здесь, надо убедиться, что там тоже не сломалось

-- ****************************************************************************

-- ----------------------------------------------------------------------------
-- UI.Equipment_ItemsListWnd_proto
-- ----------------------------------------------------------------------------

UI.Equipment_ItemsListWnd_proto = {}

-- -------------------------------
-- window definiiton
-- -------------------------------

UI.Equipment_ItemsListWnd_proto.layers =
{
	MAIN_EFFECT			= 0,
	CAPTION				= 1,
	LINK_EFFECT			= 2,
	WAIT_EQUIP_EFFECT	= 3,
	WAIT_EQUIP_TEXT		= 4,
}


UI.Equipment_ItemsListWnd_proto.def =
{
	className 	= "Wnd",
	prototype	= "ButtonsList3Wnd",

	props =
	{
		name			= "Equipment_ItemsListWnd_proto",
		isPrototype		= true,
	},

	layers =
	{
		firstOverlayLayer = UI.Equipment_ItemsListWnd_proto.layers.WAIT_EQUIP_EFFECT,

		-- MAIN_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,
			main		= true,
			updatable	= false,

			effects =
			{{
				defName 			= "equipment_itemsList",
				defaultAnimation	= "idle",

				links =
				{
					{
						objName		= "self",	
						animParams	= UI.EffectAnimParams.SIZE,
					},

					{
						objName		= "title",	
						layer		= "UI.Equipment_ItemsListWnd_proto.layers.CAPTION",
						animParams	= UI.EffectAnimParams.POS + UI.EffectAnimParams.SIZE + UI.EffectAnimParams.ALIGNMENT + UI.EffectAnimParams.FONT + UI.EffectAnimParams.BLEND + UI.EffectAnimParams.COLOR + UI.EffectAnimParams.ALPHA,
					},
				}
			}}
		},

		-- CAPTION
		{
			layerType		= UI.LAYER_TEXT,
   			formatFlags		= FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz	= { 1, 1 },
   			font			= { fontName = "Small" },
		},

		-- LINK_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "equipment_itemsList_link",
				defaultAnimation	= "idle",
			}}
		},

		-- WAIT_EQUIP_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "hangar_waitCircleLarge",
				defaultAnimation	= "idle",

				links =
				{
					{
						objName		= "value",
						layer		= "UI.Equipment_ItemsListWnd_proto.layers.WAIT_EQUIP_TEXT",
						animParams	= UI.EffectAnimParams.POS + UI.EffectAnimParams.SIZE + UI.EffectAnimParams.ALIGNMENT + UI.EffectAnimParams.FONT + UI.EffectAnimParams.BLEND + UI.EffectAnimParams.COLOR + UI.EffectAnimParams.ALPHA,
					},
				}
			}}
		},

		-- WAIT_EQUIP_TEXT
		{
			layerType	= UI.LAYER_TEXT,

   			formatFlags	 = FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz = { 1, 1 },
   			font =
			{
   				fontName = "Small",
   			},
			text = "^hangar_loading"
		},
	},
}

-- -------------------------------
-- interface functions
-- -------------------------------

--
function UI.Equipment_ItemsListWnd_proto:SetMode( mode )

	self.mode = mode

end


--
function UI.Equipment_ItemsListWnd_proto:GetMode()

	return self.mode

end


--
function UI.Equipment_ItemsListWnd_proto:UpdateBackBtn()

	local bNeedBtn = self:GetOpenItemsSubType() ~= -1

	if bNeedBtn then
		self:AddControl( self.backBtn, self.layers.MAIN_EFFECT, self.effectInfo.main.backBtn )
	else
		self:RemoveControl( self.backBtn, self.layers.MAIN_EFFECT )
	end

end


--
function UI.Equipment_ItemsListWnd_proto:Reset()

	UI.ButtonsList3Wnd.Clear( self )

	self:RemoveControl( self.backBtn, self.layers.MAIN_EFFECT )
	self:SetText( "", self.layers.CAPTION )

	self.mode = -1

end


--
function UI.Equipment_ItemsListWnd_proto:SetCaption( text )

	self:SetText( text, self.layers.CAPTION )

end


--
function UI.Equipment_ItemsListWnd_proto:SetWaitEffectVisible( bVisible )

	self:SetLayerVisible( bVisible, self.layers.WAIT_EQUIP_EFFECT )
	self:SetLayerVisible( bVisible, self.layers.WAIT_EQUIP_TEXT )

end


-- для перегрузки
function UI.Equipment_ItemsListWnd_proto:UpdateLayout()

	local selfX_screen = 0
	local selfY_screen = 0

	local selfParent = self:GetParent()
	local selfX_local = selfParent and selfParent:XToWindow( selfX_screen ) or selfX_screen
	local selfY_local = selfParent and selfParent:YToWindow( selfY_screen ) or selfY_screen
	
	self:SetPos( selfX_local, selfY_local )

	
	-- позиция эффекта ожидания

	local waitEffect = UI:GetEffectFromLayer( self, self.layers.WAIT_EQUIP_EFFECT )
	if waitEffect then
		local waitPos = UI:Vec2( self.waitX, ( self:GetHeight() - self.waitHeight ) * 0.5 )
		waitEffect:SetPos( waitPos )
	end
	
end


--
function UI.Equipment_ItemsListWnd_proto:GetCurrentItemRecord()

	local curRecordIdx = -1

	for recordIdx = 1, self:GetNumRecords() do

		local data = self:GetRecordData( recordIdx )

    	local item = data.item
    	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
    		item = item.subItemToShow
    	end

    	if item.itemType == UI.EquipmentWnd.itemTypes.INVENTORY then

    		if self:IsItemCurrent( item ) then
				curRecordIdx = recordIdx
				break
			end

    	end

	end

	return curRecordIdx

end


--
function UI.Equipment_ItemsListWnd_proto:GetFirstNonCurrentItemRecord()

	local nonCurRecordIdx = -1

	for recordIdx = 1, self:GetNumRecords() do

		local data = self:GetRecordData( recordIdx )

    	local item = data.item
    	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
    		item = item.subItemToShow
    	end

    	if item.itemType == UI.EquipmentWnd.itemTypes.INVENTORY then

    		if not self:IsItemCurrent( item ) then
				nonCurRecordIdx = recordIdx
				break
			end

    	end

	end

	return nonCurRecordIdx

end


--
function UI.Equipment_ItemsListWnd_proto:OnVesselBudgetLevelUp()

	if self.mode ~= self.modes.SPEC_MODULE then
		return
	end

	for slotIdx = 1, self:GetNumVisibleSlots() do
		local slotWnd = self:GetButtonForSlot( slotIdx )
		if slotWnd then
			slotWnd:OnVesselBudgetLevelUp()
		end
	end

end


--
function UI.Equipment_ItemsListWnd_proto:OnVesselBudgetChanged()

	if self.mode ~= self.modes.SPEC_MODULE then
		return
	end

	for slotIdx = 1, self:GetNumVisibleSlots() do
		local slotWnd = self:GetButtonForSlot( slotIdx )
		if slotWnd then
			slotWnd:OnVesselBudgetChanged()
		end
	end

end


--
function UI.Equipment_ItemsListWnd_proto:OnVesselBudgetActivate()

	if self.mode ~= self.modes.SPEC_MODULE then
		return
	end

	for slotIdx = 1, self:GetNumVisibleSlots() do
		local slotWnd = self:GetButtonForSlot( slotIdx )
		if slotWnd then
			slotWnd:OnVesselBudgetActivate()
		end
	end

end


--
function UI.Equipment_ItemsListWnd_proto:ShowUpgradeItemWowEffect( iid )

	if self.mode == self.modes.SPEC_MODULE then
		return
	end

	for recordIdx = 1, self:GetNumRecords() do

		local bRecordFit = false

		local data = self:GetRecordData( recordIdx )

    	local item = data.item
    	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
    		item = item.subItemToShow
    	end

    	if item.itemType == UI.EquipmentWnd.itemTypes.INVENTORY then

			if item.inventoryItems then
				for itemIdx, item in pairs( item.inventoryItems ) do
					if item.iid == iid then
						bRecordFit = true
						break
					end
				end
			end

    	end

		if bRecordFit then

			local slotWnd = self:GetButtonForRecord( recordIdx )
			if slotWnd then
				slotWnd:ShowUpgradeItemWowEffect()
			end

			break

		end

	end

end


-- -------------------------------
-- const
-- -------------------------------

UI.Equipment_ItemsListWnd_proto.btnPrototypeName = "Equipment_Items_SlotWnd"

UI.Equipment_ItemsListWnd_proto.effectInfo =
{
	main =
	{
		slotObjNamePrefix	= "slot_",
		scrollObjName		= "scroll_max",
		animIdle			= "idle",
		backBtn				= "btn_3",
		linkLocator			= "modul_bg",
		numSlotsLocators	= 4,
		minHeightLocator	= "dist_min",
		maxHeightLocator	= "self",		
		waitLocator			= "load_modules",
	},

	link =
	{
		orgLocator	= "center"
	}
}

UI.Equipment_ItemsListWnd_proto.MAX_SLOTS = 0

UI.Equipment_ItemsListWnd_proto.listStyle = UI.BaseListWnd.listStyles.HIDE_EMPTY_SLOTS + UI.BaseListWnd.listStyles.FIXED_SELECTION + UI.BaseListWnd.listStyles.HIDE_SCROLL_BAR_IF_NO_NEED

UI.Equipment_ItemsListWnd_proto.modes =
{
	REGULAR		= 1,
	SPEC_MODULE	= 2,
}

-- -------------------------------
-- vars
-- -------------------------------

UI.Equipment_ItemsListWnd_proto.minHeight			= 0
UI.Equipment_ItemsListWnd_proto.maxHeight			= 0
UI.Equipment_ItemsListWnd_proto.space_top_slots		= 0
UI.Equipment_ItemsListWnd_proto.space_slots_btm		= 0
UI.Equipment_ItemsListWnd_proto.space_link_btm		= 0
UI.Equipment_ItemsListWnd_proto.space_top_scroll	= 0
UI.Equipment_ItemsListWnd_proto.space_scroll_btm	= 0
UI.Equipment_ItemsListWnd_proto.linkOrg				= Vec2( 0, 0 )
UI.Equipment_ItemsListWnd_proto.linkX				= 0
UI.Equipment_ItemsListWnd_proto.btnsPool			= {}
UI.Equipment_ItemsListWnd_proto.numBtnsTotal		= 0
UI.Equipment_ItemsListWnd_proto.waitX				= 0
UI.Equipment_ItemsListWnd_proto.waitHeight			= 0
UI.Equipment_ItemsListWnd_proto.mode				= -1
UI.Equipment_ItemsListWnd_proto.backBtn				= nil
UI.Equipment_ItemsListWnd_proto.crossBtn			= nil

-- -------------------------------
-- work functions
-- -------------------------------

--
function UI.Equipment_ItemsListWnd_proto:F_PostLoad()

	UI.ButtonsList3Wnd.F_PostLoad( self )

	if self:IsPrototype() then
		return
	end

	self.linkOrg	= Vec2( 0, 0 )
	self.btnsPool	= {}

	self:CreateControls()
	self:PrepareLayout()

	self:SetWaitEffectVisible( false )

end


--
function UI.Equipment_ItemsListWnd_proto:CreateControls()

	self.backBtn	= UI:CreateChildWnd( self, UI.Equipment_ItemsList_BackBtn, "" )
	self.crossBtn	= UI:CreateChildWnd( self, UI.Equipment_ItemsList_CrossBtn, "" )

	local mainEffect = UI:GetEffectFromLayer( self, self.layers.MAIN_EFFECT )
	UI:AddChildAndLink( self, self.crossBtn, mainEffect, "btn_x", UI.EffectAnimParams.POS )

end


--
function UI.Equipment_ItemsListWnd_proto:UpdateOnChangeVisibleRange( bUpdateScrollBar, bAnimated )

	UI.BaseListWnd.UpdateOnChangeVisibleRange( self, bUpdateScrollBar, bAnimated )

	local targetWnd = UI:GetCurTooltipTarget()
	if targetWnd and targetWnd:IsChildOf( self ) then
		UI:ResetTooltip()
	end

end


--
function UI.Equipment_ItemsListWnd_proto:OnPlayerCreditsChanged()

	for slotIdx = 1, self:GetNumVisibleSlots() do
		local slotWnd = self:GetButtonForSlot( slotIdx )
		if slotWnd then
			slotWnd:OnPlayerCreditsChanged()
		end
	end

end


--
function UI.Equipment_ItemsListWnd_proto:OnAccountAurasChanged()

	for slotIdx = 1, self:GetNumVisibleSlots() do
		local slotWnd = self:GetButtonForSlot( slotIdx )
		if slotWnd then
			slotWnd:OnAccountAurasChanged()
		end
	end

end


--
function UI.Equipment_ItemsListWnd_proto:AddControl( wnd, effectLayer, locatorName )

	if not wnd then
		return
	end

    local effect = UI:GetEffectFromLayer( self, effectLayer )

	if wnd:IsChildOf( self ) and effect then
    	effect:UnlinkWnd( wnd:GetUiHandle(), "" )
	end

	UI:AddChildAndLink( self, wnd, effect, locatorName, UI.EffectAnimParams.POS )

end


--
function UI.Equipment_ItemsListWnd_proto:RemoveControl( wnd, effectLayer )

	if not wnd or not wnd:IsChildOf( self ) then
		return
	end

	wnd:UnlinkFromParent()

	local effect = UI:GetEffectFromLayer( self, effectLayer )
	if effect then
		effect:UnlinkWnd( wnd:GetUiHandle(), "" )
	end

end


--
function UI.Equipment_ItemsListWnd_proto:InitSlots()

	return

end


--
function UI.Equipment_ItemsListWnd_proto:UpdateMaxSlots()

	if self:GetNumRecords() ~= 0 then
		sys.log( "UI.Equipment_ItemsListWnd_proto:UpdateMaxSlots()[ERROR]: not empty" )
		return
	end

	local maxSlots = 0

	local selfMaxHeight = self:GetMaxHeight()
	selfMaxHeight = UI:Clamp( selfMaxHeight, self.minHeight, self.maxHeight )

	local slotsMaxHeight = selfMaxHeight - self.space_top_slots - self.space_slots_btm
	slotsMaxHeight = math.max( slotsMaxHeight, 0 )

	local slotHeight	= UI[ self.btnPrototypeName ]:GetAssumedHeight()

	local mainEffect	= UI:GetEffectFromLayer( self, self.layers.MAIN_EFFECT )

	local firstSlotPos	= mainEffect and mainEffect:GetObjPos( string.format( "%s%d", self.effectInfo.main.slotObjNamePrefix, 1 ) ) or Vec2( 0, 0 )
	local secondSlotPos	= mainEffect and mainEffect:GetObjPos( string.format( "%s%d", self.effectInfo.main.slotObjNamePrefix, 2 ) ) or Vec2( 0, 0 )
	local space_slots	= secondSlotPos.y - ( firstSlotPos.y + slotHeight )

	if slotHeight + space_slots ~= 0 then
		maxSlots = math.floor( ( slotsMaxHeight + space_slots ) / ( slotHeight + space_slots ) )
	end
	
	if maxSlots <= 0 then
		maxSlots = 1
	end

	if maxSlots > 9 then
		maxSlots = 9
	end
	
	if maxSlots == self.MAX_SLOTS then
		return
	end

	self:ResetMaxSlots()

	self.MAX_SLOTS = maxSlots

	for slotIdx = 1, self.MAX_SLOTS + 1 do

		local slot = { idx = slotIdx }	
		table.insert( self.allSlots, slot )

		slot.btn = self:ObtainBtn()
		if slot.btn then
			slot.btn:SetSlot( slotIdx, self )
		end

	end

	-- вызов базовой функции для апдейта маски и др. параметров
	self:RecalcLayout()


	-- скроллбар

	self.scrollBar:SetPageSize( self.MAX_SLOTS )

	local scrollEffect = UI:GetEffectFromLayer( self.scrollBar, self.scrollBar.layers.MAIN_EFFECT )
	if mainEffect and scrollEffect then

		local selfMaxHeightFixed = slotHeight * maxSlots + space_slots * ( maxSlots - 1 ) + self.space_top_slots + self.space_slots_btm

    	local scrollNeedHeight = selfMaxHeightFixed - self.space_scroll_btm - self.space_top_scroll
    	local scrollBaseHeight = scrollEffect:GetObjSize( "self" ).y

    	local scrollScale_y = scrollNeedHeight / scrollBaseHeight
    	scrollEffect:SetScale( UI:Vec2( 1, scrollScale_y ) )

    	self.scrollBar:SetHeight( scrollNeedHeight )

    	self:UpdateScrollBarVisibility()

	end

end


-- Для перегрузки
function UI.Equipment_ItemsListWnd_proto:GetMaxHeight()

	return 768
	
end


--
function UI.Equipment_ItemsListWnd_proto:ResetMaxSlots()

	for idx, slot in pairs( self.allSlots ) do
		if slot.btn then
			table.insert( self.btnsPool, slot.btn )
		end
	end

	self.allSlots = {}
	self.MAX_SLOTS = 0

end


--
function UI.Equipment_ItemsListWnd_proto:ObtainBtn()

	local idx, btn = next( self.btnsPool )
	if btn then
		self.btnsPool[ idx ] = nil
		return btn
	end

	local btnProto = UI[ self.btnPrototypeName ]
	if btnProto then

		btn = UI:CreateChildWnd( self, btnProto, tostring( self.numBtnsTotal + 1 ) )
		self.numBtnsTotal = self.numBtnsTotal + 1

	else
		sys.log( "UI.Equipment_ItemsListWnd_proto:ObtainBtn()[ERROR]: cnnot find prototype for slots: \"%s\" in list \"%s\"", tostring( self.btnPrototypeName ), self:GetScriptTableName() )
	end

	return btn	

end


--
function UI.Equipment_ItemsListWnd_proto:DeleteControls()

	if self.scrollBar then
		UI:RemoveUiObj( self.scrollBar:GetUiHandle() )
		self.scrollBar = nil
	end

	for idx, slot in pairs( self.allSlots ) do
		if slot.btn then
			UI:RemoveUiObj( slot.btn:GetUiHandle() )
			slot.btn = nil
		end
	end

	for idx, btn in pairs( self.btnsPool ) do
		UI:RemoveUiObj( btn:GetUiHandle() )
	end
	self.btnsPool = {}

end


--
function UI.Equipment_ItemsListWnd_proto:PrepareLayout()

	local mainEffect		= UI:GetEffectFromLayer( self, self.layers.MAIN_EFFECT )
	local linkEffect		= UI:GetEffectFromLayer( self, self.layers.LINK_EFFECT )
	local waitEffect		= UI:GetEffectFromLayer( self, self.layers.WAIT_EQUIP_EFFECT )

	local firstSlotPos		= mainEffect and mainEffect:GetObjPos( string.format( "%s%d", self.effectInfo.main.slotObjNamePrefix, 1 ) ) or Vec2( 0, 0 )
	local secondSlotPos		= mainEffect and mainEffect:GetObjPos( string.format( "%s%d", self.effectInfo.main.slotObjNamePrefix, 2 ) ) or Vec2( 0, 0 )
	local lastSlotPos		= mainEffect and mainEffect:GetObjPos( string.format( "%s%d", self.effectInfo.main.slotObjNamePrefix, self.effectInfo.main.numSlotsLocators ) ) or Vec2( 0, 0 )
	local selfMinSize		= mainEffect and mainEffect:GetObjSize( self.effectInfo.main.minHeightLocator ) or Vec2( 0, 0 )
	local selfMaxSize		= mainEffect and mainEffect:GetObjSize( self.effectInfo.main.maxHeightLocator ) or Vec2( 0, 0 )
	local linkPos			= mainEffect and mainEffect:GetObjPos( self.effectInfo.main.linkLocator ) or Vec2( 0, 0 )
	local slotHeight		= UI[ self.btnPrototypeName ]:GetAssumedHeight()
	local space_slots		= secondSlotPos.y - ( firstSlotPos.y + slotHeight )
	local slotsBtm			= lastSlotPos.y + slotHeight
	local linkOrg			= linkEffect and linkEffect:GetObjPos( self.effectInfo.link.orgLocator ) or Vec2( 0, 0 )
	local scrollPos			= mainEffect and mainEffect:GetObjPos( self.effectInfo.main.scrollObjName ) or Vec2( 0, 0 )
	local scrollSize		= mainEffect and mainEffect:GetObjSize( self.effectInfo.main.scrollObjName ) or Vec2( 0, 0 )
	local waitPos			= mainEffect and mainEffect:GetObjPos( self.effectInfo.main.waitLocator ) or Vec2( 0, 0 )
	local waitRect			= waitEffect and waitEffect:CalcApproximateRect() or Quat( 0, 0, 0, 0 )

	self.space_top_slots	= firstSlotPos.y
	self.space_slots_btm	= selfMaxSize.y - slotsBtm
	self.space_link_btm		= selfMaxSize.y - linkPos.y
	self.minHeight			= selfMinSize.y
	self.maxHeight			= selfMaxSize.y
	self.linkOrg			= linkOrg
	self.linkX				= linkPos.x
	self.space_top_scroll	= scrollPos.y                 
	self.space_scroll_btm	= selfMaxSize.y - ( scrollPos.y + scrollSize.y )
	self.waitX				= waitPos.x
	self.waitHeight			= waitRect.w

end


--
function UI.Equipment_ItemsListWnd_proto:GetOpenItemsSubType()

	return UI.EquipmentWnd:GetOpenItemsSubType()

end


--
function UI.Equipment_ItemsListWnd_proto:GetSelShipSlot()

	return UI.EquipmentWnd:GetSelShipSlot()

end


--
function UI.Equipment_ItemsListWnd_proto:IsItemCurrent( item )

	return UI.EquipmentWnd:IsItemCurrent( item )

end


-- ----------------------------------------------------------------------------
-- UI.Equipment_ItemsListWnd
-- ----------------------------------------------------------------------------

UI.Equipment_ItemsListWnd = {}

-- ------------------------------
-- window definition
-- ------------------------------
 
UI.Equipment_ItemsListWnd.def =
{
	className	= "Wnd",
	prototype	= "Equipment_ItemsListWnd_proto",

	props =
	{
		name	= "Equipment_ItemsListWnd"
	},
	
	layers =
	{
		-- MAIN_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,
			main		= true,
			updatable	= false,

			effects =
			{{
				id			= UI.Equipment_ItemsListWnd_proto.layers.MAIN_EFFECT,
				defName 			= "equipment_itemsList_1080",
				defaultAnimation	= "idle",

				links =
				{
					{
						objName		= "self",	
						animParams	= UI.EffectAnimParams.SIZE,
					},

					{
						objName		= "title",	
						layer		= "UI.Equipment_ItemsListWnd_proto.layers.CAPTION",
						animParams	= UI.EffectAnimParams.ALL,
					},
				}
			}}
		},

		-- WAIT_EQUIP_EFFECT
		{
			id			= UI.Equipment_ItemsListWnd_proto.layers.WAIT_EQUIP_EFFECT,
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "hangar_waitCircleLarge_1080",
				defaultAnimation	= "idle",

				links =
				{
					{
						objName		= "value",
						layer		= "UI.Equipment_ItemsListWnd_proto.layers.WAIT_EQUIP_TEXT",
						animParams	= UI.EffectAnimParams.ALL,
					},
				}
			}}
		},
	},
}

-- ------------------------------
-- const
-- ------------------------------

UI.Equipment_ItemsListWnd.SPACE_BTM_SCREEN			= UI:YTo1024x768( 100 )
UI.Equipment_ItemsListWnd.SPACE_BTM_SHIP_SLOT		= UI:YTo1024x768( 15 )
UI.Equipment_ItemsListWnd.SPACE_RIGHT_SHIP_SLOT		= UI:XTo1024x768( 0 )
UI.Equipment_ItemsListWnd.btnPrototypeName			= "Equipment_Items_SlotWnd_1080"
UI.Equipment_ItemsListWnd.scrollBarPrototypeName	= "ButtonsList3Wnd_ScrollBarWnd_1080"

-- ------------------------------
-- work functions
-- ------------------------------

--
function UI.Equipment_ItemsListWnd:CreateControls()

	self.backBtn	= UI:CreateChildWnd( self, UI.Equipment_ItemsList_BackBtn_1080, "" )
	self.crossBtn	= UI:CreateChildWnd( self, UI.Equipment_ItemsList_CrossBtn_1080, "" )

	local mainEffect = UI:GetEffectFromLayer( self, self.layers.MAIN_EFFECT )
	UI:AddChildAndLink( self, self.crossBtn, mainEffect, "btn_x", UI.EffectAnimParams.POS )

end


-- отличается от базовой версии тем, что не обращается к локаторам linkLocator и orgLocator, т.к. в новой версии не эффекта смычки со слотом
function UI.Equipment_ItemsListWnd:PrepareLayout()

	local mainEffect		= UI:GetEffectFromLayer( self, self.layers.MAIN_EFFECT )
	local waitEffect		= UI:GetEffectFromLayer( self, self.layers.WAIT_EQUIP_EFFECT )

	local firstSlotPos		= mainEffect and mainEffect:GetObjPos( string.format( "%s%d", self.effectInfo.main.slotObjNamePrefix, 1 ) ) or Vec2( 0, 0 )
	local secondSlotPos		= mainEffect and mainEffect:GetObjPos( string.format( "%s%d", self.effectInfo.main.slotObjNamePrefix, 2 ) ) or Vec2( 0, 0 )
	local lastSlotPos		= mainEffect and mainEffect:GetObjPos( string.format( "%s%d", self.effectInfo.main.slotObjNamePrefix, self.effectInfo.main.numSlotsLocators ) ) or Vec2( 0, 0 )
	local selfMinSize		= mainEffect and mainEffect:GetObjSize( self.effectInfo.main.minHeightLocator ) or Vec2( 0, 0 )
	local selfMaxSize		= mainEffect and mainEffect:GetObjSize( self.effectInfo.main.maxHeightLocator ) or Vec2( 0, 0 )
	local slotHeight		= UI[ self.btnPrototypeName ]:GetAssumedHeight()
	local space_slots		= secondSlotPos.y - ( firstSlotPos.y + slotHeight )
	local slotsBtm			= lastSlotPos.y + slotHeight
	local scrollPos			= mainEffect and mainEffect:GetObjPos( self.effectInfo.main.scrollObjName ) or Vec2( 0, 0 )
	local scrollSize		= mainEffect and mainEffect:GetObjSize( self.effectInfo.main.scrollObjName ) or Vec2( 0, 0 )
	local waitPos			= mainEffect and mainEffect:GetObjPos( self.effectInfo.main.waitLocator ) or Vec2( 0, 0 )
	local waitRect			= waitEffect and waitEffect:CalcApproximateRect() or Quat( 0, 0, 0, 0 )

	self.space_top_slots	= firstSlotPos.y
	self.space_slots_btm	= selfMaxSize.y - slotsBtm
	self.minHeight			= selfMinSize.y
	self.maxHeight			= selfMaxSize.y
	self.space_top_scroll	= scrollPos.y
	self.space_scroll_btm	= selfMaxSize.y - ( scrollPos.y + scrollSize.y )
	self.waitX				= waitPos.x
	self.waitHeight			= waitRect.w

end


--
function UI.Equipment_ItemsListWnd:GetMaxHeight()

	local selShipSlotWnd = self:GetSelShipSlot()
	local slotType = selShipSlotWnd and selShipSlotWnd:GetShipSlotType() or -1

	local selfY_screen = UI.HangarWnd:GetTopPanelBtm()
	local selfBtm_screen = 768 - self.SPACE_BTM_SCREEN
	
	if not UI.EquipmentWnd:IsShipSlotTypePassive( slotType ) then
		if selShipSlotWnd then
			local slotY_screen = selShipSlotWnd:GetParent():YToScreen( selShipSlotWnd:GetTop() )
			selfBtm_screen = slotY_screen - self.SPACE_BTM_SHIP_SLOT
		end
	end

	return selfBtm_screen - selfY_screen

end


--
function UI.Equipment_ItemsListWnd:UpdateLayout()

	local selShipSlotWnd = self:GetSelShipSlot()
	if not selShipSlotWnd then
		sys.log( "UI.Equipment_ItemsListWnd:UpdateLayout()[ERROR]: no selected ship slot" )
		return
	end

	-- собственная высота

	local numVisibleSlots = math.min( self:GetNumRecords(), self.MAX_SLOTS )
	local slotsHeight = self.slotHeight * numVisibleSlots  + self.slotsSpace * ( numVisibleSlots - 1 )

	local selfHeight = slotsHeight + self.space_top_slots + self.space_slots_btm
	selfHeight = UI:Clamp( selfHeight, self.minHeight, self.maxHeight )

	self:SetHeight( selfHeight )

	local animTime = ( selfHeight - self.minHeight ) / ( self.maxHeight - self.minHeight )

	local mainEffect = UI:GetEffectFromLayer( self, self.layers.MAIN_EFFECT )
	if mainEffect then
		mainEffect:SetAnimationTimeAndUpdate( animTime )
	end


	-- собственная позиция
	
	local slotType = selShipSlotWnd:GetShipSlotType()
	local slotPos = UI:Vec2( selShipSlotWnd:GetLeft(), selShipSlotWnd:GetTop() )
	local selfWidth = self:GetWidth()
	local selfHeight = self:GetHeight()
	
	local selfX_screen = 0
	local selfY_screen = 0
	
	-- расположение для пассивнх слотов
	if UI.EquipmentWnd:IsShipSlotTypePassive( slotType ) then

		-- x - слева от пассивных слотов
		--we manually align it later in this if block so we don't care about this
		--selfX_screen = 1920 - self.SPACE_RIGHT_SHIP_SLOT - selfWidth
		
		--just copied this from the line that adjusts the Y, it and it just kinda works lmao im taking it
		selfX_screen = 111+selShipSlotWnd:GetParent():XToScreen( slotPos.x ) + selShipSlotWnd:GetWidth() / 2 - selfWidth / 2
		
		if selfX_screen < 0 then
			selfX_screen = 0
		end
		
		if selfX_screen + selfWidth > 994 then
			selfX_screen = 994 - selfWidth
		end
		
		
		-- y - по центру выделенного слота
		selfY_screen = selShipSlotWnd:GetParent():YToScreen( slotPos.y ) + selShipSlotWnd:GetHeight() / 2 - selfHeight / 2
		
		local yMin = UI.HangarWnd:GetTopPanelBtm()
		local yMax = 670 - self.SPACE_BTM_SCREEN
		
		if selfY_screen + selfHeight > yMax then
			selfY_screen = yMax - selfHeight
		end
		
		--if selfY_screen < yMin then
			--selfY_screen = yMin
		--end
	
	-- расположение для всех остальных слотов
	else
	
		-- x - по левому краю выделенного слота
		selfX_screen = selShipSlotWnd:GetParent():XToScreen( slotPos.x )
		
		if selfX_screen + selfWidth > 1024 then
			selfX_screen = 1024 - selfWidth
		end
		
		-- y - над выделенным слотом
		selfY_screen = selShipSlotWnd:GetParent():YToScreen( slotPos.y ) - self.SPACE_BTM_SHIP_SLOT - selfHeight
	
	end
	
	local selfParent = self:GetParent()
	local selfX_local = selfParent and selfParent:XToWindow( selfX_screen ) or selfX_screen
	local selfY_local = selfParent and selfParent:YToWindow( selfY_screen ) or selfY_screen
	
	self:SetPos( selfX_local, selfY_local )

	
	-- позиция эффекта ожидания

	local waitEffect = UI:GetEffectFromLayer( self, self.layers.WAIT_EQUIP_EFFECT )
	if waitEffect then

		local waitPos = UI:Vec2( self.waitX, ( selfHeight - self.waitHeight ) * 0.5 )
		waitEffect:SetPos( waitPos )
	end
	
	-- нет смычки со слотом
	self:SetLayerVisible( false, self.layers.LINK_EFFECT )

end

-- ----------------------------------------------------------------------------
-- UI.Equipment_ItemsList_BackBtn
-- ----------------------------------------------------------------------------

UI.Equipment_ItemsList_BackBtn =
{
	def =
	{
    	className	= "ButtonWnd",
    	prototype	= "TextBtn",

    	props =
    	{
    		name		= "Equipment_ItemsList_BackBtn",
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
    				defName 			= "equipment_itemsList_backBtn",
    				defaultAnimation	= "idle",

    				links =
    				{
    					{
    						objName		= "self",	
    						animParams	= UI.EffectAnimParams.SIZE,
    					},

    					{
    						objName		= "text_1",
    						layer		= "UI.TextBtn.layers.TEXT",
    						animParams	= UI.EffectAnimParams.POS + UI.EffectAnimParams.SIZE + UI.EffectAnimParams.ALIGNMENT + UI.EffectAnimParams.FONT + UI.EffectAnimParams.BLEND + UI.EffectAnimParams.COLOR + UI.EffectAnimParams.ALPHA,
    					},
    				}
    			}}
    		},
		}
	},

	textId = "equipment_itemsBackBtn"
}

-- ----------------------------------------------------------------------------
-- UI.Equipment_ItemsList_BackBtn_1080
-- ----------------------------------------------------------------------------

UI.Equipment_ItemsList_BackBtn_1080 =
{
	def =
	{
		className	= "ButtonWnd",
		prototype	= "Equipment_ItemsList_BackBtn",
	
		props =
		{
			name		= "Equipment_ItemsList_BackBtn_1080",
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
					defName 			= "equipment_itemsList_backBtn_1080",
					defaultAnimation	= "idle",
	
					links =
					{
						{
							objName		= "self",
							animParams	= UI.EffectAnimParams.SIZE,
						},
	
						{
							objName		= "text_1",
							layer		= "UI.TextBtn.layers.TEXT",
							animParams	= UI.EffectAnimParams.POS + UI.EffectAnimParams.SIZE + UI.EffectAnimParams.ALIGNMENT + UI.EffectAnimParams.FONT + UI.EffectAnimParams.BLEND + UI.EffectAnimParams.COLOR + UI.EffectAnimParams.ALPHA,
						},
					}
				}}
			},
		}
	},
}

-- ----------------------------------------------------------------------------
-- UI.Equipment_ItemsList_CrossBtn
-- ----------------------------------------------------------------------------

UI.Equipment_ItemsList_CrossBtn =
{
	def =
	{
    	className 	= "ButtonWnd",
    	prototype	= "CrossBtn",

    	props =
    	{
    		name		= "Equipment_ItemsList_CrossBtn",
			isPrototype	= true,
    	}
	}
}

-- ----------------------------------------------------------------------------
-- UI.Equipment_ItemsList_CrossBtn_1080
-- ----------------------------------------------------------------------------

UI.Equipment_ItemsList_CrossBtn_1080 =
{
	def =
	{
		className 	= "ButtonWnd",
		prototype	= "Equipment_ItemsList_CrossBtn",
	
		props =
		{
			name		= "Equipment_ItemsList_CrossBtn_1080",
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
					defName				= "crossBtn_1080",
					defaultAnimation    = "idle",
		
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
	},

	effectInfo =
	{
		main =
		{
			animationIdle 			= "idle",
			animationSelect			= "over",
			animationPressed		= "press",
			animationDisabled		= "",
			animationIdle_focus 	= "",
			animationSelect_focus	= "",
			animationPressed_focus	= "",
		},
	}
}

-- ****************************************************************************
-- Внимание, хак! Этот "класс" используется в дереве кораблей, хотя изначально не был предназначен.
-- Внося изменения здесь, надо проследить, что там ничего не сломалось.

-- ****************************************************************************

-- ----------------------------------------------------------------------------
-- UI.Equipment_Items_SlotWnd
-- ----------------------------------------------------------------------------

UI.Equipment_Items_SlotWnd = {}
local eis = UI.Equipment_Items_SlotWnd

-- --------------------------------------
-- window definition
-- --------------------------------------

eis.layers =
{
    MAIN_EFFECT				= 0,
	CUR_EFFECT				= 1,
    NAME					= 2,
	PRICE_VAL				= 3,
	EQUIP_STATE				= 4,  
	NEW_EFFECT				= 5,
	SALE_EFFECT				= 6,
	INACTIVE_EFFECT			= 7,  
	MOUSE_OVER_EFFECT		= 8,
}


UI.Equipment_Items_SlotWnd.def =
{
	className 	= "Wnd",
	prototype	= "ButtonsList3_Btn",

	props =
	{
		name			= "Equipment_Items_SlotWnd",
		isPrototype		= true,
	},

	layers =
	{
		firstOverlayLayer = eis.layers.SALE_EFFECT,

		-- MAIN_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,
			main		= true,

			effects =
			{{
				defName 			= "equipment_itemsList_slot_main",
				defaultAnimation	= "idle",

				links =
				{
					{
						objName		= "self",	
						animParams	= UI.EffectAnimParams.SIZE,
					},

					{
						objName		= "product_name",
						layer		= "UI.Equipment_Items_SlotWnd.layers.NAME",
						animParams	= UI.EffectAnimParams.POS + UI.EffectAnimParams.SIZE + UI.EffectAnimParams.ALIGNMENT + UI.EffectAnimParams.FONT + UI.EffectAnimParams.BLEND + UI.EffectAnimParams.COLOR + UI.EffectAnimParams.ALPHA,
					},

					{
						objName		= "over",
						layer		= "UI.Equipment_Items_SlotWnd.layers.MOUSE_OVER_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "blackout",
						layer		= "UI.Equipment_Items_SlotWnd.layers.INACTIVE_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					-- не линкуется по позиции
					{
						objName		= "price",
						layer		= "UI.Equipment_Items_SlotWnd.layers.PRICE_VAL",
						animParams	= UI.EffectAnimParams.SIZE + UI.EffectAnimParams.ALIGNMENT + UI.EffectAnimParams.FONT + UI.EffectAnimParams.BLEND + UI.EffectAnimParams.COLOR + UI.EffectAnimParams.ALPHA,
					},

					{
						objName		= "sale",
						layer		= "UI.Equipment_Items_SlotWnd.layers.SALE_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "progr11",
						layer		= "UI.Equipment_Items_SlotWnd.layers.EQUIP_STATE",
						animParams	= UI.EffectAnimParams.POS + UI.EffectAnimParams.SIZE + UI.EffectAnimParams.ALIGNMENT + UI.EffectAnimParams.FONT + UI.EffectAnimParams.BLEND + UI.EffectAnimParams.COLOR + UI.EffectAnimParams.ALPHA,
					},

					{
						objName		= "select",
						layer		= "UI.Equipment_Items_SlotWnd.layers.CUR_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "labe",
						layer		= "UI.Equipment_Items_SlotWnd.layers.NEW_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},
				}
			}}
		},

		-- CUR_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "equipment_itemsList_slot_cur",
				defaultAnimation	= "idle",
			}}
		},

		-- NAME
		{
			layerType	= UI.LAYER_TEXT,

   			formatFlags	 = FONT.TF_WORDBREAK,
   			formatInfoSz = { 3, 1 },
   			font =
			{
   				fontName = "Small",
   			},
		},

		-- PRICE_VAL
		{
			layerType	= UI.LAYER_TEXT,
			layerStyle	= UI.WLS_OWNERDRAW,
   			formatFlags	 = FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz = { 1, 1 },
   			font =
			{
   				fontName = "Small",
   			},
		},

		-- EQUIP_STATE
		{
			layerType	= UI.LAYER_TEXT,
			layerStyle	= UI.WLS_OWNERDRAW,
   			formatFlags	 = FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz = { 1, 1 },
   			font =
			{
   				fontName = "Small",
   			},
		},

		-- NEW_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "ships_shipSlot_action",
			}}
		},

		-- SALE_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "equipment_itemsList_slot_sale",
				defaultAnimation	= "idle",
			}}
		},

		-- INACTIVE_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE + UI.WLS_TEXT_PICKER_TRANSPARENT,

			effects =
			{{
				defName 			= "equipment_itemsList_slot_inactive",
				defaultAnimation	= "idle",
			}}
		},

		-- MOUSE_OVER_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE + UI.WLS_TEXT_PICKER_TRANSPARENT,

			effects =
			{{
				defName 			= "equipment_itemsList_slot_mouseOver",
				defaultAnimation	= "idle",
			}}
		},
	}
}

-- --------------------------------------
-- interface functions
-- --------------------------------------

--
function UI.Equipment_Items_SlotWnd:Reset()

	UI.ButtonsList3_Btn.Reset( self )

	self.icoWnd:Reset()

	self:SetMouseOver( false )

	self.openSubTreeBtn:Reset()
	self:RemoveControl( self.openSubTreeBtn, self.layers.MAIN_EFFECT )

	self:HideActionBtn()

	self:SetText( "", self.layers.NAME )

	self:SetLayerVisible( false, self.layers.INACTIVE_EFFECT )
	self:SetLayerVisible( false, self.layers.PRICE_VAL )
	self:SetLayerVisible( false, self.layers.SALE_EFFECT )
	self:SetLayerVisible( false, self.layers.EQUIP_STATE )
	self:SetLayerVisible( false, self.layers.CUR_EFFECT )
	self:SetLayerVisible( false, self.layers.NEW_EFFECT )

	if self.priceMetaText then
		self.priceMetaText:SetText( "", true )
	end

	if self.equipStateMetaText then
		self.equipStateMetaText:SetText( "", true )
	end

end


--
function UI.Equipment_Items_SlotWnd:OnPlayerCreditsChanged()

	local data = self:GetRecordData()

	self:UpdatePrice( data )
	self:UpdateActionBtn( data )
	self:UpdateUpgradeArrow( data )
	self:UpdateSale( data )	

end


--
function UI.Equipment_Items_SlotWnd:OnAccountAurasChanged()

	local data = self:GetRecordData()

	self:UpdatePrice( data )
	self:UpdateSale( data )
    self:UpdateActionBtn( data )

end


--
function UI.Equipment_Items_SlotWnd:IsCurrent()

	local bCur = false

	local data = self:GetRecordData()
	if not data then
		return bCur
	end

	local item = data.item
	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
		item = item.subItemToShow
	end

	if item.itemType == UI.EquipmentWnd.itemTypes.INVENTORY or item.itemType == UI.EquipmentWnd.itemTypes.SPEC_MODULE then
		bCur = self:IsItemCurrent( item )
	end

	return bCur

end


--
function UI.Equipment_Items_SlotWnd:GetActionBtnRaw()

	return self.actionBtn

end


--
function UI.Equipment_Items_SlotWnd:GetOpenSubTreeBtn()

	local openSubTreeBtn = nil

	if self.openSubTreeBtn:IsChildOf( self ) then
		openSubTreeBtn = self.openSubTreeBtn
	end

	return openSubTreeBtn

end


--
function UI.Equipment_Items_SlotWnd:GetOpenSubTreeBtnRaw()

	return self.openSubTreeBtn

end


-- функция для обращения к прототипу слота, у которого эффекты не созданы, и реальная высота 0
function UI.Equipment_Items_SlotWnd:GetAssumedHeight()

	local height = 0

	local effect = _G.UI_SpawnEffect( self.effectInfo.main.effectName, self:GetUiHandle() )
	if effect then

		height = effect:GetObjSize( "self" ).y
		_G.UI_DestroyEffect( effect )

	else
		sys.log( "UI.Equipment_Items_SlotWnd:GetAssumedHeight()[ERROR]: cannot spawn effect %s", self.effectInfo.main.effectName )
	end

	return height

end


--
function UI.Equipment_Items_SlotWnd:OnVesselBudgetLevelUp()

	local data = self:GetRecordData()

	local item = data.item
	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
		item = item.subItemToShow
	end

	if item.itemType ~= UI.EquipmentWnd.itemTypes.SPEC_MODULE then
		return
	end

    self:UpdateMainAnimation( data )
    self:UpdatePrice( data )
    self:UpdateIcoTooltip( data )
    self:UpdateActionBtn( data )
    self:UpdateMouseOverState()

end


--
function UI.Equipment_Items_SlotWnd:OnVesselBudgetChanged()

	local data = self:GetRecordData()

	local item = data.item
	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
		item = item.subItemToShow
	end

	if item.itemType ~= UI.EquipmentWnd.itemTypes.SPEC_MODULE then
		return
	end

	self:UpdatePrice( data )
	self:UpdateActionBtn( data )

end


--
function UI.Equipment_Items_SlotWnd:OnVesselBudgetActivate()

	local data = self:GetRecordData()

	local item = data.item
	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
		item = item.subItemToShow
	end

	if item.itemType ~= UI.EquipmentWnd.itemTypes.SPEC_MODULE then
		return
	end

	self:UpdateActionBtn( data )

end


--
function UI.Equipment_Items_SlotWnd:ShowUpgradeItemWowEffect()

	self:MoveChildToLastPosition( self.icoWnd )	-- вау-эффект залазит на соседние элементы, надо чтобы он рисовался над ними, а не под
	self.icoWnd:ShowUpgradeItemWowEffect()

end


-- --------------------------------------
-- const
-- --------------------------------------

eis.effectInfo =
{
	main =
	{
		itemIcoObjName				= "icon",
		animIdle					= "idle",
		animShop					= "disable",
		openSubTreeBtnLocator		= "btn_2",
		actionBtnLocator			= "btn_1",
		nameLocator					= "product_name",
		priceLocator_actionBtn		= "price",
		priceLocator_noBtn			= "price8",
		effectName					= "equipment_itemsList_slot_main",
	},

	equipState =
	{
		animInventory	= "in_warehouse",
		animEquipped	= "set",
	},

	new =
	{
		anim_ru = "new_ru",
		anim_en = "new_en",
	}
}

eis.ITEM_SLOT = true

eis.sounds =
{
	itemMouseOver	= "sound/ui/btnMouseOver",
}

-- --------------------------------------
-- vars
-- --------------------------------------

eis.icoWnd					= nil
eis.priceMetaText			= nil
eis.equipStateMetaText		= nil
eis.openSubTreeBtn			= nil
eis.actionBtn				= nil
eis.pricePos_actionBtn		= Vec2( 0, 0 )
eis.pricePos_noBtn			= Vec2( 0, 0 )

-- --------------------------------------
-- work functions
-- --------------------------------------

--
function UI.Equipment_Items_SlotWnd:F_PostLoad()

	UI.ButtonsList3_Btn.F_PostLoad( self )

	if self:IsPrototype() then
		return
	end

	self.priceMetaText = UI.MetaText.GetNewInstance()
	self.priceMetaText:InitFromLayer( self, self.layers.PRICE_VAL ) 

	self.equipStateMetaText = UI.MetaText.GetNewInstance()
	self.equipStateMetaText:InitFromLayer( self, self.layers.EQUIP_STATE ) 

	local mainEffect = UI:GetEffectFromLayer( self, self.layers.MAIN_EFFECT )
	if mainEffect then

        self.pricePos_actionBtn	= mainEffect:GetObjPos( self.effectInfo.main.priceLocator_actionBtn )        
        self.pricePos_noBtn		= mainEffect:GetObjPos( self.effectInfo.main.priceLocator_noBtn )

	end

	self:CreateControls()
	self:Reset()

end


--
function UI.Equipment_Items_SlotWnd:F_Shutdown()

	if self.priceMetaText then
		self.priceMetaText:Clear()
	end

	if self.equipStateMetaText then
		self.equipStateMetaText:Clear()
	end

	UI.Wnd.F_Shutdown( self )

end


--
function UI.Equipment_Items_SlotWnd:CreateControls()

	self.icoWnd				= UI:CreateChildWnd( self, UI.ItemIcoWnd, "" )
	self.openSubTreeBtn		= UI:CreateChildWnd( self, UI.Equipment_Items_OpenSubTreeBtn, "" )
	self.actionBtn			= UI:CreateChildWnd( self, UI.Equipment_Items_ActionBtn, "" )

	self.icoWnd.ITEM_CONTROL = true
	self:AddControl( self.icoWnd, self.layers.MAIN_EFFECT, self.effectInfo.main.itemIcoObjName, UI.EffectAnimParams.POS + UI.EffectAnimParams.ALPHA )

end


--
function UI.Equipment_Items_SlotWnd:AddControl( wnd, effectLayer, locatorName, animParams )

	if not wnd then
		return
	end

    local effect = UI:GetEffectFromLayer( self, effectLayer )

	if wnd:IsChildOf( self ) and effect then
    	effect:UnlinkWnd( wnd:GetUiHandle(), "" )
	end

	if animParams == nil then
		animParams = UI.EffectAnimParams.POS
	end

	UI:AddChildAndLink( self, wnd, effect, locatorName, animParams )

end


--
function UI.Equipment_Items_SlotWnd:RemoveControl( wnd, effectLayer )

	if not wnd or not wnd:IsChildOf( self ) then
		return
	end

	wnd:UnlinkFromParent()

	local effect = UI:GetEffectFromLayer( self, effectLayer )
	if effect then
		effect:UnlinkWnd( wnd:GetUiHandle(), "" )
	end

end


--
function UI.Equipment_Items_SlotWnd:UpdateForData( data, bAnimated )

	self:Reset()

	local item = data.item
	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
		item = item.subItemToShow
	end
	if not item then
		return
	end

	self:UpdateMainAnimation( data )
	self:UpdateItemIco( data )
	self:UpdateMouseOverState()
	self:UpdateName( data )
	self:UpdateInactiveEffect( data )
	self:UpdateInBattle( data )
	self:UpdateSale( data )
	self:UpdateEquipState( data )
	self:UpdateOpenSubTreeBtn( data )
	self:UpdateActionBtn( data )
	self:UpdatePrice( data )
	self:UpdateIcoTooltip( data )
	self:UpdateUpgradeArrow( data )
	self:UpdateCurEffect( data )
	self:UpdateNewState( data )

end


--
function UI.Equipment_Items_SlotWnd:UpdateMainAnimation( data )

	local mainEffect = UI:GetEffectFromLayer( self, self.layers.MAIN_EFFECT )
	if not mainEffect then
		return
	end

	local item = data.item
	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
		item = item.subItemToShow
	end

	local anim = self.effectInfo.main.animIdle

	if item.itemType == UI.EquipmentWnd.itemTypes.SHOP then
		anim = self.effectInfo.main.animShop

	elseif item.itemType == UI.EquipmentWnd.itemTypes.SPEC_MODULE then

		if not self:IsSpecModuleUnlocked( item.defName ) then
			anim = self.effectInfo.main.animShop
		end

	end

	mainEffect:StartAnimation( anim )

	self:UpdateMetaTextPos()

end


--
function UI.Equipment_Items_SlotWnd:UpdateInactiveEffect( data )

	local isAvailable = self:IsItemAvailable( data.item )
	self:SetLayerVisible( not isAvailable, self.layers.INACTIVE_EFFECT )

end


--
function UI.Equipment_Items_SlotWnd:UpdateName( data )

	local item = data.item
	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
		item = item.subItemToShow
	end

	local color = UI:GetItemColor( item.defName )
	local alpha = 255

	local mainEffect = UI:GetEffectFromLayer( self, self.layers.MAIN_EFFECT )
	if mainEffect then
		alpha = mainEffect:GetObjAlpha( self.effectInfo.main.nameLocator )
		color = UI:SetAlpha( color, alpha )
	end

	local strColor = UI:Color2Str( color )

	self:SetText( string.format( "%s%s", strColor, UI:GetEntityLocalizedNameByDef( item.defName, false ) ), self.layers.NAME )

end


--
function UI.Equipment_Items_SlotWnd:UpdateItemIco( data )

	local item = data.item
	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
		item = item.subItemToShow
	end

	if item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
		sys.log( "UI.Equipment_Items_SlotWnd:UpdateItemIco()[ERROR]: wrong item type" )
		return
	end

	
	self.icoWnd:AnimateIcoIdle()

	local bEnchanted = false
	if item.itemType ~= UI.EquipmentWnd.itemTypes.SPEC_MODULE then
	
    	if item.itemType == UI.EquipmentWnd.itemTypes.INVENTORY and item.inventoryItems then
    		local idx, inventoryItem = next( item.inventoryItems )
    		if inventoryItem then
    			bEnchanted = UI:IsInventoryItemEnchanted( inventoryItem )
    		end
    	end

	end
	
	self.icoWnd:SetupForItem( item.defName, bEnchanted )
	
	local selShipItem = self:GetSelShipItem()
	self.icoWnd:SetupRank( item.defName, UI:IsItemFitForShipByTierAndRank( item.defName, selShipItem.defName ), nil )
	
end


--
function UI.Equipment_Items_SlotWnd:UpdateEquipState( data )

	local text = ""
	
	local item = data.item
	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
		item = item.subItemToShow
	end

	if item.itemType == UI.EquipmentWnd.itemTypes.INVENTORY and ( data.item.itemType == UI.EquipmentWnd.itemTypes.INVENTORY or UI:IsDefAutogen( item.defName ) ) then	-- экипированное состояние в списке верхнего уровня показывается только для автогена

    	if item.equipShipItem then

			if not self:IsItemCurrent( item ) then
				text = UI:MakeItemStorageString( false, nil, nil, nil, item.equipShipItem, true, self:GetColor( self.layers.EQUIP_STATE ) )
			end

    	else

			if UI:IsDefModule( item.defName ) then
				text = UI:MakeItemStorageString( false, nil, nil, nil, nil, true, self:GetColor( self.layers.EQUIP_STATE ) )
			else
				text = UI:MakeItemStorageString( true, item.countInInventory, -1, 0, nil, true, self:GetColor( self.layers.EQUIP_STATE ) )
			end

    	end					

	end

	self.equipStateMetaText:SetText( text, true )
	self:SetLayerVisible( text ~= "", self.layers.EQUIP_STATE )

end


--
function UI.Equipment_Items_SlotWnd:UpdatePrice( data )

	self:SetLayerVisible( false, self.layers.PRICE_VAL )
	self.priceMetaText:SetText( "", true )

	local item = data.item
	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
		item = item.subItemToShow
	end

	if not item then
		return
	end

	if item.itemType == UI.EquipmentWnd.itemTypes.SHOP then

		-- в списке могут быть не продаваемые предметы (те, которые можно скрафтить), для них цена не отображается

		if not UI:CantItemBeBought( item.shopItem ) then

    		self:SetLayerVisible( true, self.layers.PRICE_VAL )

    		local priceInfos = {}
			
			local priceType, price, basePrice, altPriceType, altPrice, altBasePrice = UI:GetShopSmartBuyPriceAlt( item.shopItem )
			
			local priceInfo =
			{
				priceType	= priceType,
				val			= price,
				bIsBuyPrice	= true,
				basePrice	= basePrice,
			}
			table.insert( priceInfos, priceInfo )
			
			
			if altPriceType then
			
				local altPriceInfo =
				{
					priceType	= altPriceType,
					val			= altPrice,
					bIsBuyPrice	= true,
					basePrice	= altBasePrice,
				}
				table.insert( priceInfos, altPriceInfo )

			end

    		local strPrice = UI:PricesInfos2Str( priceInfos, self:GetColor( self.layers.PRICE_VAL ), true, nil, true, nil )

    		self.priceMetaText:SetText( strPrice, true )

		end

	elseif item.itemType == UI.EquipmentWnd.itemTypes.INVENTORY then

		if UI:IsItemUpgradable( item.defName ) and UI:CanItemUpgradeFurther( item.defName ) then

			local btnMode = self:DetectActionBtnModeForUpgrade( item )

			if btnMode == UI.Equipment_Items_ActionBtn.modes.UPGRADE then

    			self:SetLayerVisible( true, self.layers.PRICE_VAL )

				local iid = item.inventoryItems[ 1 ].iid

				local price, basePrice = UI:GetItemUpgradeCreditsPrice( item.defName )

				local priceInfo = {}
				priceInfo.priceType		= _G.GameStore.CreditsType.CT_CREDITS
				priceInfo.val			= price
				priceInfo.bIsBuyPrice	= true
				priceInfo.basePrice		= basePrice
				
				local strPrice = UI:PriceInfo2Str( priceInfo, self:GetColor( self.layers.PRICE_VAL ), true, nil, true, nil )
				self.priceMetaText:SetText( strPrice, true )

			end

		-- аммуниция не может апгрейдиться, поэтому конфликта между ценой апгрейда и ценой пополнения быть не может
		elseif UI:IsDefAmmo( item.defName ) then

			if not UI:CantItemBeBoughtByDef( item.defName ) then

    			self:SetLayerVisible( true, self.layers.PRICE_VAL )

    			local price, bGold = UI:GetShopBuyPriceByDef( item.defName, false, nil, false )	-- #0036543, комм.(0132906) - утверждается, что на расходники должна быть одна цена

    			local priceInfo = {}

    			priceInfo.priceType		= bGold and _G.GameStore.CreditsType.CT_GOLD or _G.GameStore.CreditsType.CT_CREDITS
    			priceInfo.val			= price
    			priceInfo.bIsBuyPrice	= true
    			priceInfo.basePrice		= price

    			local strPrice = UI:PriceInfo2Str( priceInfo, self:GetColor( self.layers.PRICE_VAL ), true, nil, true, nil )
    			self.priceMetaText:SetText( strPrice, true )

			end

		end 

	elseif item.itemType == UI.EquipmentWnd.itemTypes.SPEC_MODULE then

		if not self:IsSpecModuleUnlocked( item.defName ) then

			local shipItem = self:GetSelShipItem()

			local specModuleLevel = UI:GetSpecModuleLevel( item.defName, shipItem.defName )
			if specModuleLevel ~= -1 then

				self:SetLayerVisible( true, self.layers.PRICE_VAL )

--[[
				#0061623,комм.(0252008):
                "Например если прописаны стоимости 20, 50, 80 то отображаемое необxодимое количество будет 20, 30, 30.
                Если в корабле бюджет 12, то отображаемое текущее количество будет 12/20, 0/30, 0/30.
                а если 55, то 20/20, 30/30, 5/30."
]]

				-- сколько надо

				local prevLevelCost = 0
				if specModuleLevel > 1 then
					prevLevelCost = UI:GetShipSpecModuleLevelCost( shipItem.defName, specModuleLevel - 1 )
				end

				local levelCost	= UI:GetShipSpecModuleLevelCost( shipItem.defName, specModuleLevel )
				local deltaCost	= levelCost - prevLevelCost

				-- сколько есть

				local funds			= UI:GetShipSpecModuleParts( shipItem )
				local deltaFunds	= 0

				if funds > prevLevelCost then

					deltaFunds = funds - prevLevelCost

					if specModuleLevel < UI:GetShipMaxSpecModuleLevel( shipItem.defName ) then
						if deltaFunds > deltaCost then
							deltaFunds = deltaCost
						end
					end

				end

				-- всё вместе

				local priceInfo = {}

    			priceInfo.priceType		= UI.exPriceTypes.SPEC_MODULE_PARTS
    			priceInfo.val			= levelCost
    			priceInfo.bIsBuyPrice	= true
    			priceInfo.basePrice		= levelCost
				priceInfo.shipDefName	= shipItem.defName
				priceInfo.valAsString	= string.format( "%d/%d", deltaFunds, deltaCost )

    			local strPrice = UI:PriceInfo2Str( priceInfo, self:GetColor( self.layers.PRICE_VAL ), false, false, true, nil )
    			self.priceMetaText:SetText( strPrice, true )

			else
				sys.log( "UI.Equipment_Items_SlotWnd:UpdatePrice()[ERROR]: invalid spec module level" )
			end		

		end

	else
		sys.log( "UI.Equipment_Items_SlotWnd:UpdatePrice()[ERROR]: unhandled item type: %s", tostgring( item.itemType ) )
	end

	self:RecalcPricePos()

end


--
function UI.Equipment_Items_SlotWnd:RecalcPricePos()

	if not self:IsLayerVisible( self.layers.PRICE_VAL ) then
		return
	end

	local pos = UI:ZeroVec2()

	if self.actionBtn:IsChildOf( self ) then
		pos = self.pricePos_actionBtn
	else
		pos = self.pricePos_noBtn
	end

	self:SetLayerLeft( pos.x, self.layers.PRICE_VAL )
	self:SetLayerTop( pos.y, self.layers.PRICE_VAL )

	self.priceMetaText:UpdateScreenOrgFromLayer( self, self.layers.PRICE_VAL )

end                                                                           


--
function UI.Equipment_Items_SlotWnd:UpdateInBattle( data )

	self.icoWnd:HideInBattleEffect()
	self.icoWnd:HideInBattleText()
	self.icoWnd:HideOnShipQuestEffect()

	if self:IsItemInBattle( data.item ) then
		self.icoWnd:ShowInBattleEffect()
		self.icoWnd:ShowInBattleText()

	elseif self:IsItemOnShipQuest( data.item ) then
		self.icoWnd:ShowOnShipQuestEffect()
	end

end


--
function UI.Equipment_Items_SlotWnd:UpdateSale( data )

	local item = data.item
	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
		item = item.subItemToShow
	end

	local bSale = false

	if item.itemType == UI.EquipmentWnd.itemTypes.SHOP then

		if not UI:CantItemBeBought( item.shopItem ) then
			bSale = UI:IsItemSale( item.shopItem )
		end

	elseif item.itemType == UI.EquipmentWnd.itemTypes.INVENTORY then

		if UI:IsItemUpgradable( item.defName ) and UI:CanItemUpgradeFurther( item.defName ) then

			local actionBtnMode = self:DetectActionBtnModeForUpgrade( item )
			if actionBtnMode == UI.Equipment_Items_ActionBtn.modes.UPGRADE then
			
				local price, basePrice = UI:GetItemUpgradeCreditsPrice( item.defName )
				bSale = price < basePrice
				
			end

		end

	end

	self:SetLayerVisible( bSale, self.layers.SALE_EFFECT )

end


--
function UI.Equipment_Items_SlotWnd:UpdateIcoTooltip( data )

	local item = data.item
	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
		item = item.subItemToShow
	end

	if item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
		sys.log( "UI.Equipment_Items_SlotWnd:UpdateIcoTooltip()[ERROR]: wrong item type" )
		return
	end

	local tooltipData = nil

	if item.itemType == UI.EquipmentWnd.itemTypes.SPEC_MODULE then

    	local selShipItem = self:GetSelShipItem()

    	tooltipData							= {}

    	tooltipData.tooltipType				= UI.tooltipTypes.MODULE
    	tooltipData.defName 				= item.defName
    	tooltipData.dstShipData				= UI.ModuleTooltipWnd.ShipData:CreateForVid( selShipItem.vid, ai.SpaceShipModuleSlot.SPECIAL )
		tooltipData.bCanBeEquippedByClick	= self:IsSpecModuleUnlocked( item.defName ) and UI:GetShipSpecModule( selShipItem ) ~= item.defName
		tooltipData.bWithTalents			= true

	else

		tooltipData = {}

    	tooltipData.tooltipType = UI.tooltipTypes.MODULE
    	tooltipData.defName = item.defName

    	local selShipSlot = self:GetSelShipSlot()
    	local selShipItem = self:GetSelShipItem()

    	if selShipSlot and selShipItem then
    		tooltipData.dstShipData = UI.ModuleTooltipWnd.ShipData:CreateForVid( selShipItem.vid, selShipSlot:GetSlotId() )
    	end

    	if item.itemType == UI.EquipmentWnd.itemTypes.INVENTORY and not UI:IsDefAmmo( item.defName ) and #item.inventoryItems == 1 then
    		tooltipData.iid = item.inventoryItems[ 1 ].iid
    	end			

    	local bCanBuy = item.itemType == UI.EquipmentWnd.itemTypes.SHOP or ( item.itemType == UI.EquipmentWnd.itemTypes.INVENTORY and item.count < item.maxCount )

    	tooltipData.bCanBeEquippedByClick	= item.itemType == UI.EquipmentWnd.itemTypes.INVENTORY and selShipItem and ( not item.equipShipItem or item.equipShipItem ~= selShipItem )    	
		tooltipData.bWithTalents			= true

	end

	self.icoWnd:SetTooltipData( tooltipData )

end


--
function UI.Equipment_Items_SlotWnd:UpdateOpenSubTreeBtn( data )

	self:AddControl( self.openSubTreeBtn, self.layers.MAIN_EFFECT, self.effectInfo.main.openSubTreeBtnLocator )
	self.openSubTreeBtn:Reset()

	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then		

		local subItems = self:GetSubtreeItems( data.item )

		local nonCurCount		= 0
		local bHasNonShownItems	= false

		for subItemIdx, subItem in pairs( subItems ) do

			if subItem.itemType == UI.EquipmentWnd.itemTypes.INVENTORY and not self:IsItemCurrent( subItem ) then
				nonCurCount = nonCurCount + subItem.count
			end

			if subItem ~= data.item.subItemToShow then
				bHasNonShownItems = true
			end

		end

		local bVisible = bHasNonShownItems	-- #0056479, комм.(0226007) - "даже если у игрока нет ни одного модуля, но купить можно модули несколькиx рангов надо показывать стрелочку переxода на уровень ниже"
		if bVisible then

			self.openSubTreeBtn:SetGray( false )

    		-- тултип

    		local tooltipData = {}
    		tooltipData.tooltipType = UI.tooltipTypes.TEXT_LARGE
    		tooltipData.caption		= UI:GetStringByName( "equipment_openInventoryItemsBtn_tooltipCaption" )

    		local strCount = string.format( "%s %s", UI:Num2StrSeparatedBy3( nonCurCount ), UI:GetStringByName( "equipment_itemsUnits" ) )
    		local text = UI:GetStringByName( "equipment_openInventoryItemsBtn_tooltipText" )
    		text = string.gsub( text, "%$numItems%$", strCount )

    		tooltipData.text = text		

    		self.openSubTreeBtn:SetTooltipData( tooltipData )

		else
			self.openSubTreeBtn:SetGray( true )
		end

	else
		self.openSubTreeBtn:SetGray( true )
	end

end


--
function UI.Equipment_Items_SlotWnd:UpdateActionBtn( data )

	self:HideActionBtn()

	local item = data.item
	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
		item = item.subItemToShow
	end	

	if not item then
		return
	end

	if item.itemType == UI.EquipmentWnd.itemTypes.SHOP then

		self:ShowActionBtn()

		if UI:CantItemBeBought( item.shopItem ) then
			
			local blueprintDefName = UI:GetBlueprintForItemCraft( item.defName, true )
			if blueprintDefName ~= "" then
				self.actionBtn:Setup( UI.Equipment_Items_ActionBtn.modes.CRAFT, item.defName, nil, false, self:GetSelShipItem().vid, self:GetSelShipSlot() )
			else
				self.actionBtn:Setup( UI.Equipment_Items_ActionBtn.modes.CRAFT_GAIN_INFO, item.defName, nil, false, self:GetSelShipItem().vid, self:GetSelShipSlot() )
			end

			local bEnable = UI:GetPlayerAccountRank() >= UI.rankLocks.itemCraft
			self.actionBtn:SetGray( not bEnable )

		else

    		local priceType = UI:GetShopSmartBuyPriceOne( item.shopItem )
    		self.actionBtn:Setup( UI.Equipment_Items_ActionBtn.modes.BUY, item.defName, nil, priceType == _G.GameStore.CreditsType.CT_GOLD, self:GetSelShipItem().vid, self:GetSelShipSlot() )

    		self.actionBtn:SetGray( false )		-- и золото, и кредиты можно пополнять в окне покупки		

		end

	elseif item.itemType == UI.EquipmentWnd.itemTypes.INVENTORY then

		if UI:CanItemUpgradeFurther( item.defName ) then

			local mode = self:DetectActionBtnModeForUpgrade( item )

			local inventoryItem = item.inventoryItems and item.inventoryItems[ 1 ]
			local iid = inventoryItem and inventoryItem.iid or UI.INVALID_U64_ID

			self:ShowActionBtn()
			self.actionBtn:Setup( mode, item.defName, iid, false, self:GetSelShipItem().vid, self:GetSelShipSlot() )
			
			local bEnable = true

			if bEnable then
				if not self:IsItemAvailable( item ) or data.bUsedInTutorialEquipItemStage then
					bEnable = false
				end
			end

			if bEnable then
				if mode == UI.Equipment_Items_ActionBtn.modes.CRAFT or mode == UI.Equipment_Items_ActionBtn.modes.CRAFT_UPGRADE then
					if UI:GetPlayerAccountRank() < UI.rankLocks.itemCraft then
						bEnable = false
					end
				end
			end

			self.actionBtn:SetGray( not bEnable )

		end

	elseif item.itemType == UI.EquipmentWnd.itemTypes.SPEC_MODULE then

		if not self:IsSpecModuleUnlocked( item.defName ) then

			local shipItem = self:GetSelShipItem()

			local specModuleLevel = UI:GetSpecModuleLevel( item.defName, shipItem.defName )
			if specModuleLevel ~= -1 then

				local curShipLevel	= UI:GetShipUnlockedSpecModuleLevel( shipItem )
				local nextShipLevel	= curShipLevel == -1 and 1 or ( curShipLevel + 1 )

				if specModuleLevel == nextShipLevel then

					if not UI:IsShipCollectingSpecModuleParts( shipItem.vid ) then

						self:ShowActionBtn()
    					self.actionBtn:Setup( UI.Equipment_Items_ActionBtn.modes.ACTIVATE_SHIP, item.defName, nil, false, self:GetSelShipItem().vid, self:GetSelShipSlot() )
    					self.actionBtn:SetGray( false )

					else

    					local bEnoughParts = UI:GetShipSpecModuleParts( shipItem ) >= UI:GetShipSpecModuleLevelCost( shipItem.defName, specModuleLevel )

						local bBundle = false

						if not bEnoughParts then						
    						local bundleDefName = UI:GetBundleWithSpecModuleParts()
    						if bundleDefName ~= "" and not UI:CantItemBeBoughtByDef( bundleDefName, false ) then
								bBundle = true
    						end
						end

						if bBundle then

    						self:ShowActionBtn()
        					self.actionBtn:Setup( UI.Equipment_Items_ActionBtn.modes.BUY_BUNDLE, item.defName, nil, false, self:GetSelShipItem().vid, self:GetSelShipSlot() )
        					self.actionBtn:SetGray( false )

						else					

    						self:ShowActionBtn()
        					self.actionBtn:Setup( UI.Equipment_Items_ActionBtn.modes.UNLOCK_SPEC_MODULE, item.defName, nil, false, self:GetSelShipItem().vid, self:GetSelShipSlot() )
        					self.actionBtn:SetGray( not bEnoughParts )

						end

					end

				else

					self:ShowActionBtn()
    				self.actionBtn:Setup( UI.Equipment_Items_ActionBtn.modes.UNLOCK_SPEC_MODULE, item.defName, nil, false, self:GetSelShipItem().vid, self:GetSelShipSlot() )
    				self.actionBtn:SetGray( true )

				end

			else
				sys.log( "UI.Equipment_Items_SlotWnd:UpdateActionBtn()[ERROR]: invalid spec module level" )
			end
			
		end

	else
		sys.log( "UI.Equipment_Items_SlotWnd:UpdateActionBtn()[ERROR]: unhandled item type: %s", tostring( item.itemType ) )
	end
		
end


--
function UI.Equipment_Items_SlotWnd:DetectActionBtnModeForUpgrade( item )

	local mode = -1
	
	if UI:IsDefAutogen( item.defName ) then
		mode = UI.Equipment_Items_ActionBtn.modes.UPGRADE_AUTOGEN
		
	elseif UI:CanUpgradeItemThroughCraftOnly( item.defName ) then
    	mode = UI.Equipment_Items_ActionBtn.modes.CRAFT_UPGRADE
		
	else
    	mode = UI.Equipment_Items_ActionBtn.modes.UPGRADE
	end

	return mode

end


--
function UI.Equipment_Items_SlotWnd:ShowActionBtn()

	if not self.actionBtn:IsChildOf( self ) then

    	local mainEffect = UI:GetEffectFromLayer( self, self.layers.MAIN_EFFECT )
		UI:AddChildAndLink( self, self.actionBtn, mainEffect, self.effectInfo.main.actionBtnLocator, UI.EffectAnimParams.POS )

		self:RecalcPricePos()

	end

end


--
function UI.Equipment_Items_SlotWnd:HideActionBtn()

	if self.actionBtn:IsChildOf( self ) then

		self.actionBtn:Reset()
		self.actionBtn:UnlinkFromParent()

		self:RecalcPricePos()

	end

end


--
function UI.Equipment_Items_SlotWnd:UpdateUpgradeArrow( data )

	local bCanUpgradeNow = false

	local item = data.item
	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
		item = item.subItemToShow
	end	

	if item and item.itemType == UI.EquipmentWnd.itemTypes.INVENTORY then

		local inventoryItem = item.inventoryItems and item.inventoryItems[ 1 ]
		local iid = inventoryItem and inventoryItem.iid or UI.INVALID_U64_ID

		if iid ~= UI.INVALID_U64_ID then
			bCanUpgradeNow = UI:CanItemUpgradeNow( iid )
		end

	end

	if bCanUpgradeNow then
		self.icoWnd:ShowUpgradeArrow()
	else
		self.icoWnd:HideUpgradeArrow()
	end
	
end


--
function UI.Equipment_Items_SlotWnd:UpdateCurEffect( data )

	local bCur = self:IsCurrent()
	self:SetLayerVisible( bCur, self.layers.CUR_EFFECT )

end


--
function UI.Equipment_Items_SlotWnd:UpdateNewState( data )

	local bNew = false

	local item = data.item
	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
		item = item.subItemToShow
	end

	if item and item.itemType == UI.EquipmentWnd.itemTypes.SHOP then
		bNew = UI:IsItemNew( item.shopItem )
	end

	if bNew then

		self:SetLayerVisible( true, self.layers.NEW_EFFECT )

    	local newEffect = UI:GetEffectFromLayer( self, self.layers.NEW_EFFECT )
    	if newEffect then

    		local bRussian = UI:GetLanguage() == "RUSSIAN"
    		local anim = bRussian and self.effectInfo.new.anim_ru or self.effectInfo.new.anim_en

    		newEffect:StartAnimation( anim )		

    	end

	else
		self:SetLayerVisible( false, self.layers.NEW_EFFECT )
	end

end


--
function UI.Equipment_Items_SlotWnd:UpdateMouseOverState()

	local bMouseOver = false

	local data = self:GetRecordData()
	if data then

    	local item = data.item
    	if data.item.itemType == UI.EquipmentWnd.itemTypes.SUB_TYPE then
    		item = item.subItemToShow
    	end	

    	if	item.itemType ~= UI.EquipmentWnd.itemTypes.SHOP
			and not( item.itemType == UI.EquipmentWnd.itemTypes.SPEC_MODULE and not self:IsSpecModuleUnlocked( item.defName ) ) then

    		local wndUnderMouse = UI:FindWindowUnderMouse( UI.Root, UI:GetMouseX(), UI:GetMouseY(), true )

			-- #0066031,комм.(0271291) - наведение на кнопку открытия второго уровня не должно приводить к наведению на слот
    		bMouseOver = wndUnderMouse and wndUnderMouse == self or ( wndUnderMouse:IsChildOf( self ) and wndUnderMouse ~= self.openSubTreeBtn ) 

		end

	end

	self:SetMouseOver( bMouseOver )

end


--
function UI.Equipment_Items_SlotWnd:SetMouseOver( bMouseOver )

	local bWasMouseOver = self:IsLayerVisible( self.layers.MOUSE_OVER_EFFECT )

	self:SetLayerVisible( bMouseOver, self.layers.MOUSE_OVER_EFFECT )

	if bMouseOver and not bWasMouseOver and self:IsOnScreen() then
		UI:PlayGlobalSound( self.sounds.itemMouseOver )
	end

end


--
function UI.Equipment_Items_SlotWnd:F_OnMouseIn( mouseX, mouseY, wndThatReceivedInput )

	if self:OnMouseIn( mouseX, mouseY, wndThatReceivedInput ) then
		return true
	end

	self:UpdateMouseOverState()
	return true

end


--
function UI.Equipment_Items_SlotWnd:F_OnMouseOut( mouseX, mouseY, wndThatReceivedInput )

	if self:OnMouseOut( mouseX, mouseY, wndThatReceivedInput ) then
		return true
	end

	self:UpdateMouseOverState()
	return true	

end


--
function UI.Equipment_Items_SlotWnd:F_OnAfterShowOnScreen()

	self:OnAfterShowOnScreen()

	self:UpdateMetaTextPos()

end


--
function UI.Equipment_Items_SlotWnd:F_OnScreenPosChanged( oldScreenX, oldScreenY )

	self:OnScreenPosChanged( oldScreenX, oldScreenY )

	-- может вызываеться при инициализации окна, когда еще слои не созданы
	if self:GetNumLayers() == 0 then
		return
	end

	if self:IsOnScreen() then
		self:UpdateMetaTextPos()
	end

end


--
function UI.Equipment_Items_SlotWnd:UpdateMetaTextPos()

	self.priceMetaText:UpdateScreenOrgFromLayer( self, self.layers.PRICE_VAL )
	self.equipStateMetaText:UpdateScreenOrgFromLayer( self, self.layers.EQUIP_STATE )

end


--
function UI.Equipment_Items_SlotWnd:F_DrawLayer( x0, y0, width, height, clipX0, clipY0, clipWidth, clipHeight, layerIdx )

	if layerIdx == self.layers.PRICE_VAL then
		self.priceMetaText:Draw( clipX0, clipY0, clipWidth, clipHeight )

	elseif layerIdx == self.layers.EQUIP_STATE then
		self.equipStateMetaText:Draw( clipX0, clipY0, clipWidth, clipHeight )
	end

end


--
function UI.Equipment_Items_SlotWnd:IsItemCurrent( item )

	return UI.EquipmentWnd:IsItemCurrent( item )

end


--
function UI.Equipment_Items_SlotWnd:IsSpecModuleUnlocked( defName )

	return UI.EquipmentWnd:IsSpecModuleUnlocked( defName )

end


--
function UI.Equipment_Items_SlotWnd:IsItemAvailable( item )

	return UI.EquipmentWnd:IsItemAvailable( item )

end


--
function UI.Equipment_Items_SlotWnd:GetSelShipItem()
	
	return UI.EquipmentWnd:GetSelShipItem()

end


--
function UI.Equipment_Items_SlotWnd:IsItemInBattle( item )

	return UI.EquipmentWnd:IsItemInBattle( item )

end


--
function UI.Equipment_Items_SlotWnd:IsItemOnShipQuest( item )

	return UI.EquipmentWnd:IsItemOnShipQuest( item )

end


--
function UI.Equipment_Items_SlotWnd:GetSelShipSlot()

	return UI.EquipmentWnd:GetSelShipSlot()

end


--
function UI.Equipment_Items_SlotWnd:GetSubtreeItems( rootItem, items )

	return UI.EquipmentWnd:GetSubtreeItems( rootItem, items )

end

-- -----------------------------------------------------------------------
-- UI.Equipment_Items_SlotWnd_1080
-- -----------------------------------------------------------------------

UI.Equipment_Items_SlotWnd_1080 = {}

-- ------------------------------
-- window definition
-- ------------------------------

UI.Equipment_Items_SlotWnd_1080.def =
{
	className	= "Wnd",
	prototype	= "Equipment_Items_SlotWnd",
	
	props =
	{
		name		= "Equipment_Items_SlotWnd_1080",
		isPrototype	= true,
	},
	
	layers =
	{
		-- MAIN_EFFECT
		{
			id			= UI.Equipment_Items_SlotWnd.layers.MAIN_EFFECT,
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,
			main		= true,

			effects =
			{{
				defName 			= "equipment_itemsList_slot_main_1080",
				defaultAnimation	= "idle",

				links =
				{
					{
						objName		= "self",
						animParams	= UI.EffectAnimParams.SIZE,
					},

					{
						objName		= "product_name",
						layer		= "UI.Equipment_Items_SlotWnd.layers.NAME",
						animParams	= UI.EffectAnimParams.ALL,
					},

					{
						objName		= "over",
						layer		= "UI.Equipment_Items_SlotWnd.layers.MOUSE_OVER_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "blackout",
						layer		= "UI.Equipment_Items_SlotWnd.layers.INACTIVE_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					-- не линкуется по позиции
					{
						objName		= "price",
						layer		= "UI.Equipment_Items_SlotWnd.layers.PRICE_VAL",
						animParams	= UI.EffectAnimParams.ALL - UI.EffectAnimParams.POS,
					},

					{
						objName		= "sale",
						layer		= "UI.Equipment_Items_SlotWnd.layers.SALE_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "progr11",
						layer		= "UI.Equipment_Items_SlotWnd.layers.EQUIP_STATE",
						animParams	= UI.EffectAnimParams.ALL,
					},

					{
						objName		= "select",
						layer		= "UI.Equipment_Items_SlotWnd.layers.CUR_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "labe",
						layer		= "UI.Equipment_Items_SlotWnd.layers.NEW_EFFECT",
						animParams	= UI.EffectAnimParams.POS,
					},
				}
			}}
		},

		-- CUR_EFFECT
		{
			id			= UI.Equipment_Items_SlotWnd.layers.CUR_EFFECT,
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "equipment_itemsList_slot_cur_1080",
				defaultAnimation	= "idle",
			}}
		},

		-- NEW_EFFECT
		{
			id			= UI.Equipment_Items_SlotWnd.layers.NEW_EFFECT,
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "ships_shipSlot_action_1080",
			}}
		},

		-- SALE_EFFECT
		{
			id			= UI.Equipment_Items_SlotWnd.layers.SALE_EFFECT,
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,

			effects =
			{{
				defName 			= "equipment_itemsList_slot_sale_1080",
				defaultAnimation	= "idle",
			}}
		},

		-- INACTIVE_EFFECT
		{
			id			= UI.Equipment_Items_SlotWnd.layers.INACTIVE_EFFECT,
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE + UI.WLS_TEXT_PICKER_TRANSPARENT,

			effects =
			{{
				defName 			= "equipment_itemsList_slot_inactive_1080",
				defaultAnimation	= "idle",
			}}
		},

		-- MOUSE_OVER_EFFECT
		{
			id			= UI.Equipment_Items_SlotWnd.layers.MOUSE_OVER_EFFECT,
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE + UI.WLS_TEXT_PICKER_TRANSPARENT,

			effects =
			{{
				defName 			= "equipment_itemsList_slot_mouseOver_1080",
				defaultAnimation	= "idle",
			}}
		},
	}
}

-- ------------------------------
-- const
-- ------------------------------

UI.Equipment_Items_SlotWnd_1080.effectInfo =
{
	main =
	{
		effectName = "equipment_itemsList_slot_main_1080",
	},
}

-- ------------------------------
-- work functions
-- ------------------------------

--
function UI.Equipment_Items_SlotWnd_1080:CreateControls()

	self.icoWnd				= UI:CreateChildWnd( self, UI.ItemIcoWnd_1080, "" )
	self.openSubTreeBtn		= UI:CreateChildWnd( self, UI.Equipment_Items_OpenSubTreeBtn_1080, "" )
	self.actionBtn			= UI:CreateChildWnd( self, UI.Equipment_Items_ActionBtn_1080, "" )

	self.icoWnd.ITEM_CONTROL = true
	self:AddControl( self.icoWnd, self.layers.MAIN_EFFECT, self.effectInfo.main.itemIcoObjName, UI.EffectAnimParams.POS + UI.EffectAnimParams.ALPHA )

end


-- -----------------------------------------------------------------------
-- UI.Equipment_Items_OpenSubTreeBtn
-- -----------------------------------------------------------------------

UI.Equipment_Items_OpenSubTreeBtn = {}

-- ------------------------------
-- window definition
-- ------------------------------

UI.Equipment_Items_OpenSubTreeBtn.def =
{
	className	= "ButtonWnd",
	prototype	= "EffectButtonWnd",

	props =
	{
		name 		= "Equipment_Items_OpenSubTreeBtn",
		selectSound	= UI.MsgBox.sounds.btnMouseOver,
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
				defName 			= "equipment_itemsList_slot_openSubTreeBtn",
				defaultAnimation	= "idle",

				links =
				{
					{
						objName		= "self",	
						animParams	= UI.EffectAnimParams.SIZE,
					},
				}

			}}
		}
	}
}

-- ------------------------------
-- interface functions
-- ------------------------------

--
function UI.Equipment_Items_OpenSubTreeBtn:SetTooltipData( tooltipData )

	self.tooltipData = tooltipData

end


--
function UI.Equipment_Items_OpenSubTreeBtn:GetTooltipData()

	return self.tooltipData

end


--
function UI.Equipment_Items_OpenSubTreeBtn:Reset()

	self.tooltipData = nil
	self:SetGray( false )

end


-- ------------------------------
-- const
-- ------------------------------

UI.Equipment_Items_OpenSubTreeBtn.effectInfo =
{
	main =
	{
		animationIdle 			= "idle",
		animationSelect			= "over",
		animationPressed		= "press",
		animationDisabled		= "disable",
		animationIdle_focus 	= "idle",
		animationSelect_focus	= "over",
		animationPressed_focus	= "press",
	},
}

-- ------------------------------
-- vars
-- ------------------------------

UI.Equipment_Items_OpenSubTreeBtn.tooltipData = nil

-- -----------------------------------------------------------------------
-- UI.Equipment_Items_OpenSubTreeBtn_1080
-- -----------------------------------------------------------------------

UI.Equipment_Items_OpenSubTreeBtn_1080 =
{
	def =
	{
		className	= "ButtonWnd",
		prototype	= "Equipment_Items_OpenSubTreeBtn",
		
		props =
		{
			name		= "Equipment_Items_OpenSubTreeBtn_1080",
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
					defName 			= "equipment_itemsList_slot_openSubTreeBtn_1080",
					defaultAnimation	= "idle",

					links =
					{
						{
							objName		= "self",
							animParams	= UI.EffectAnimParams.SIZE,
						},
					}

				}}
			}
		}
	}
}

-- -----------------------------------------------------------------------
-- UI.Equipment_Items_ActionBtn
-- -----------------------------------------------------------------------

UI.Equipment_Items_ActionBtn = {}

-- ---------------------------------------
-- window fefinition
-- ---------------------------------------

local l_numBaseBtnLayers = UI:GetTableLength( UI.EffectButtonWnd.layers )

UI.Equipment_Items_ActionBtn.def =
{
	className	= "ButtonWnd",
	prototype	= "EffectCheckBoxWnd",

	props =
	{
		name 		= "Equipment_Items_ActionBtn",
		selectSound	= UI.MsgBox.sounds.btnMouseOver,
		isPrototype	= true,
	},

	layers =
	{
		numLayers = l_numBaseBtnLayers + 1,

		-- MAIN_EFFECT
		{
			layerType	= UI.LAYER_EFFECT,
			layerStyle	= UI.WLS_RESIZABLE,
			main		= true,

			effects =
			{{
				defName 			= "equipment_itemsList_slot_actionBtn",
				defaultAnimation	= "idle",

				links =
				{
					{
						objName		= "self",	
						animParams	= UI.EffectAnimParams.SIZE,
					},

					{
						objName		= "text_1",
						layer		= "UI.Equipment_Items_ActionBtn.layers.TEXT",
						animParams	= UI.EffectAnimParams.POS + UI.EffectAnimParams.SIZE + UI.EffectAnimParams.ALIGNMENT + UI.EffectAnimParams.FONT + UI.EffectAnimParams.BLEND + UI.EffectAnimParams.COLOR + UI.EffectAnimParams.ALPHA,
					},
				}
			}}
		},

    	-- TEXT
    	{
    		id				= l_numBaseBtnLayers,
    		layerType		= UI.LAYER_TEXT,
       		formatFlags		= FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
       		formatInfoSz	= { 1, 1 },
       		font			= { fontName = "Small" },
    	},
	}	
}

-- ---------------------------------------
-- interface functions
-- ---------------------------------------

--
function UI.Equipment_Items_ActionBtn:Setup( mode, defName, iid, bGold, vid, shipSlotId )

	self:Reset()

	self.mode		= mode
	self.defName	= defName
	self.iid		= iid or UI.INVALID_U64_ID
	self.bGold		= bGold
	self.vid		= vid
	self.shipSlotId	= shipSlotId

	self:FullUpdate()

end


--
function UI.Equipment_Items_ActionBtn:GetMode()

	return self.mode

end


--
function UI.Equipment_Items_ActionBtn:IsGold()

	return self.bGold

end


--
function UI.Equipment_Items_ActionBtn:Reset()

	self:SetGray( false )

	self.mode		= -1
	self.defName	= ""
	self.iid		= UI.INVALID_U64_ID
	self.bGold		= false
	self.vid		= UI.INVALID_U64_ID
	self.shipSlotId	= -1

	self:SetLayerVisible( true, self.layers.TEXT )	

	self.tooltipData = nil

	self:Check( false )

end


--
function UI.Equipment_Items_ActionBtn:GetTooltipData()

	return self.tooltipData

end


-- ---------------------------------------
-- const
-- ---------------------------------------

UI.Equipment_Items_ActionBtn.layers =
{
    MAIN_EFFECT		= 0,
    DEBUG			= 1,
    TEXT			= 2,
}

UI.Equipment_Items_ActionBtn.modes =
{
	BUY					= 1,
	UPGRADE				= 2,
	CRAFT				= 3,
	CRAFT_UPGRADE		= 4,
	CRAFT_GAIN_INFO		= 5,
	ACTIVATE_SHIP		= 6,
	UNLOCK_SPEC_MODULE	= 7,
	BUY_BUNDLE			= 8,
	UPGRADE_AUTOGEN		= 9,
}

UI.Equipment_Items_ActionBtn.effectInfo =
{
	main_unchecked =
	{
		animationIdle 			= "idle",
		animationSelect			= "over",
		animationPressed		= "press",
		animationDisabled		= "disable",
	},

	main_checked =
	{
		animationIdle 			= "idle_g",
		animationSelect			= "over_g",
		animationPressed		= "press_g",
		animationDisabled		= "disable_g",
	},
}

-- ---------------------------------------
-- vars
-- ---------------------------------------

UI.Equipment_Items_ActionBtn.mode			= -1
UI.Equipment_Items_ActionBtn.defName		= ""
UI.Equipment_Items_ActionBtn.bGold			= false
UI.Equipment_Items_ActionBtn.tooltipData	= nil
UI.Equipment_Items_ActionBtn.vid			= UI.INVALID_U64_ID
UI.Equipment_Items_ActionBtn.shipSlotId		= -1

-- ---------------------------------------
-- work functions
-- ---------------------------------------

--
function UI.Equipment_Items_ActionBtn:FullUpdate()

	self:UpdateText()
	self:UpdateTooltip()
	self:UpdateGoldState()

end


--
function UI.Equipment_Items_ActionBtn:UpdateText()

	local text = ""

	if self.mode == self.modes.BUY then
		text = UI:GetStringByName( "equipment_buyBtn" )

	elseif self.mode == self.modes.UPGRADE then
		text = UI:GetStringByName( "equipment_upgradeBtn" )

	elseif self.mode == self.modes.CRAFT then
		text = UI:GetStringByName( "equipment_craftBtn" )

	elseif self.mode == self.modes.CRAFT_UPGRADE then
		text = UI:GetStringByName( "equipment_upgradeBtn" )
		
	elseif self.mode == self.modes.CRAFT_GAIN_INFO then
		text = UI:GetStringByName( "equipment_gainInfoBtn" )

	elseif self.mode == self.modes.ACTIVATE_SHIP then
		text = UI:GetStringByName( "equipment_activateShipBtn" )

	elseif self.mode == self.modes.UNLOCK_SPEC_MODULE then
		text = UI:GetStringByName( "equipment_unlockSpecModuleBtn" )

	elseif self.mode == self.modes.BUY_BUNDLE then
		text = UI:GetStringByName( "equipment_buyBudgeteBundle" )
		
	elseif self.mode == self.modes.UPGRADE_AUTOGEN then
		text = UI:GetStringByName( "equipment_upgradeBtn" )
	end

	self:SetText( text, self.layers.TEXT )

end


--
function UI.Equipment_Items_ActionBtn:UpdateTooltip()

	self.tooltipData = nil

	if self.mode == self.modes.CRAFT or self.mode == self.modes.CRAFT_UPGRADE or self.mode == self.modes.CRAFT_GAIN_INFO then

		if UI:GetPlayerAccountRank() < UI.rankLocks.itemCraft then

    		self.tooltipData =
    		{
    			tooltipType	= UI.tooltipTypes.TEXT_SMALL,
				text		= UI.HangarWnd:GetMenuBtnTooltipText( UI.HangarWnd.menuTabs.ITEM_CRAFT ),
    		}

		end

	end

	if self.tooltipData == nil then

    	if	self.mode == self.modes.BUY
    		or self.mode == self.modes.UPGRADE
    		or self.mode == self.modes.CRAFT
			or self.mode == self.modes.CRAFT_UPGRADE
			or self.mode == self.modes.CRAFT_GAIN_INFO then

        	if UI:IsItemUpgradable( self.defName ) and UI:CanItemUpgradeFurther( self.defName ) then	-- #0035581 на кнопку "Купить" также добавлен тултип апгрейда

				local selShipItem	= nil
				local selShipSlotId	= -1

				local parent = self:GetParent()
				if parent then

					if parent.GetSelShipItem then
						selShipItem = parent:GetSelShipItem()
					else
						sys.log( "UI.Equipment_Items_ActionBtn:UpdateTooltip()[ERROR]: no way to get shipItem" )
					end

					if parent.GetSelShipSlot then
						selShipSlotId = parent:GetSelShipSlot():GetSlotId()
					else
						sys.log( "UI.Equipment_Items_ActionBtn:UpdateTooltip()[ERROR]: no way to get ship slot" )
					end

				end

        		self.tooltipData =
        		{
        			tooltipType	= UI.tooltipTypes.UPGRADE_ITEM,
        			defName		= self.defName,			
        			vid			= selShipItem and selShipItem.vid,
        			equipSlot	= selShipSlotId,
					iid			= self.iid,
        		}

        	end

    	end

	end

end


--
function UI.Equipment_Items_ActionBtn:UpdateGoldState()

	self:Check( self.bGold )

end

-- -----------------------------------------------------------------------
-- UI.Equipment_Items_ActionBtn_1080
-- -----------------------------------------------------------------------

UI.Equipment_Items_ActionBtn_1080 =
{
	def =
	{
		className	= "ButtonWnd",
		prototype	= "Equipment_Items_ActionBtn",
		
		props =
		{
			name		= "Equipment_Items_ActionBtn_1080",
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
					defName 			= "equipment_itemsList_slot_actionBtn_1080",
					defaultAnimation	= "idle",

					links =
					{
						{
							objName		= "self",	
							animParams	= UI.EffectAnimParams.SIZE,
						},

						{
							objName		= "text_1",
							layer		= "UI.Equipment_Items_ActionBtn.layers.TEXT",
							animParams	= UI.EffectAnimParams.ALL,
						},
					}
				}}
			},
		}
	}
}


-- ***********************************************************************
-- Внимание, хак! Этот объект сейчас также используется в дереве кораблей, для чего не был изначально предназначен.
-- Внося изменения здесь, надо убедиться, что там не сломалось.

-- ***********************************************************************

-- -----------------------------------------------------------------------
-- UI.Equipment_DDIco_proto
-- -----------------------------------------------------------------------

UI.Equipment_DDIco_proto = {}
local dd = UI.Equipment_DDIco_proto

-- --------------------------------------
-- window definition
-- --------------------------------------

UI.Equipment_DDIco_proto.def =
{
	className	= "Wnd",
	prototype	= "ItemIcoWnd",

	props =
	{
		name		= "Equipment_DDIco_proto",
		isPrototype	= true,
	}
}

-- --------------------------------------
-- interface functions
-- --------------------------------------

--
function UI.Equipment_DDIco_proto:Reset()

	UI.ItemIcoWnd.Reset( self )

	self:AnimateMainDD()

	self.shipSlot = nil

end


--
function UI.Equipment_DDIco_proto:SetupForShipSlot( shipSlot )

	self.shipSlot = shipSlot
	self:UpdateControls()

end



--
function UI.Equipment_DDIco_proto:GetShipSlot()

	return self.shipSlot

end


--
function UI.Equipment_DDIco_proto:UpdatePos( mouseX, mouseY )

	local x = mouseX - self.origin.x
	local y = mouseY - self.origin.y

	self:SetLeft( x )
	self:SetTop( y )

end


-- --------------------------------------
-- const
-- --------------------------------------

dd.origin = UI:PtTo1024x768( UI:Vec2( 0, 0 ), resolution )

-- --------------------------------------
-- vars
-- --------------------------------------

dd.shipSlot	= nil

-- --------------------------------------
-- work functions
-- --------------------------------------

--
function UI.Equipment_DDIco_proto:UpdateControls()

	local defName = self.shipSlot:GetDefName()
	
	local count = 1

	local slotType = self.shipSlot:GetShipSlotType()
	local bAmmmo = slotType == UI.shipSlotTypes.AMMO_PRIMARY or slotType == UI.shipSlotTypes.AMMO_SECONDARY
	if bAmmmo then
		count = self.shipSlot:GetCount()
	end

	local bEnchanted = false
	if UI:IsWndKindOf( self.shipSlot, "Equipment_ModuleShipSlotWnd" ) then
		local iid = self.shipSlot:GetItemId()
		bEnchanted = UI:IsInventoryItemEnchantedById( iid )
	end

	self:SetupForItem( defName, bEnchanted )

	if count == 0 then
		self:HideCount()
		self:ShowNoAmmo()

	elseif count == 1 then
		self:HideCount()
		self:HideNoAmmo()

	else
		self:SetCountInventory( count )
		self:HideNoAmmo()
	end

end


--
function UI.Equipment_DDIco_proto:F_Draw( x0, y0, width, height, clipX0, clipY0, clipWidth, clipHeight )

	local bOldPixelSnap_x, bOldPixelSnap_y = _G.GetTextPixelSnapping()
	_G.SetTextPixelSnapping( false, false )
	
	self:Draw( UI:Quat( x0, y0, width, height ), UI:Quat( clipX0, clipY0, clipWidth, clipHeight ) )
	
	_G.SetTextPixelSnapping( bOldPixelSnap_x, bOldPixelSnap_y )
	
end

-- -------------------------------------------------------------------
-- UI.Equipment_DDIco
-- -------------------------------------------------------------------

UI.Equipment_DDIco =
{
	def =
	{
    	className	= "Wnd",
    	prototype	= "Equipment_DDIco_proto",

    	props =
    	{
    		name	= "Equipment_DDIco"
    	}
	}
}

-- -------------------------------------------------------------------
-- UI.Equipment_TradeWnd
-- -------------------------------------------------------------------

UI.Equipment_TradeWnd =
{
    def =
    {
    	className 	= "Wnd",
    	prototype	= "TradeWnd",

    	props =
    	{
    		name	= "Equipment_TradeWnd",
    	},
	},

	mainWndName = "EquipmentWnd",
}

-- -------------------------------------------------------------------
-- UI.Equipment_BuyWnd
-- -------------------------------------------------------------------

UI.Equipment_BuyWnd =
{
    def =
    {
    	className 	= "Wnd",
    	prototype	= "BuyWnd",

    	props =
    	{
    		name	= "Equipment_BuyWnd",
    	},
	},

	mainWndName = "EquipmentWnd",
}


-- -------------------------------------------------------------------
-- UI.Equipment_SalvageWnd
-- -------------------------------------------------------------------

UI.Equipment_SalvageWnd =
{
    def =
    {
    	className 	= "Wnd",
    	prototype	= "SalvageWnd",

    	props =
    	{
    		name	= "Equipment_SalvageWnd",
    	},
	},
}

-- -------------------------------------------------------------------
-- UI.Equipment_UpgradeItemWnd
-- -------------------------------------------------------------------

UI.Equipment_UpgradeItemWnd =
{
    def =
    {
    	className 	= "Wnd",
    	prototype	= "UpgradeItemWnd",

    	props =
    	{
    		name	= "Equipment_UpgradeItemWnd",
    	},
	},

	mainWndName = "EquipmentWnd",
}

-- -----------------------------------------------------------------
-- UI.EquipmentShipUpgradeWnd
-- -----------------------------------------------------------------

UI.EquipmentShipUpgradeWnd = {}

-- -----------------------------------
-- window definition
-- -----------------------------------

UI.EquipmentShipUpgradeWnd.def =
{
	className = "Wnd",
	props =
	{
		name			= "EquipmentShipUpgradeWnd",
		style			= UI.WS_NOT_KB_REACT + UI.WS_UPDATE_IF_VISIBLE,
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
				defName 			= "equipment_ship_upgrade",
       			defaultAnimation	= "idle",
           		links =
           		{
           			{
           				objName		= "self",
           				animParams	= UI.EffectAnimParams.SIZE,
           			},
           			{
           				objName		= "lvlup_ship_name",
           				layer		= "UI.EquipmentShipUpgradeWnd.layers.NAME_TEXT",
           				animParams	= UI.EffectAnimParams.ALL,
           			},
           			{
           				objName		= "lvlup_ship_lvl",
           				layer		= "UI.EquipmentShipUpgradeWnd.layers.LEVEL_TEXT",
           				animParams	= UI.EffectAnimParams.ALL,
           			},
           			{
           				objName		= "lvlup_ship",
           				wnd			= "UI.EquipmentShipUpgrade_Btn",
           				animParams	= UI.EffectAnimParams.POS,
           			},
           			{
           				objName		= "sinergy_progr",
           				wnd			= "UI.EquipmentShipUpgrade_SynergyBarWnd",
           				animParams	= UI.EffectAnimParams.POS,
           			},

           			{
           				objName		= "lvlup_ship",
           				wnd			= "UI.EquipmentShipUpgrade_AlienInfo",
           				animParams	= UI.EffectAnimParams.POS,
           			},
           		}
           	}}
		},
		-- NAME_TEXT
		{
			layerType	= UI.LAYER_TEXT,
   			formatFlags	 = FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz = { 1, 1 },
   			font =
			{
   				fontName = "Small",
   			},
		},
		-- LEVEL_TEXT
		{
			layerType	= UI.LAYER_TEXT,
   			formatFlags	 = FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz = { 1, 1 },
   			font =
			{
   				fontName = "Small",
   			},
		},
	},

	children = { "UI.EquipmentShipUpgrade_Btn", "UI.EquipmentShipUpgrade_SynergyBarWnd", "UI.EquipmentShipUpgrade_AlienInfo" }
}

UI.EquipmentShipUpgradeWnd.vessel = nil


-- -----------------------------------
-- interface functions
-- -----------------------------------

--
function UI.EquipmentShipUpgradeWnd:GetVessel()
	return self.vessel
end

--
function UI.EquipmentShipUpgradeWnd:Update()

	if not self:GetParent() then
		return
	end

	self.requestId = nil
	local vessel = UI.HangarWnd:GetSelShipItem()
	self.vessel = vessel
	
	local bNeedShow = false
	
	if vessel then
	
		local bIsMaxed = false
		
		if UI:IsShipEvolving( vessel.defName ) then

	    	local nodes			= UI:GetEvolvingShipNodes( vessel.defName )
			local unlockedMask	= UI:GetEvolvingShipUnlockedNodesMask( vessel.vid )

			local bAllNodesLearned = true

			for nodeName, node in pairs( nodes ) do

				if not UI:CantBeBoughtEvolvingShipNode( nodeName ) and not UI:IsEvolvingShipNodeHidden( nodeName, true, vessel.defName, nodes ) then

					local nodeId = UI:GetEvolvingShipNodeId( nodeName )
					if nodeId ~= -1 then
						if not UI:BitTstU64( unlockedMask, nodeId ) then
							bAllNodesLearned = false
							break
						end
					else
						sys.log( "UI.EquipmentShipUpgradeWnd:Update()[ERROR]: invalid nodeId for node \"%s\"", nodeName )
					end

				end

			end

			if bAllNodesLearned then
				bIsMaxed = true
			end

		else
			bIsMaxed = UI:GetShipLevel( vessel ) >= UI:GetShipMaxLevel( vessel.defName )
		end
		
		bNeedShow = not bIsMaxed
		
	end
	
	if bNeedShow then
		UI.EquipmentWnd:AddChild( self )
		local name = UI:GetEntityLocalizedNameByDef( vessel.defName, true )
		self:SetText( name, self.layers.NAME_TEXT )
		local shipRank = UI:GetShipLevel( vessel )
		local maxShipRank = UI:GetShipMaxLevel( vessel.defName )

		if UI:IsShipEvolving( vessel.defName ) then
    		UI.EquipmentShipUpgrade_SynergyBarWnd:Setup( 1, 1 )
    		self:SetText( "", self.layers.LEVEL_TEXT )
		else
    		local str = UI:GetStringByName( "equip_ship_upgrade_level" )
    		UI.EquipmentShipUpgrade_SynergyBarWnd:Setup( shipRank, maxShipRank )
    		str = string.gsub( str, "%$cur_level%$", tostring( math.min( shipRank, maxShipRank ) ) )
    		str = string.gsub( str, "%$max_level%$", tostring( maxShipRank ) )
    		self:SetText( str, self.layers.LEVEL_TEXT )
		end

		local mainEffect = UI:GetEffectFromLayer( self, self.layers.MAIN_EFFECT )

		if UI:IsShipEvolving( vessel.defName ) then
			UI.EquipmentShipUpgrade_Btn:UnlinkFromParent()
			self:AddChild( UI.EquipmentShipUpgrade_AlienInfo )
			UI.EquipmentShipUpgrade_AlienInfo:Setup( vessel )
		else
			if not UI.EquipmentShipUpgrade_Btn:GetParent() then
				UI:AddChildAndLink( self, UI.EquipmentShipUpgrade_Btn, mainEffect, "lvlup_ship", UI.EffectAnimParams.POS )		
			end
			UI.EquipmentShipUpgrade_Btn:Update( vessel )
			UI.EquipmentShipUpgrade_AlienInfo:UnlinkFromParent()
		end

	else
		self:UnlinkFromParent()
	end
end

--
function UI.EquipmentShipUpgradeWnd:WaitResponce()
	return self.requestId ~= nil
end

--
function UI.EquipmentShipUpgradeWnd:GameStore_OnVesselLevelUp( result, requestId, param1, param2 )

	if result == 0 then
		if self:IsOnScreen() then
			self:Update()
			if UI:GetCurTooltipTarget() == UI.EquipmentShipUpgrade_Btn then
				UI:GetCurTooltip():Setup( UI.EquipmentShipUpgrade_Btn:GetTooltipData() )
			end
		end
	else
		if requestId == self.requestId then
			UI:MessageBox( UI:GetStringByName( "msgCapt_error" ), UI:GetStringByName( "shipUpgrade_error_"..UI:Val2Key( GameStore.StoreBuyResult, result ) ), UI.MBS_OK )
		end
	end

	self.requestId = nil

end


--
function UI.EquipmentShipUpgradeWnd:GameStore_OnExtractVesselExp( result, requestId, vids )

	if result ~= 0 then
		return
	end

	if not self:IsOnScreen() then
		return
	end

	if UI.EquipmentShipUpgrade_AlienInfo:IsChildOf( self ) then
		UI.EquipmentShipUpgrade_AlienInfo:FullUpdate()
	end

end


--
function UI.EquipmentShipUpgradeWnd:GameStore_OnVesselUnlockNode( result, requestId, param1, param2, u64Param )	

	if result ~= _G.GameStore.StoreBuyResult.SBR_OK then
		return
	end

	if not self:IsOnScreen() then
		return
	end

	if u64Param == UI.HangarWnd:GetSelShipItem() then

		self:Update()

	else

		if UI.EquipmentShipUpgrade_AlienInfo:IsChildOf( self ) then
			UI.EquipmentShipUpgrade_AlienInfo:FullUpdate()
		end

	end

end


--
function UI.EquipmentShipUpgradeWnd:MasterServer_OnPlayerCredits( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	if result ~= 0 then
		return
	end

	if UI.EquipmentShipUpgrade_AlienInfo:IsChildOf( self ) then
		UI.EquipmentShipUpgrade_AlienInfo:FullUpdate()
	end

end


--
function UI.EquipmentShipUpgradeWnd:MasterServer_OnCraftResources( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	if result ~= 0 then
		return
	end

	self:OnResourcesChanged()

end


--
function UI.EquipmentShipUpgradeWnd:MasterServer_OnUseCraftResource( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	if result ~= _G.GameStore.StoreBuyResult.SBR_OK then
		return
	end

	self:OnResourcesChanged()

end


--
function UI.EquipmentShipUpgradeWnd:MasterServer_OnSellCraftResource( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	if result ~= 0 then
		return
	end

	self:OnResourcesChanged()

end


--
function UI.EquipmentShipUpgradeWnd:MasterServer_OnSellCraftResources( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	if result ~= 0 then
		return
	end

	self:OnResourcesChanged()

end


--
function UI.EquipmentShipUpgradeWnd:GameStore_OnCraftUpgradeItem( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	if result ~= _G.GameStore.StoreBuyResult.SBR_OK then
		return
	end

	self:OnResourcesChanged()

end


--
function UI.EquipmentShipUpgradeWnd:MasterServer_OnLearnBlueprints( result, requestId, defName )

	if not self:IsOnScreen() then
		return
	end

	if result ~= _G.GameStore.StoreBuyResult.SBR_OK then
		return
	end

	self:OnResourcesChanged()

end


--
function UI.EquipmentShipUpgradeWnd:MasterServer_OnAdvertCreate( result, requestId, param1, param2, u64Param )

	if result ~= _G.MasterServer.AdvertResult.AR_OK then
		return
	end

	if not self:IsOnScreen() then
		return
	end

	self:OnResourcesChanged()
	
end


--
function UI.EquipmentShipUpgradeWnd:MasterServer_OnAdvertDelete( result, requestId, param1, param2, u64Param )

	if result ~= _G.MasterServer.AdvertResult.AR_OK then
		return
	end

	if not self:IsOnScreen() then
		return
	end

	self:OnResourcesChanged()
	
end


--
function UI.EquipmentShipUpgradeWnd:MasterServer_OnAdvertExpired( result, requestId, param1, param2, u64Param )

	if result ~= _G.MasterServer.AdvertResult.AR_OK then
		return
	end

	if not self:IsOnScreen() then
		return
	end

	self:OnResourcesChanged()
	
end


--
function UI.EquipmentShipUpgradeWnd:MasterServer_OnQuests( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	if result ~= 0 then
		return
	end


end


--
function UI.EquipmentShipUpgradeWnd:MasterServer_OnAcceptQuest( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	if result ~= _G.MasterServer.QuestResult.QR_OK then
		return
	end

	self:OnQuestsChanged()

end


--
function UI.EquipmentShipUpgradeWnd:MasterServer_OnCompleteQuest( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	if result ~= _G.MasterServer.QuestResult.QR_OK then
		return
	end

	self:OnQuestsChanged()

end


--
function UI.EquipmentShipUpgradeWnd:MasterServer_OnChangeQuest( result, requestId, param1, param2 )

	if not self:IsOnScreen() then
		return
	end

	if result ~= _G.MasterServer.QuestResult.QR_OK then
		return
	end

	self:OnQuestsChanged()

end


-- -----------------------------------
-- const
-- -----------------------------------

UI.EquipmentShipUpgradeWnd.layers = 
{
	MAIN_EFFECT	= 0,
	NAME_TEXT	= 1,
	LEVEL_TEXT	= 2,
}

UI.EquipmentShipUpgradeWnd.requestId = nil

-- -----------------------------------
-- work functions
-- -----------------------------------

--
function UI.EquipmentShipUpgradeWnd:OnResourcesChanged()

	if UI.EquipmentShipUpgrade_AlienInfo:IsChildOf( self ) then
		UI.EquipmentShipUpgrade_AlienInfo:FullUpdate()
	end

end


--
function UI.EquipmentShipUpgradeWnd:OnQuestsChanged()

	if UI.EquipmentShipUpgrade_AlienInfo:IsChildOf( self ) then
		UI.EquipmentShipUpgrade_AlienInfo:FullUpdate()
	end

end


-- -----------------------------------------------------------------
-- UI.EquipmentShipUpgrade_Btn
-- -----------------------------------------------------------------

UI.EquipmentShipUpgrade_Btn = {}

-- -----------------------------------
-- window definition
-- -----------------------------------

UI.EquipmentShipUpgrade_Btn.def =
{
	className = "Wnd",
	props =
	{
		name			= "EquipmentShipUpgrade_Btn",
		style			= UI.WS_NOT_KB_REACT + UI.WS_UPDATE_IF_VISIBLE,
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
				defName 			= "equipment_ship_upgrade_btn",
       			defaultAnimation	= "idle",
           		links =
           		{
           			{
           				objName		= "self",
           				animParams	= UI.EffectAnimParams.SIZE,
           			},
           			{
           				objName		= "lvlup_text",
           				layer		= "UI.EquipmentShipUpgrade_Btn.layers.ACTION_TEXT",
           				animParams	= UI.EffectAnimParams.ALL,
           			},
           			{
           				objName		= "syn_lvl",
           				layer		= "UI.EquipmentShipUpgrade_Btn.layers.VALUE_TEXT",
           				animParams	= UI.EffectAnimParams.ALL,
           			},
           		}
           	}}
		},
		-- ACTION_TEXT
		{
			layerType	= UI.LAYER_TEXT,
   			formatFlags	 = FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz = { 1, 1 },
   			font =
			{
   				fontName = "Small",
   			},
   			text = "^equip_ship_upgrade_btn"
		},
		-- VALUE_TEXT
		{
			layerType	= UI.LAYER_TEXT,
			layerStyle	= UI.WLS_OWNERDRAW,
   			formatFlags	 = FONT.TF_SINGLELINE + FONT.TF_NOCLIP,
   			formatInfoSz = { 1, 1 },
   			font =
			{
   				fontName = "Small",
   			},
		},
	},
}


UI.EquipmentShipUpgrade_Btn.GetTooltipData = function( self )
		return self:FormatTooltip( self.vessel )
	end


-- -----------------------------------
-- interface functions
-- -----------------------------------

--
function UI.EquipmentShipUpgrade_Btn:Update( vessel )
	self.vessel = vessel
	if vessel then
		self.wait = false
		local shipRank = UI:GetShipRank( vessel.defName )
		local shipLevel = UI:GetShipLevel( vessel )
		local cost = VesselExpPerLevel[ shipRank ][ shipLevel ] or 0
		local isSynergy = math.min( UI:GetShipExp( vessel ) + UI:GetPlayerFreeSynergy(), cost )
		local text = string.format( "%s / %s$synergy_ship$", UI:Num2StrSeparatedBy3( isSynergy ), UI:Num2StrSeparatedBy3( cost ) )
		self.valMetaText:SetText( text, true )
		self.enable = cost <= UI:GetShipExp( vessel ) + UI:GetPlayerFreeSynergy()
		self:UpdateAnim()
	end
end

-- коллбэк, вызывается из окна увеличения инвентаря
function UI.EquipmentShipUpgrade_Btn:OnClanConfirmWndResult( result, mode )
	self.wait = false
	if result == true then
		UI.EquipmentShipUpgradeWnd.requestId = _G.GameStore_VesselLevelUp( self.vessel.vid )
	end
end


--
function UI.EquipmentShipUpgrade_Btn:IsEnabled()

	return self.enable

end


-- -----------------------------------
-- const
-- -----------------------------------

UI.EquipmentShipUpgrade_Btn.layers = 
{
	MAIN_EFFECT			= 0,
	ACTION_TEXT			= 1,
	VALUE_TEXT			= 2,
}

-- -----------------------------------
-- vars
-- -----------------------------------
UI.EquipmentShipUpgrade_Btn.enable = false
UI.EquipmentShipUpgrade_Btn.wait = false
UI.EquipmentShipUpgrade_Btn.request = nil
UI.EquipmentShipUpgrade_Btn.vessel = nil
UI.EquipmentShipUpgrade_Btn.isOver = false
UI.EquipmentShipUpgrade_Btn.valMetaText	= nil


-- -----------------------------------
-- work functions
-- -----------------------------------

--
function UI.EquipmentShipUpgrade_Btn:F_PostLoad()

	UI.Wnd.F_PostLoad( self )

	self.valMetaText = UI.MetaText.GetNewInstance()
	self.valMetaText:InitFromLayer( self, self.layers.VALUE_TEXT ) 

end


--
function UI.EquipmentShipUpgrade_Btn:F_Shutdown()

	if self.valMetaText then
		self.valMetaText:Clear()
	end

	UI.Wnd.F_Shutdown( self )

end


--
function UI.EquipmentShipUpgrade_Btn:F_OnAfterShowOnScreen()

	self:OnAfterShowOnScreen()

	self:UpdateMetaTextPos()

end


--
function UI.EquipmentShipUpgrade_Btn:F_OnScreenPosChanged( oldScreenX, oldScreenY )

	self:OnScreenPosChanged( oldScreenX, oldScreenY )

	-- может вызываеться при инициализации окна, когда еще слои не созданы
	if self:GetNumLayers() == 0 then
		return
	end

	if self:IsOnScreen() then
		self:UpdateMetaTextPos()
	end

end


--
function UI.EquipmentShipUpgrade_Btn:UpdateMetaTextPos()

	self.valMetaText:UpdateScreenOrgFromLayer( self, self.layers.VALUE_TEXT )

end


--
function UI.EquipmentShipUpgrade_Btn:F_DrawLayer( x0, y0, width, height, clipX0, clipY0, clipWidth, clipHeight, layerIdx )

	if layerIdx == self.layers.VALUE_TEXT then
		self.valMetaText:Draw( clipX0, clipY0, clipWidth, clipHeight )
	end

end


--
function UI.EquipmentShipUpgrade_Btn:FormatTooltip( vessel, level )
	
	local curLevel = level and level or UI:GetShipLevel( vessel )

	local craftedBonuses = {}
	if UI:IsShipCraftable( vessel.defName ) then
		for lvl = 1, UI:GetShipMaxLevel( vessel.defName ) do
			table.insert( craftedBonuses, UI:GetShipCraftedBonus( vessel, lvl ) )
		end
	end

	local curSpawnData =
	{
		baseDef			= vessel.defName,
		level			= curLevel,
		specialGrades	= craftedBonuses
	}

	local nextSpawnData =
	{
		baseDef			= vessel.defName,
		level			= curLevel + 1,
		specialGrades	= craftedBonuses
	}

	if UI:IsShipEvolving( vessel.defName ) then

		curSpawnData.sourceDef		= UI:GetEvolvingShipBaseDef( vessel.defName )
		curSpawnData.activeMask		= UI:GetEvolvingShipActiveNodesMask( vessel.vid )

		nextSpawnData.sourceDef		= curSpawnData.sourceDef
		nextSpawnData.activeMask	= curSpawnData.activeMask

	end

	local curParams = _G.CL_GetShipParamsFromSpawnData( curSpawnData )
	local nextParams = _G.CL_GetShipParamsFromSpawnData( nextSpawnData )
	local shipParams = _G.ShipTooltipParams or {}
	local value = nil
	local upgradeParams = ""
	local str = ""
	for paramIdx = 1, #shipParams do
		if not shipParams[ paramIdx].separator then
			value = nil
			for k, v in pairs( curParams ) do
				if k == shipParams[ paramIdx ].name then
					value = { v }
				end
			end
			local curVal = UI:GetParamVals( vessel.defName, shipParams[ paramIdx], UI.paramSrcTypes.SHIP, { params = curParams }, false )
			local nextVal = UI:GetParamVals( vessel.defName, shipParams[ paramIdx], UI.paramSrcTypes.SHIP, { params = nextParams }, false )
			if curVal[ 1 ] ~= nextVal[ 1 ] then
				if curVal[ 1 ] > nextVal[ 1 ] then
					str = "    "..UI:ShipParam2Str( shipParams[ paramIdx] )..": @ff19ee1a"..UI:ParamVal2Str( shipParams[ paramIdx], nextVal[ 1 ] - curVal[ 1 ] ).."@ffffffff "..UI:ParamUnits2Str( shipParams[ paramIdx] )
				else
					str = "    "..UI:ShipParam2Str( shipParams[ paramIdx] )..": @ff19ee1a+"..UI:ParamVal2Str( shipParams[ paramIdx], nextVal[ 1 ] - curVal[ 1 ] ).."@ffffffff "..UI:ParamUnits2Str( shipParams[ paramIdx] )
				end
				upgradeParams = upgradeParams.."|"..str
			end
		end
	end

	if upgradeParams ~= "" then
		local str = UI:GetStringByName( "equip_ship_upgrade_params" )
		upgradeParams = str..upgradeParams
	end

	local bonusText = ""
	local strSubstColor = UI:Color2Str( UI.TEXT_SEL_COLOR )
	local strPartDescColor = UI:Color2Str( 0xffffffff )

	local fnItemGroupSubst = function( capture )
		local strSubst = nil
		local itemGroupName = string.match( capture, "^itemGroup_(.-)$" )
		if itemGroupName then
			local itemGroup = ai.ItemGroup[ itemGroupName ]
			if itemGroup then				
				strSubst = UI:ItemGroup2Str( itemGroup )
			else
				sys.log( "UI.EquipmentShipUpgrade_Btn:FormatTooltip()[ERROR]: invalid item group: \"%s\" for ship %s", itemGroupName or "", vessel.defName )
			end
		end
		if strSubst then
			strSubst = string.format( "%s%s%s", strSubstColor, strSubst, strPartDescColor )
		end
		return strSubst
	end

	local shipDef = UI:GetDef( vessel.defName )
	if shipDef then
		if shipDef.special_grades then
    		if shipDef.special_grades[ curLevel + 1 ] ~= nil then
    			local spGrade = shipDef.special_grades[ curLevel + 1 ]
    			local params = {}

    			local selBonusName = _G.GameStore_GetVesselCraftedSpecialGrade( vessel.vid, ( curLevel + 1 ) - 1 )

        		if UI:IsShipCraftable( vessel.defName ) then

        			-- формат поля данных для уровня синергии может быть разный;
        			-- там могут быть как собственно моодификаторы в формате {имя_модификатора=значение},
        			-- так и список имен бонусов, из которых игрок при крафте корабля выбирает один,
        			-- а модификаторы хранятся уже в данных того бонуса;
        			-- отлиается один формат от другого хаком -
        			-- если есть целочисленные ключи в таблице, значит это массив, и значит это список имен бонусов

        			local bIsBonusNamesArr = false

        			for key, val in pairs( spGrade ) do
        				if type( key ) == "number" then
        					bIsBonusNamesArr = true
        					break
        				end
        			end

        			if bIsBonusNamesArr then

    					if type( _G.ShipSpecBonus ) == "table" then

    						spGrade = _G.ShipSpecBonus[ selBonusName ]

    						if type( spGrade ) ~= "table" then
    							sys.log( "UI.EquipmentShipUpgrade_Btn:FormatTooltip()[ERROR]: invalid type of \"_G.ShipSpecBonus[\"%s\"]\"; \"table\" expected, got \"%s\"", selBonusName, type( spGrade ) )
    							spGrade = nil
    						end

    					else
    						sys.log( "UI.EquipmentShipUpgrade_Btn:FormatTooltip()[ERROR]: invalid type of \"_G.ShipSpecBonus\"; \"table\" expected, got \"%s\"", type( _G.ShipSpecBonus ) )
    					end							

        			end

        		end
    			
    			if spGrade then
        			for k, v in pairs( spGrade ) do
        				table.insert( params, { name = k, val = v } )
        			end
    			end

            	local function l_fnSortByName( param1, param2 )
            		return param1.name < param2.name
            	end
    			table.sort( params, l_fnSortByName )
    			
    			for i = 1, #params do
    				local param = params[ i ]
    				local descriptionParams = UI:GetShipDescParams( vessel.defName )
    				local descParamInfo = nil
    				for descParamIdx, descInfo in pairs( descriptionParams ) do
    					if type( descInfo.valField ) == "string" and descInfo.valField == param.name then
    						descParamInfo = descInfo
    						break
    					end
    				end
    				if descParamInfo then
                		local vals = UI:GetParamVals( vessel.defName, descParamInfo, UI.paramSrcTypes.SHIP, nextParams, false, curLevel + 1, selBonusName )
                		if next( vals ) ~= nil then
                			local partDescId = string.format( vals[ 1 ] < 0 and "ship_desc_negative_%s" or "ship_desc_bonus_%s", descParamInfo.name )
                			local partDesc = UI:GetStringByName( partDescId )
    						--strPartDescColor = synergyLevel > shipSynergylevel and strLockColor or strBaseColor
                			partDesc = string.gsub( partDesc, "%$(.-)%$", fnItemGroupSubst )
                			srcInfo = { defName = vessel.defName, dataType = UI.paramSrcTypes.SHIP, data = nextParams, synergyLevel = curLevel + 1 }
        					local strParam = UI:GetParamValAsStr( descParamInfo, srcInfo, nil, false, UI.TEXT_SEL_COLOR, nil, true, descriptionParams, nil, nil, curLevel + 1, selBonusName )
        					if not UI:IsStrEmpty( strParam ) then
        						strParam = string.format( "%s%s", strParam, strPartDescColor )
        					else
        						sys.log( "UI.EquipmentShipUpgrade_Btn.GetTooltipData()[ERROR]: cannot convert parameter \"%s\" for \"%s\" into string; it has no corresponding values", descParamInfo.name, srcInfo.defName )
        						strParam = nil
        					end
    						local strPattern = "%$"..descParamInfo.name.."%$"
    						partDesc = string.gsub( partDesc, strPattern, strParam )
    						if bonusText == "" then
    							bonusText = partDesc
    						else
    							bonusText = bonusText.."|"..partDesc
    						end
                		end
    				end
    			end
    		end
		else
			if not UI:IsShipEvolving( vessel.defName ) then
				sys.log( "UI.EquipmentShipUpgrade_Btn.GetTooltipData()[ERROR]: can't find Def[\"%s\"].special_grades ", vessel.defName )
			end
		end
	else
		sys.log( "UI.EquipmentShipUpgrade_Btn.GetTooltipData()[ERROR]: can't find def with name '%s'", vessel.defName )
	end

	if bonusText ~= "" then
		if upgradeParams ~= "" then
			bonusText = "||"--[[..UI:GetStringByName( "equip_ship_upgrade_bonus" )]]..bonusText
		end
	end

	--
	local unlockText = ""
	local vessels = UI:IsUpgradeUnlockNextShip( vessel.defName, curLevel )
	if #vessels > 0 then
		for k, v in pairs( vessels ) do
			local str5 = UI:GetStringByName( "equip_ship_upgrade_unlock" )
			str5 = string.gsub( str5, "%$ship_name%$", UI:GetEntityLocalizedNameByDef( v, false ) )
			if unlockText == "" then
				unlockText = str5
			else
				unlockText = unlockText.."|"..str5
			end
		end
	end

	if unlockText ~= "" then
		if bonusText ~= "" or upgradeParams ~= "" then
			unlockText = "||"..unlockText
		end
	end

	local prestigeText = ""

	local maxLevel = UI:GetShipMaxLevel( vessel.defName )
	if maxLevel == curLevel + 1 then
		prestigeText = UI:GetStringByName( "equip_ship_upgrade_prestige" )
	end

	if prestigeText ~= "" then
		if bonusText ~= "" or upgradeParams ~= "" or unlockText ~= "" then
			prestigeText = "||"..prestigeText
		end
	end

	local tooltipData = { tooltipType = UI.tooltipTypes.TEXT_LARGE, text = upgradeParams..bonusText..unlockText..prestigeText, caption = string.gsub( UI:GetStringByName( "tooltip_shipUpgrade_info_caption" ), "%$next_level%$", curLevel + 1 ) }
	return tooltipData
end

--
function UI.EquipmentShipUpgrade_Btn:OnMouseClick()
	if self.enable and not self.wait and self.vessel and not UI.EquipmentShipUpgradeWnd:WaitResponce() then
		local shipRank = UI:GetShipRank( self.vessel.defName )
		local shipLevel = UI:GetShipLevel( self.vessel )
		local cost = VesselExpPerLevel[ shipRank ][ shipLevel ]
		local data = {}
		local shipExp = UI:GetShipExp( self.vessel )
		if shipExp >= cost then
			data.synergy = cost
			data.commonSynergy = 0
		else
			data.synergy = shipExp
			data.commonSynergy = cost - shipExp
		end

		local text = self:FormatTooltip( self.vessel ).text

		UI.ClanConfirmWnd:Show( UI.ClanConfirmWnd.Modes.SHIP_UPGRADE, text, { data }--[[data]] )

		self.wait = true
		UI:PlayGlobalSound( UI.sounds.btnClick )
	end
end

--
function UI.EquipmentShipUpgrade_Btn:UpdateAnim()
	local mainEffect = UI:GetEffectFromLayer( self, self.layers.MAIN_EFFECT )
	if self.enable then
	
		-- анимации мигающие,
		-- при переключении меду ними восстанавливается время анимации, чтобы визуального скачка не было
		
		local prevAnim = mainEffect:GetCurAnimation()
		
		local animTime = 0
		if prevAnim == "over" or prevAnim == "idle" then
			animTime = mainEffect:GetAnimationTime()
		end
	
		if self.isOver then
			mainEffect:StartAnimation( "over" )
		else
			mainEffect:StartAnimation( "idle" )
		end
		
		mainEffect:SetAnimationTime( animTime )
		
	else
		mainEffect:StartAnimation( "disable" )
	end
end

--
function UI.EquipmentShipUpgrade_Btn:F_OnMouseIn( mouseX, mouseY, wndThatReceivedInput )
	if self:OnMouseIn( mouseX, mouseY, wndThatReceivedInput ) then
		return true
	end
	self.isOver = true
	if self.enable then
		UI:PlayGlobalSound( UI.sounds.btnMouseOver )
	end
	self:UpdateAnim()
	return true
end

--
function UI.EquipmentShipUpgrade_Btn:F_OnMouseOut( mouseX, mouseY, wndThatReceivedInput )
	if self:OnMouseOut( mouseX, mouseY, wndThatReceivedInput ) then
		return true
	end
	self.isOver = false
	self:UpdateAnim()
	return true	
end


-- ----------------------------------------------------------------
-- UI.EquipmentShipUpgrade_SynergyBarWnd
-- ----------------------------------------------------------------

UI.EquipmentShipUpgrade_SynergyBarWnd = {}
UI.EquipmentShipUpgrade_SynergyBarWnd.def =
{
	className	= "Wnd",
	prototype 	= "SynergyBarWnd",
	props =
	{
		name		= "EquipmentShipUpgrade_SynergyBarWnd",
	},
}

-- -------------------------------------------------------------------
-- UI.EquipmentShipUpgrade_AlienInfo
-- -------------------------------------------------------------------

UI.EquipmentShipUpgrade_AlienInfo = {}

-- --------------------------------
-- window definition
-- --------------------------------

UI.EquipmentShipUpgrade_AlienInfo.def =
{
	className	= "Wnd",

	props =
	{
		name	= "EquipmentShipUpgrade_AlienInfo",
		style 	= UI.WS_UPDATE_IF_VISIBLE + UI.WS_NOT_MOUSE_REACT + UI.WS_NOT_KB_REACT,
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
				defName 			= "ships_freeSynergy",
				defaultAnimation	= "idle",

				links =
				{
					{
						objName		= "self",	
						animParams	= UI.EffectAnimParams.SIZE,
					},

					{
						objName		= "btn",
						wnd			= "UI.EquipmentShipUpgrade_OpenAlienEditBtn",
						animParams	= UI.EffectAnimParams.POS,
					},

					{
						objName		= "syn_free_txt",
						layer		= "UI.EquipmentShipUpgrade_AlienInfo.layers.SYNERGY",
						animParams	= UI.EffectAnimParams.ALL,
					},
				}
			}}
		},

		-- SYNERGY
		{
			layerType		= UI.LAYER_TEXT,
			layerStyle		= UI.WLS_OWNERDRAW,
   			formatFlags	 	= 0,
   			formatInfoSz	= { 2, 1 },
   			font			= { fontName = "Small" },
		},
	},

	children = { "UI.EquipmentShipUpgrade_OpenAlienEditBtn" }

}

-- --------------------------------
-- interface functions
-- --------------------------------

--
function UI.EquipmentShipUpgrade_AlienInfo:Setup( shipItem )

	self:Reset()

	self.shipItem = shipItem
	self:FullUpdate()

end


--
function UI.EquipmentShipUpgrade_AlienInfo:FullUpdate()

	local node, info = self:GetNextNode()

	self:UpdateSynergy( node, info )
	self:UpdateOpenAlienEditBtn( node, info )

end


-- --------------------------------
-- const
-- --------------------------------

UI.EquipmentShipUpgrade_AlienInfo.layers =
{
	MAIN_EFFECT	= 0,
	SYNERGY		= 1,
}

-- --------------------------------
-- vars
-- --------------------------------

UI.EquipmentShipUpgrade_AlienInfo.shipItem			= nil
UI.EquipmentShipUpgrade_AlienInfo.synergyMetaText	= nil

-- --------------------------------
-- work functions
-- --------------------------------

--
function UI.EquipmentShipUpgrade_AlienInfo:F_PostLoad()

	UI.Wnd.F_PostLoad( self )

	self.synergyMetaText = UI.MetaText.GetNewInstance()
	self.synergyMetaText:InitFromLayer( self, self.layers.SYNERGY ) 

end


--
function UI.EquipmentShipUpgrade_AlienInfo:F_Shutdown()

	if self.synergyMetaText then
		self.synergyMetaText:Clear()
	end

	UI.Wnd.F_Shutdown( self )

end


--
function UI.EquipmentShipUpgrade_AlienInfo:F_OnAfterShowOnScreen()

	self:OnAfterShowOnScreen()

	self:UpdateMetaTextPos()

end


--
function UI.EquipmentShipUpgrade_AlienInfo:F_OnScreenPosChanged( oldScreenX, oldScreenY )

	self:OnScreenPosChanged( oldScreenX, oldScreenY )

	-- может вызываеться при инициализации окна, когда еще слои не созданы
	if self:GetNumLayers() == 0 then
		return
	end

	if self:IsOnScreen() then
		self:UpdateMetaTextPos()
	end

end


--
function UI.EquipmentShipUpgrade_AlienInfo:UpdateMetaTextPos()

	self.synergyMetaText:UpdateScreenOrgFromLayer( self, self.layers.SYNERGY )

end


--
function UI.EquipmentShipUpgrade_AlienInfo:F_DrawLayer( x0, y0, width, height, clipX0, clipY0, clipWidth, clipHeight, layerIdx )

	if layerIdx == self.layers.SYNERGY then
		self.synergyMetaText:Draw( clipX0, clipY0, clipWidth, clipHeight )
	end

end


--
function UI.EquipmentShipUpgrade_AlienInfo:Reset()

	self.shipItem = nil

	self.synergyMetaText:SetText( "", true )
	UI.EquipmentShipUpgrade_OpenAlienEditBtn:Check( false )		

end


--
function UI.EquipmentShipUpgrade_AlienInfo:UpdateSynergy( node, info )

	local needSynergy	= 0
	local isSynergy		= UI:GetShipExp( self.shipItem ) + UI:GetPlayerFreeSynergy()

	if node then
		needSynergy = info.synergyPrice
	end

	isSynergy = math.min( needSynergy, isSynergy )

	local str = string.format( "%s|%s / %s$synergy_ship$", UI:GetStringByName( "equip_ship_upgrade_nodeSynergy" ), UI:Num2StrSeparatedBy3( isSynergy ), UI:Num2StrSeparatedBy3( needSynergy ) )
	self.synergyMetaText:SetText( str, true )

end


--
function UI.EquipmentShipUpgrade_AlienInfo:UpdateOpenAlienEditBtn( node, info )

	-- цвет - зеленый/красный

	local bNodeEnable = true

	if node then
		bNodeEnable = info.bEnable
	end

	UI.EquipmentShipUpgrade_OpenAlienEditBtn:Check( bNodeEnable )

	-- тултип

    local tooltipData = nil

	if node then

    	tooltipData =
    	{
    		tooltipType		= UI.tooltipTypes.SHIP_NODE,
    		nodeName		= node.name,
    		shipDefName		= self.shipItem.defName,
    		vid				= self.shipItem.vid,
    	}

	end

	UI.EquipmentShipUpgrade_OpenAlienEditBtn:SetTooltipData( tooltipData )

end


--
function UI.EquipmentShipUpgrade_AlienInfo:GetNextNode()

	local unlockedRank	= UI:GetEvolvingShipUnlockedRank( self.shipItem )
    local nodes			= UI:GetEvolvingShipNodes( self.shipItem.defName )
	local unlockedMask	= UI:GetEvolvingShipUnlockedNodesMask( self.shipItem.vid )

	-- неизученные ноды, доступные для изучения ( подходит ранг, родитель изучен (если он есть) и не cant_be_bought/hidden )
	local availableNodes = {}

	for nodeName, node in pairs( nodes ) do

		local nodeId = UI:GetEvolvingShipNodeId( nodeName )
		if nodeId ~= -1 then

			local bFit = true

			if bFit then
				if UI:BitTstU64( unlockedMask, nodeId ) then
					bFit = false
				end
			end

			if bFit then
				if node.rank > unlockedRank then
					bFit = false
				end
			end

			if bFit then

				if node.parent then

			    	local bParentLearned = false

            		local parentNodeId = UI:GetEvolvingShipNodeId( node.parent.name )
            		if parentNodeId ~= -1 then
						bParentLearned = UI:BitTstU64( unlockedMask, parentNodeId )
					else
						sys.log( "UI.EquipmentShipUpgrade_AlienInfo:GetNextNode()[ERROR]: invalid nodeId for node \"%s\"", node.parent.name )
					end

					if not bParentLearned then
						bFit = false
					end					

				end

			end

			if bFit then
				if UI:CantBeBoughtEvolvingShipNode( nodeName ) then
					bFit = false
				end
			end

			if bFit then
				if UI:IsEvolvingShipNodeHidden( nodeName, true, self.shipItem.defName, nodes ) then
					bFit = false
				end
			end

			if bFit then
				table.insert( availableNodes, node )
			end

		else
			sys.log( "UI.EquipmentShipUpgrade_AlienInfo:GetNextNode()[ERROR]: invalid nodeId for node \"%s\"", nodeName )
		end

	end

	if not next( availableNodes ) then
		sys.log( "UI.EquipmentShipUpgrade_AlienInfo:GetNextNode()[ERROR]: no available nodes" )
		return nil
	end


	-- из всех доступных для изучения нодов выбирается один, по критериям:  
	-- 1) хватает всех ресурсов для изучения
	-- 2) наименьшая стоимость в синергии

	local infoByNode = {}

	for nodeIdx, node in pairs( availableNodes ) do

		local synergyPrice	= 0
		local bEnable		= true

		local prices = UI:GetEvolvingShipNodePrice( node.name, self.shipItem.defName )

		for priceIdx, price in pairs( prices ) do

			if price.priceType == UI.shipNodePriceTypes.SYNERGY then
				synergyPrice = price.val
			end

			if bEnable then

        		local bEnough = false

        		if price.priceType == UI.shipNodePriceTypes.CREDITS then
        			bEnough = price.val <= UI:GetPlayerCredits()

        		elseif price.priceType == UI.shipNodePriceTypes.TOKENS then
        			bEnough = price.val <= UI:GetPlayerTokens()

        		elseif price.priceType == UI.shipNodePriceTypes.SYNERGY then
        			bEnough = price.val <= ( self.shipItem and UI:GetShipExp( self.shipItem ) or 0 ) + UI:GetPlayerFreeSynergy()

        		elseif price.priceType == UI.shipNodePriceTypes.ITEM then

        			if UI:IsDefResource( price.defName ) then
        				bEnough = price.count <= UI:GetPlayerResourceCount( price.defName )
        			else
        				sys.log( "UI.EquipmentShipUpgrade_AlienInfo:GetNextNode()[ERROR]: \"%s\" is not a resource", price.defName )
        			end

        		else
        			sys.log( "UI.EquipmentShipUpgrade_AlienInfo:GetNextNode()[ERROR]: unhandled ship node learn price type: %d", price.priceType )
        		end

        		if not bEnough then
        			bEnable = false
        		end

			end

		end

		if bEnable then

			local quests = UI:GetEvolvingShipNodeRequiredQuests( node.name )

        	for questIdx, questId in pairs( quests ) do
        		if not UI:IsQuestCompleted( questId ) then
        			bEnable = false
        			break
        		end
        	end

		end

		infoByNode[ node.name ] =
		{
			synergyPrice	= synergyPrice,
			bEnable			= bEnable,
		}

	end

	local function fnSort( node1, node2 ) 

		local info1 = infoByNode[ node1.name ]
		local info2 = infoByNode[ node2.name ]

		if info1.bEnable ~= info2.bEnable then
			return info1.bEnable
		end

		if info1.synergyPrice ~= info2.synergyPrice then
			return info1.synergyPrice < info2.synergyPrice
		end

		return node1.nodeInfo.nodeId > node2.nodeInfo.nodeId

	end

	table.sort( availableNodes, fnSort )


	local nextNode		= availableNodes[ 1 ]
	local nextNodeInfo	= infoByNode[ nextNode.name ]

	return nextNode, nextNodeInfo

end


-- -------------------------------------------------------------------
-- UI.EquipmentShipUpgrade_OpenAlienEditBtn
-- -------------------------------------------------------------------

UI.EquipmentShipUpgrade_OpenAlienEditBtn = {}

-- --------------------------------
-- window definition
-- --------------------------------

UI.EquipmentShipUpgrade_OpenAlienEditBtn.def =
{
	className	= "ButtonWnd",
	prototype	= "EffectCheckBoxWnd",

	props =
	{
		name	= "EquipmentShipUpgrade_OpenAlienEditBtn",
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
				defName 			= "equipment_ship_upgrade_openAlienEditBtn",
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

-- --------------------------------
-- interface functions
-- --------------------------------

--
function UI.EquipmentShipUpgrade_OpenAlienEditBtn:GetTooltipData()

	return self.tooltipData

end


--
function UI.EquipmentShipUpgrade_OpenAlienEditBtn:SetTooltipData( tooltipData )

	self.tooltipData = tooltipData

end


-- --------------------------------
-- const
-- --------------------------------

UI.EquipmentShipUpgrade_OpenAlienEditBtn.effectInfo =
{
	main_unchecked =	-- красный
	{
		animationIdle 		= "idle_2",
		animationSelect		= "over_2",
		animationPressed	= "over_2",
		animationDisabled	= "idle_2",
	},

	main_checked = 		-- зеленый
	{
		animationIdle 		= "idle",
		animationSelect		= "over",
		animationPressed	= "over",
		animationDisabled	= "idle",
	},
}

-- --------------------------------
-- vars
-- --------------------------------

UI.EquipmentShipUpgrade_OpenAlienEditBtn.tooltipData = nil


-- ------------------------------------------------------------
-- UI.Equipment_BuyWithInventoryWnd
-- ------------------------------------------------------------

UI.Equipment_BuyWithInventoryWnd =
{
    def =
    {
    	className 	= "Wnd",
    	prototype	= "BuyWithInventoryWnd",

    	props =
    	{
    		name	= "Equipment_BuyWithInventoryWnd",
    	},
	},

	mainWndName = "EquipmentWnd",
}

-- -----------------------------------------------------------
-- UI.EquipmentShipInfoWnd
-- -----------------------------------------------------------

UI.EquipmentShipInfoWnd =
{
	def =
	{
		className	= "Wnd",
		prototype	= "HangarShipInfoWnd",
		
		props =
		{
			name	= "EquipmentShipInfoWnd"
		}
	}
}

-- -----------------------------------------------------------
-- UI.EquipmentShipMainParamsWnd
-- -----------------------------------------------------------

UI.EquipmentShipMainParamsWnd =
{
	def =
	{
		className	= "Wnd",
		prototype	= "HangarShipMainParamsWnd",
		
		props =
		{
			name	= "EquipmentShipMainParamsWnd"
		}
	}
}

-- -----------------------------------------------------------
-- UI.EquipmentShipSurvivabilityWnd
-- -----------------------------------------------------------

UI.EquipmentShipSurvivabilityWnd =
{
	def =
	{
		className	= "Wnd",
		prototype	= "HangarShipSurvivabilityWnd",
		
		props =
		{
			name	= "EquipmentShipSurvivabilityWnd"
		}
	}
}

-- -----------------------------------------------------------
-- UI.EquipmentShipParamsWnd
-- -----------------------------------------------------------

UI.EquipmentShipParamsWnd = {}

-- ------------------------------
-- window definition
-- ------------------------------

UI.EquipmentShipParamsWnd.def =
{
	className	= "Wnd",
	prototype	= "HangarShipParamsWnd",
	
	props =
	{
		name	= "EquipmentShipParamsWnd"
	}
}

-- ------------------------------
-- work functions
-- ------------------------------

-- перегрузка базовой функции, чтобы не до нижнего края экрана, а до автоген-слотов
function UI.EquipmentShipParamsWnd:CalcBottom()

	return UI.EquipmentWnd:GetShipParamsBottom()
	
end