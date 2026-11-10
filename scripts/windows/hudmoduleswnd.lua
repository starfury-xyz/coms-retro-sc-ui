-- ----------------------------------------------------------------------------
--
-- Workfile: hudmodules.lua
-- Copyright й 2006, Targem LLC. All rights reserved.
--
-- ----------------------------------------------------------------------------
--  $Id:  $
-- ----------------------------------------------------------------------------

local resolution = UI:GetCoordinateSystemForAspect( UI.screenHeight / UI.screenWidth )

UI.HudModulesWnd = {}
local hm = UI.HudModulesWnd

-- ------------------------------
-- window definition
-- ------------------------------

UI.HudModulesWnd.def =
{
	className	= "Wnd",

	props =
	{
		name	= "HudModulesWnd",
		style	= UI.WS_NOT_MOUSE_REACT + UI.WS_NOT_KB_REACT + UI.WS_UPDATE_IF_VISIBLE,
		rectAbs	= Quat( 0, 0, 1024, 768 ),
	},
}

-- ------------------------------
-- interface functions
-- ------------------------------

--
function UI.HudModulesWnd:OnPhaseModulePhaseChanged( playerIdx, moduleSlotId, phase )

	if not self:IsOnScreen() then
		return
	end

	if playerIdx ~= _G.GetSpectatorTargetIdx() then
		return
	end

	local myShip = UI.HudWnd.myShip
	if not myShip then
		return
	end

	if moduleSlotId == ai.SpaceShipModuleSlot.SPECIAL then

		local module = self.specModuleData and self.specModuleData.module
		if module and self.specModuleSlot and self.specModuleSlot:IsChildOf( self ) then
        	self:UpdateModuleIco( moduleSlotId, module, myShip, self.specModuleSlot )
		end

	else
		
		local slotIdx = -1
		for _slotIdx, _slotWnd in pairs( self.activeModulesSlots ) do
			local data = _slotWnd:GetData()
			if data and data.moduleSlotId == moduleSlotId then
				slotIdx = _slotIdx
				break
			end
		end
		
		if slotIdx ~= -1 then

			local module	= self.activeModulesData[ slotIdx ] and self.activeModulesData[ slotIdx ].module
			local slotWnd	= self.activeModulesSlots[ slotIdx ]

			if module and slotWnd then
				self:UpdateModuleIco( moduleSlotId, module, myShip, slotWnd )
			end
			
		end

	end

end


--
function UI.HudModulesWnd:OnBindsChanged()

	if not self:IsOnScreen() then
		return
	end

	self:Reset()
	self:FullUpdate()	

end


--
function UI.HudModulesWnd:OnBattleStationModuleStateChanged()

	if not self:IsOnScreen() then
		return
	end

	local myShip = UI.HudWnd.myShip
	if not myShip then
		return
	end

	local moduleSlotId	= -1
	local module		= nil
	local slotWnd		= nil

	for slotIdx, slotData in pairs( self.activeModulesData ) do
		
		if slotData.module then

        	local defName = slotData.module:GetDefName() 
        	local def = UI:GetDef( defName )

        	if def.class == "BattleStationModule" then

				moduleSlotId	= ai.SpaceShipModuleSlot.ACTIVE_01 + slotIdx - 1
				module			= slotData.module
				slotWnd			= self.activeModulesSlots[ slotIdx ]

				break

			end

		end

	end

	if module and slotWnd then
		self:UpdateModuleIco( moduleSlotId, module, myShip, slotWnd )
	end

end


--
function UI.HudModulesWnd:SetWeaponPos( pos )

	self.weaponSlot:SetPos( pos.x, pos.y )
	self:UpdateZOrder()
	
end


--
function UI.HudModulesWnd:SetRocketsPos( pos )

	self.rocketsSlot:SetPos( pos.x, pos.y )
	self:UpdateZOrder()
	
end


--
function UI.HudModulesWnd:SetActiveModulesPos( pos )
	
	local slotWidth = self.activeModulesSlots[ 1 ]:GetWidth()
	
	for slotIdx, slotWnd in pairs( self.activeModulesSlots ) do
		local x = pos.x + ( slotWidth + self.space_activeModules ) * ( slotIdx - 1 )
		slotWnd:SetPos( x, pos.y )
	end
	
	self:UpdateZOrder()
	
end


--
function UI.HudModulesWnd:SetPassiveModulesPos( pos )
	
	local slotWidth = self.passiveModulesSlots[ 1 ]:GetWidth()
	
	for slotIdx, slotWnd in pairs( self.passiveModulesSlots ) do
		local x = pos.x + ( slotWidth + self.space_passiveModules ) * ( slotIdx - 1 )
		slotWnd:SetPos( x, pos.y )
	end
	
	self:UpdateZOrder()
	
end


--
function UI.HudModulesWnd:SetSpecModulePos( pos )

	self.specModuleSlot:SetPos( pos.x, pos.y )
	self:UpdateZOrder()
	
end


--
function UI.HudModulesWnd:SetWeaponVisible( bVisible )

	if bVisible == self.bWeaponVisible then
		return
	end

	self.bWeaponVisible = bVisible
	
	if self:IsOnScreen() then
	
		if bVisible then
			self:Reset()
			self:FullUpdate()
		else
			self.weaponSlot:Reset()
			self.weaponSlot:UnlinkFromParent()
			self.weaponData = nil
		end
		
	end
	
end


--
function UI.HudModulesWnd:SetRocketsVisible( bVisible )

	if bVisible == self.bRocketsVisible then
		return
	end

	self.bRocketsVisible = bVisible
	
	if self:IsOnScreen() then
	
		if bVisible then
			self:Reset()
			self:FullUpdate()
		else
			self.rocketsSlot:Reset()
			self.rocketsSlot:UnlinkFromParent()
			self.rocketsData = nil
		end
		
	end

end


--
function UI.HudModulesWnd:SetActiveModulesVisible( bVisible )

	if bVisible == self.bActiveModulesVisible then
		return
	end
	
	self.bActiveModulesVisible = bVisible
	
	if self:IsOnScreen() then
	
		if bVisible then
			self:Reset()
			self:FullUpdate()
		else
			for moduleIdx, moduleSlot in pairs( self.activeModulesSlots ) do
				if moduleSlot:IsChildOf( self ) then
					moduleSlot:Reset()
					moduleSlot:UnlinkFromParent()
				end
			end
			self.activeModulesData = {}
		end
		
	end

end


--
function UI.HudModulesWnd:SetPassiveModulesVisible( bVisible )

	self:UpdatePassiveModuleVisibility()

end


--
function UI.HudModulesWnd:SetSpecModuleVisible( bVisible )

	if bVisible == self.bSpecModuleVisible then
		return
	end

	self.bSpecModuleVisible = bVisible
	
	if self:IsOnScreen() then
	
		if bVisible then
			self:Reset()
			self:FullUpdate()
		else
			self.specModuleSlot:Reset()
			self.specModuleSlot:UnlinkFromParent()
			self.specModuleData = nil
		end
		
	end
	
end


--
function UI.HudModulesWnd:F_OnEventHudCargoModeChanged( hSender, iParam0, iParam1, fParam0, fParam1 )

	self:UpdatePassiveModuleVisibility()

end


--
function UI.HudModulesWnd:F_OnEventWndHided( hSender, hWnd )

	if UI.HudCargoWnd and UI.HudCargoWnd.w and hWnd == UI.HudCargoWnd:GetUiHandle() then
		self:UpdatePassiveModuleVisibility()
	end

end


--
function UI.HudModulesWnd:F_OnEventWndShown( hSender, hWnd )

	if UI.HudCargoWnd and UI.HudCargoWnd.w and hWnd == UI.HudCargoWnd:GetUiHandle() then
		self:UpdatePassiveModuleVisibility()
	end

end


--
function UI.HudModulesWnd:ModuleChanged( slotId )

	if not self:IsOnScreen() then
		return
	end
	
	self:Reset()
	self:FullUpdate()

end


-- ------------------------------
-- const
-- ------------------------------

hm.effectInfo =
{
	effectName					= "modules_main",
	activeModulePrefix			= "modul_",
	passivModulePrefix_first	= "missle_2",
	passivModulePrefix_second	= "missle_3",
}

-- ------------------------------
-- vars
-- ------------------------------

hm.myShipId					= -1
hm.selWeaponModIdx			= -1
hm.weaponSlot				= nil
hm.rocketsSlot				= nil
hm.activeModulesSlots		= {}
hm.passiveModulesSlots		= {}
hm.specModuleSlot			= nil
hm.weaponData				= nil
hm.rocketsData				= nil
hm.activeModulesData		= {}
hm.passiveModulesData		= {}
hm.specModuleData			= nil
hm.bWeaponVisible			= true
hm.bRocketsVisible			= true
hm.bActiveModulesVisible	= true
hm.bPassiveModulesVisible	= true
hm.bSpecModuleVisible		= true
hm.space_activeModules		= 0
hm.space_passiveModules		= 0

-- ------------------------------
-- work functions
-- ------------------------------

--
function UI.HudModulesWnd:F_PostLoad()

	UI.Wnd.F_PostLoad( self )

	self:CreateSlots()
	self:PrepareLayout()
	
	local handle = self:GetUiHandle()
	UI:SubscribeUiObjOnEvent( handle, UI.EV_HUD_CARGO_MODE_CHANGED )
	UI:SubscribeUiObjOnEvent( handle, UI.EV_WND_HIDED )
	UI:SubscribeUiObjOnEvent( handle, UI.EV_WND_SHOWN )
	UI:SubscribeUiObjOnEvent( handle, UI.EV_LIST_ACTIVATE_RECORD )

end


--
function UI.HudModulesWnd:CreateSlots()

	self.weaponSlot		= UI:CreateChildWnd( self, UI.Modules_SlotWnd, "weapon" )
	self.rocketsSlot	= UI:CreateChildWnd( self, UI.Modules_SlotWnd, "rockets" )
	self.specModuleSlot	= UI:CreateChildWnd( self, UI.Modules_SpecialSlotWnd, "" )
	self.specModuleSlot.cooldownClockLayout = UI.Modules_SlotWnd.COOLDOWN_CLOCK_LAYOUTS.special	-- [MOD cooldown-clock]
	self.specModuleSlot.useCooldownClock = true
	self.rocketsSlot.useCooldownClock = true
	
	--на момент вызова этой функции ai.SpaceShipModuleSlot еще не загружен, поэтому просто захардкоданные константы количества модулей
	for moduleIdx = 1, 4 do	-- ACTIVE_01..04
		self.activeModulesSlots[ moduleIdx ] = UI:CreateChildWnd( self, UI.Modules_SlotWnd, string.format( "active_%d", moduleIdx ) )
		self.activeModulesSlots[ moduleIdx ].useCooldownClock = true	-- [MOD cooldown-clock]
	end
	
	for moduleIdx = 1, 15 do	-- ENGINE_MOD_01..03, CAPACITOR_MOD_01..03, SHIELD_MOD_01..03, ARMOR_MOD_01..03, CPU_MOD_01..03
		self.passiveModulesSlots[ moduleIdx ] = UI:CreateChildWnd( self, UI.Modules_SlotWnd, string.format( "passive_%d", moduleIdx ) )
	end

end


--
function UI.HudModulesWnd:PrepareLayout()

	local modulesEffect = _G.UI_SpawnEffect( self.effectInfo.effectName, self:GetUiHandle() )
	if modulesEffect then
	
		local firstActiveModulePos		= modulesEffect:GetObjPos( string.format( "%s%d", self.effectInfo.activeModulePrefix, 1 ) )
		local secondActiveModulePos		= modulesEffect:GetObjPos( string.format( "%s%d", self.effectInfo.activeModulePrefix, 2 ) )
		local firstPassiveModulePos		= modulesEffect:GetObjPos( self.effectInfo.passivModulePrefix_first )
		local secondPassiveModulePos	= modulesEffect:GetObjPos( self.effectInfo.passivModulePrefix_second )
		local slotWidth					= self.activeModulesSlots[ 1 ]:GetWidth()
		
		self.space_activeModules	= secondActiveModulePos.x - ( firstActiveModulePos.x + slotWidth )
		self.space_passiveModules	= secondPassiveModulePos.x - ( firstPassiveModulePos.x + slotWidth )
	
		_G.UI_DestroyEffect( modulesEffect )
		
	end

end


--
function UI.HudModulesWnd:F_OnNewFrame( hSender, dt_sys, dt_game )

	self:FullUpdate()

end


--
function UI.HudModulesWnd:F_OnAfterShowOnScreen()

	self:OnAfterShowOnScreen()

	self:Reset()

end


--
function UI.HudModulesWnd:Reset()

	if self.weaponSlot:IsChildOf( self ) then
		self.weaponSlot:Reset()
		self.weaponSlot:UnlinkFromParent()
	end
	
	if self.rocketsSlot:IsChildOf( self ) then
		self.rocketsSlot:Reset()
		self.rocketsSlot:UnlinkFromParent()
	end
	
	if self.specModuleSlot:IsChildOf( self ) then
		self.specModuleSlot:Reset()
		self.specModuleSlot:UnlinkFromParent()
	end
	
	for moduleIdx, moduleSlot in pairs( self.activeModulesSlots ) do
		if moduleSlot:IsChildOf( self ) then
			moduleSlot:Reset()
			moduleSlot:UnlinkFromParent()
		end
	end
	
	for moduleIdx, moduleSlot in pairs( self.passiveModulesSlots ) do
		if moduleSlot:IsChildOf( self ) then
			moduleSlot:Reset()
			moduleSlot:UnlinkFromParent()
		end
	end

	self.myShipId			= -1
	self.selWeaponModIdx	= -1
	self.rocketsData		= nil
	self.activeModulesData	= {}
	self.passiveModulesData	= {}
	self.weaponData			= nil
	self.specModuleData		= nil

end


--
function UI.HudModulesWnd:FullUpdate()

	local myShip = UI.HudWnd.myShip
	local myShipId = myShip and myShip:GetId() or -1

	local bShipChanged = false

	if self.myShipId ~= myShipId then
		self:Reset()
		self.myShipId = myShipId
		bShipChanged = true
	end

	if self.myShipId == -1 then
		return
	end

	if self.bWeaponVisible then
		self:UpdateWeapon( myShip, bShipChanged )
	end
	
	if self.bRocketsVisible then
		self:UpdateRockets( myShip, bShipChanged )
	end
	
	if self.bActiveModulesVisible then
		self:UpdateActiveModules( myShip, bShipChanged )
	end
	
	if self.bPassiveModulesVisible then
		self:UpdatePassiveModules( myShip, bShipChanged )
	end
	
	if self.bSpecModuleVisible then
		self:UpdateSpecialModule( myShip, bShipChanged )
	end

end


--
function UI.HudModulesWnd:UpdateWeapon( myShip, bShipChanged )

	if bShipChanged then
		self:AddChild( self.weaponSlot )
		self.weaponSlot:SetData( { moduleSlotId = ai.SpaceShipModuleSlot.PRIMARY_WEAPON_01 } )
	end
	
	local bModuleChanged = bShipChanged
	if not bModuleChanged then
		if self.weaponData and self.weaponData.moduleId and self.weaponData.moduleId ~= -1 then
			if not _G.IsEntIdValid( self.weaponData.moduleId ) then
				bModuleChanged = true
			end
		end
	end
	
	if bModuleChanged then
	
		local module = myShip:GetModule( ai.SpaceShipModuleSlot.PRIMARY_WEAPON_01 )
		if module then
		
			self.weaponData = {}
			self.weaponData.module = module
			self.weaponData.moduleId = module:GetId()

			local moduleDefName = module:GetDefName()
    		local def = UI:GetDef( moduleDefName )
			
			self.weaponData.bAllowCooldown = def.show_cooldown

			-- иконка
	
			self.weaponSlot:ShowIco( moduleDefName )
			self.weaponSlot:AnimateIcoActive()
	
			local color = UI:GetItemColor( moduleDefName )
			local bEnchanted = myShip:IsModuleEnchanted( ai.SpaceShipModuleSlot.PRIMARY_WEAPON_01 )
			self.weaponSlot:ShowColorBg2( color, bEnchanted )	
			self.weaponSlot:ShowInfluenceColor( UI:GetItemInfluenceColor( moduleDefName ) )

			-- тултип
	
			local tooltipData			= {}
			tooltipData.tooltipType		= UI.tooltipTypes.MODULE
			tooltipData.defName			= moduleDefName
			tooltipData.dstShipData		= UI.ModuleTooltipWnd.ShipData:CreateForEntity( myShip:GetId(), ai.SpaceShipModuleSlot.PRIMARY_WEAPON_01 )
			tooltipData.bEnchanted		= bEnchanted	
			
			self.weaponSlot:SetTooltipData( tooltipData )
			
			self.weaponSlot:SetKey( UI:GetModuleKey( ai.SpaceShipModuleSlot.PRIMARY_WEAPON_01 ) )
			self.weaponSlot:ShowKey()
			
		-- пустой слот, без оружия (такого не может быть)
		else
		
			self.weaponData = nil
			self.weaponSlot:SetEmpty()
			
			self.weaponSlot:SetKey( UI:GetModuleKey( ai.SpaceShipModuleSlot.PRIMARY_WEAPON_01 ) )
			self.weaponSlot:ShowKey()
			self.weaponSlot:AnimateKeyInactive()
			
		end
		
	end

	if self.weaponData then

		-- кулдаун

		local cooldownVal = 0

		if self.weaponData.bAllowCooldown then
			cooldownVal = myShip:GetWeaponShotTimeout()
		end

		if cooldownVal ~= self.weaponData.cooldownVal then

			local fixedCooldownVal		= cooldownVal > 0 and math.ceil( cooldownVal ) or -1
			local fixedCooldownVal_old	= ( self.weaponData.cooldownVal and self.weaponData.cooldownVal > 0 ) and math.ceil( self.weaponData.cooldownVal ) or -1

			if fixedCooldownVal ~= fixedCooldownVal_old then

				if fixedCooldownVal ~= -1 then
					self.weaponSlot:ShowCooldownTime( fixedCooldownVal )	-- сравнивается на -1, а не на 0, т.к. 0, который был получен в результате округления во время кулдауна, может отображаться
				else
					self.weaponSlot:HideCooldownTime()
					self.weaponSlot:ShowFlash()
            	end

			end

		end

		-- затемнение

		local bAnimIcoInactive = cooldownVal > 0
		if bAnimIcoInactive ~= self.weaponData.bAnimIcoInactive then
	
			if bAnimIcoInactive then
				self.weaponSlot:AnimateIcoInactive()
			else
				self.weaponSlot:AnimateIcoActive()
			end
	
		end
		
		-- количество зарядов

		local ammo = self.weaponData.module:GetAmmo()
		if ammo ~= self.weaponData.ammo then

			if ammo ~= -1 then
				self.weaponSlot:ShowAmmoCount( ammo )
			else
				self.weaponSlot:HideAmmoCount()
			end

		end

		-- уничтоженное состояние

		local bDead = self.weaponData.module:IsDead()
		if bDead ~= self.weaponData.bDead then

			if bDead then
				self.weaponSlot:ShowDestroyed()
			else
				self.weaponSlot:HideDestroyed()
			end

		end

		self.weaponData.cooldownVal			= cooldownVal
		self.weaponData.bDead				= bDead
		self.weaponData.bAnimIcoInactive	= bAnimIcoInactive
		self.weaponData.ammo				= ammo

	end

end


--
function UI.HudModulesWnd:UpdateRockets( myShip, bShipChanged )

	if bShipChanged then
	
		self:AddChild( self.rocketsSlot )
		self.rocketsSlot:SetData( { munitionSlotId = ai.MunitionBayType.MBT_SECONDARY } )

		local ammoDefName = myShip:GetMunitionDefName( ai.MunitionBayType.MBT_SECONDARY )
		if not UI:IsStrEmpty( ammoDefName ) then
		
			self.rocketsData = {}
			self.rocketsData.rocketLauncherModule = myShip:GetModule( ai.SpaceShipModuleSlot.SECONDARY_WEAPON )
			
			-- иконка

			self.rocketsSlot:ShowIco( ammoDefName )

			local color = UI:GetItemColor( ammoDefName )
			self.rocketsSlot:ShowColorBg2( color, false )	
			self.rocketsSlot:ShowInfluenceColor( UI:GetItemInfluenceColor( ammoDefName ) )
			
			-- тултип

			local tooltipData			= {}
			tooltipData.tooltipType		= UI.tooltipTypes.MODULE
			tooltipData.defName			= ammoDefName
			tooltipData.dstShipData		= UI.ModuleTooltipWnd.ShipData:CreateForEntity( myShip:GetId(), ai.MunitionBayType.MBT_SECONDARY )
			
			self.rocketsSlot:SetTooltipData( tooltipData )
			
			self.rocketsSlot:SetKey( UI:GetModuleKey( ai.SpaceShipModuleSlot.SECONDARY_WEAPON ) )
			self.rocketsSlot:ShowKey()
			
		-- пустой слот, без ракет
		else
			self.rocketsSlot:SetEmpty()
			
			self.rocketsSlot:SetKey( UI:GetModuleKey( ai.SpaceShipModuleSlot.SECONDARY_WEAPON ) )
			self.rocketsSlot:ShowKey()
			self.rocketsSlot:AnimateKeyInactive()
		end

	end

	if self.rocketsData then

		local ammo = myShip:GetRocketAmmoLeft( ai.MunitionBayType.MBT_SECONDARY )	-- slot id сейчас здесь реально не используется
		local rocketLauncherModule = self.rocketsData.rocketLauncherModule

		-- main animation

		local bAnimIcoInactive = ammo == 0 or ( not rocketLauncherModule or not rocketLauncherModule:CanBeActivated() )
		if bAnimIcoInactive ~= self.rocketsData.bAnimIcoInactive then

			if bAnimIcoInactive then
				self.rocketsSlot:AnimateIcoInactive()
			else
				self.rocketsSlot:AnimateIcoActive()
			end

		end

		-- cooldown

		local cooldownMax = myShip:GetRocketCooldown( ai.MunitionBayType.MBT_SECONDARY )
		local cooldownVal = myShip:GetRocketCooldownLeft( ai.MunitionBayType.MBT_SECONDARY ) or 0

		if cooldownVal ~= self.rocketsData.cooldownVal then

			local fixedCooldownVal		= cooldownVal > 0 and math.ceil( cooldownVal ) or -1
			local fixedCooldownVal_old	= ( self.rocketsData.cooldownVal and self.rocketsData.cooldownVal > 0 ) and math.ceil( self.rocketsData.cooldownVal ) or -1

			if fixedCooldownVal ~= fixedCooldownVal_old then

				if fixedCooldownVal ~= -1 then	-- сравнивается на -1, а не на 0, т.к. 0, который был получен в результате округления во время кулдауна, может отображаться
					self.rocketsSlot:ShowCooldownTime( fixedCooldownVal )
				else
					self.rocketsSlot:HideCooldownTime()
					self.rocketsSlot:ShowFlash()
				end

			end

		end

		self:UpdateCooldownClock( self.rocketsSlot, self.rocketsData, nil, cooldownVal, cooldownMax )	-- [MOD cooldown-clock]

		-- количество ракет

		if self.rocketsData.ammo ~= ammo then
			self.rocketsSlot:ShowAmmoCount( ammo )
		end

		-- перезарядка

		local reloadVal = 0

		if cooldownVal > 0 and ammo == 0 then	-- перезарядка - это кулдаун, когда нет ракет
			reloadVal = cooldownMax ~= 0 and cooldownVal / cooldownMax or 0
		end

		if reloadVal ~= self.rocketsData.reloadVal then

			if reloadVal > 0 then
				self.rocketsSlot:ShowAmmoReload( reloadVal )
			else
				self.rocketsSlot:HideAmmoReload()
			end

		end

		-- уничтоженное состояние

		local bDead = rocketLauncherModule ~= nil and rocketLauncherModule:IsDead()
		if bDead ~= self.rocketsData.bDead then

			if bDead then
				self.rocketsSlot:ShowDestroyed()
			else
				self.rocketsSlot:HideDestroyed()
			end

		end

		self.rocketsData.bAnimIcoInactive	= bAnimIcoInactive
		self.rocketsData.ammo				= ammo
		self.rocketsData.reloadVal			= reloadVal
		self.rocketsData.cooldownVal		= cooldownVal
		self.rocketsData.bDead				= bDead
		self.rocketsData.reloadVal			= reloadVal
		
	end

end


--
function UI.HudModulesWnd:UpdateActiveModules( myShip, bShipChanged )
	
	if bShipChanged then
	
		local slotIdx = 1
	
		for moduleSlotId = ai.SpaceShipModuleSlot.ACTIVE_01, ai.SpaceShipModuleSlot.ACTIVE_04 do
		
			if UI:HasShipModuleSlotByEnt( myShip, moduleSlotId ) then

				local slotWnd = self.activeModulesSlots[ slotIdx ]
				self:AddChild( slotWnd )
				slotWnd:SetData( { moduleSlotId = moduleSlotId } )
				
				slotIdx = slotIdx + 1
				
			end
			
		end
		
	end
	
	for slotIdx, slotWnd in pairs( self.activeModulesSlots ) do
	
		local data = slotWnd:GetData()
		local moduleSlotId = data and data.moduleSlotId
		
		if moduleSlotId then
	
			local bModuleChanged = bShipChanged
			if not bModuleChanged then
				if self.activeModulesData[ slotIdx ] and self.activeModulesData[ slotIdx ].moduleId and self.activeModulesData[ slotIdx ].moduleId ~= -1 then
					if not _G.IsEntIdValid( self.activeModulesData[ slotIdx ].moduleId ) then
						bModuleChanged = true
					end
				end
			end
			
			if bModuleChanged then
				
				local module = myShip:GetModule( moduleSlotId )
				if module then
				
					self.activeModulesData[ slotIdx ] = {}
					self.activeModulesData[ slotIdx ].module = module
					self.activeModulesData[ slotIdx ].moduleId = module:GetId()

					local moduleDefName = module:GetDefName()
					
					-- иконка

					self:UpdateModuleIco( moduleSlotId, module, myShip, slotWnd )

					local color = UI:GetItemColor(  moduleDefName )
					local bEnchanted = myShip:IsModuleEnchanted( moduleSlotId )
					slotWnd:ShowColorBg2( color, bEnchanted )	
					slotWnd:ShowInfluenceColor( UI:GetItemInfluenceColor( moduleDefName ) )
					
					-- клавиша бинда активации

					slotWnd:SetKey( UI:GetModuleKey( moduleSlotId ) )
					slotWnd:ShowKey()
					
					-- тултип

					local tooltipData			= {}
					tooltipData.tooltipType		= UI.tooltipTypes.MODULE
					tooltipData.defName			= moduleDefName
					tooltipData.dstShipData		= UI.ModuleTooltipWnd.ShipData:CreateForEntity( myShip:GetId(), moduleSlotId )
					tooltipData.bEnchanted		= bEnchanted

					slotWnd:SetTooltipData( tooltipData )

				-- пустой слот без модуля
				else
				
					self.activeModulesData[ slotIdx ] = nil

					slotWnd:SetEmpty()
					
					-- клавиша бинда активации
					
					slotWnd:SetKey( UI:GetModuleKey( moduleSlotId ) )
					slotWnd:ShowKey()
					slotWnd:AnimateKeyInactive()

				end
				
			end
			
		end

	end
	
	
	for slotIdx, slotData in pairs( self.activeModulesData ) do
	
		local slotWnd = self.activeModulesSlots[ slotIdx ]
		if slotWnd then
		
			local module			= slotData.module
			local bActive			= module:IsActive()
			local bCanBeActivated	= module:CanBeActivated()

			-- main animation

			if bActive ~= slotData.bActive or bCanBeActivated ~= slotData.bCanBeActivated then

				if bActive then
					slotWnd:AnimateIcoSuperActive()
	
				elseif bCanBeActivated then
					slotWnd:AnimateIcoActive()
	
				else
					slotWnd:AnimateIcoInactive()
				end

			end

			-- cooldown

			local cooldownVal = module:GetUiCooldownLeft()
			if cooldownVal ~= slotData.cooldownVal then

				local fixedCooldownVal		= cooldownVal > 0 and math.ceil( cooldownVal ) or -1
				local fixedCooldownVal_old	= ( slotData.cooldownVal and slotData.cooldownVal > 0 ) and math.ceil( slotData.cooldownVal ) or -1

				if fixedCooldownVal ~= fixedCooldownVal_old then

					if fixedCooldownVal ~= -1 then	-- сравнивается на -1, а не на 0, т.к. 0, который был получен в результате округления во время кулдауна, может отображаться
						slotWnd:ShowCooldownTime( fixedCooldownVal )
					else
						slotWnd:HideCooldownTime()
						slotWnd:ShowFlash()
					end

				end

			end

			self:UpdateCooldownClock( slotWnd, slotData, module, cooldownVal )	-- [MOD cooldown-clock]

			-- key ico status

			if bCanBeActivated ~= slotData.bCanBeActivated then
	
				if bCanBeActivated then
					slotWnd:AnimateKeyActive()
				else
					slotWnd:AnimateKeyInactive()
				end

			end

			-- num targets under effect

			local numTargets = slotWnd:IsIcoInactive() and 0 or module:GetTargetCountHint()
			if numTargets ~= slotData.numTargets then

				if numTargets > 0 then
					slotWnd:ShowTargetsCount( numTargets )
				else
					slotWnd:HideTargetsCount()
				end

			end

			-- количество зарядов

			local ammo = module:GetAmmo()
			if ammo ~= slotData.ammo then

				if ammo ~= -1 then
    				slotWnd:ShowAmmoCount( ammo )
				else
					slotWnd:HideAmmoCount()
				end

			end

			-- перезарядка

			local reloadMax		= module:GetAmmoRegenTime()
			local reloadVal		= reloadMax ~= 0 and module:GetAmmoRegenTimeLeft() / reloadMax or 0

			if reloadVal ~= slotData.reloadVal then

				if reloadVal > 0 then
					slotWnd:ShowAmmoReload( reloadVal )
				else
					slotWnd:HideAmmoReload()
				end

			end

			-- уничтоженное состояние
	
			local bDead = module:IsDead()
			if bDead ~= slotData.bDead then
	
				if bDead then
					slotWnd:ShowDestroyed()
				else
					slotWnd:HideDestroyed()
				end
	
			end

			slotData.bActive			= bActive
			slotData.bCanBeActivated	= bCanBeActivated
			slotData.cooldownVal		= cooldownVal
			slotData.numTargets			= numTargets
			slotData.reloadVal			= reloadVal
			slotData.ammo				= ammo
			slotData.bDead				= bDead

		end

	end

end


--
function UI.HudModulesWnd:UpdatePassiveModules( myShip, bShipChanged )

	if bShipChanged then
	
		local slotIdx = 1
	
		for moduleSlotId = ai.SpaceShipModuleSlot.ENGINE_MOD_01, ai.SpaceShipModuleSlot.CPU_MOD_03 do
			
			if UI:HasShipModuleSlotByEnt( myShip, moduleSlotId ) then

				local slotWnd = self.passiveModulesSlots[ slotIdx ]
				self:AddChild( slotWnd )
				slotWnd:SetData( { moduleSlotId = moduleSlotId } )
				
				slotIdx = slotIdx + 1
				
			end
			
		end
		
	end
	
		
	for slotIdx, slotWnd in pairs( self.passiveModulesSlots ) do
	
		local data = slotWnd:GetData()
		local moduleSlotId = data and data.moduleSlotId
		
		if moduleSlotId then
	
			local bModuleChanged = bShipChanged
			if not bModuleChanged then
				if self.passiveModulesData[ slotIdx ] and self.passiveModulesData[ slotIdx ].moduleId and self.passiveModulesData[ slotIdx ].moduleId ~= -1 then
					if not _G.IsEntIdValid( self.passiveModulesData[ slotIdx ].moduleId ) then
						bModuleChanged = true
					end
				end
			end
			
			if bModuleChanged then
					
				local module = myShip:GetModule( moduleSlotId )
				if module then
				
					self.passiveModulesData[ slotIdx ] = {}
					self.passiveModulesData[ slotIdx ].module = module
					self.passiveModulesData[ slotIdx ].moduleId = module:GetId()

					local moduleDefName = module:GetDefName()
					
					-- иконка

					self:UpdateModuleIco( moduleSlotId, module, myShip, slotWnd )

					local color = UI:GetItemColor(  moduleDefName )
					local bEnchanted = myShip:IsModuleEnchanted( moduleSlotId )
					slotWnd:ShowColorBg2( color, bEnchanted )	
					slotWnd:ShowInfluenceColor( UI:GetItemInfluenceColor( moduleDefName ) )
					
					-- main animation
					self.specModuleSlot:AnimateIcoActive()
					
					-- тултип

					local tooltipData			= {}
					tooltipData.tooltipType		= UI.tooltipTypes.MODULE
					tooltipData.defName			= moduleDefName
					tooltipData.dstShipData		= UI.ModuleTooltipWnd.ShipData:CreateForEntity( myShip:GetId(), moduleSlotId )
					tooltipData.bEnchanted		= bEnchanted

					slotWnd:SetTooltipData( tooltipData )

				-- пустой слот без модуля
				else
				
					self.passiveModulesData[ slotIdx ] = nil
					slotWnd:SetEmpty()

				end

			end
			
		end

	end

end


--
function UI.HudModulesWnd:UpdatePassiveModuleVisibility()

	local bNeedVisilbe = 
		UI.HudEditor:IsWndVisible( "HudModulesWnd_passiveModules" )
		and _G.GetCurrentGameMode() == ai.Gameplay.BATTLE_ROYALE
		and UI.HudCargoWnd:IsChildOf( UI.HudWnd ) and UI.HudCargoWnd:GetMode() == UI.HudCargoWnd.modes.OPEN
	
	if bNeedVisilbe == self.bPassiveModulesVisible then
		return
	end
	
	self.bPassiveModulesVisible = bNeedVisilbe
	
	if self:IsOnScreen() then
	
		if bNeedVisilbe then
			self:Reset()
			self:FullUpdate()
		else
			for moduleIdx, moduleSlot in pairs( self.passiveModulesSlots ) do
				if moduleSlot:IsChildOf( self ) then
					moduleSlot:Reset()
					moduleSlot:UnlinkFromParent()
				end
			end
			self.passiveModulesData = {}
		end
		
	end

end


--
function UI.HudModulesWnd:UpdateSpecialModule( myShip, bShipChanged )

	if bShipChanged then	
		self:AddChild( self.specModuleSlot )
		self.specModuleSlot:SetData( { moduleSlotId = ai.SpaceShipModuleSlot.SPECIAL } )
	end
	
	local bModuleChanged = bShipChanged
	if not bModuleChanged then
	
		if self.specModuleData then
		
			if self.specModuleData.moduleId and self.specModuleData.moduleId ~= -1 then
				if not _G.IsEntIdValid( self.specModuleData.moduleId ) then
					bModuleChanged = true
				end
			end
			
			if self.specModuleData.capacitorModuleId and self.specModuleData.capacitorModuleId ~= -1 then
				if not _G.IsEntIdValid( self.specModuleData.capacitorModuleId ) then
					bModuleChanged = true
				end
			end

		end
		
	end
	
	if bModuleChanged then

		local module = myShip:GetModule( ai.SpaceShipModuleSlot.SPECIAL )
		if module then
		
			self.specModuleData					= {}
			self.specModuleData.module			= module
			self.specModuleData.moduleId		= module:GetId()
			
			self.specModuleData.capacitorModule	= myShip:GetModule( ai.SpaceShipModuleSlot.CAPACITOR )
			self.specModuleData.capacitorModuleId = self.specModuleData.capacitorModule and self.specModuleData.capacitorModule:GetId() or -1

			-- иконка

			self:UpdateModuleIco( ai.SpaceShipModuleSlot.SPECIAL, module, myShip, self.specModuleSlot )
			
			-- клавиша бинда активации

			self.specModuleSlot:SetKey( UI:GetModuleKey( ai.SpaceShipModuleSlot.SPECIAL ) )
			self.specModuleSlot:ShowKey()
			
			-- тултип

        	local tooltipData			= {}
        	tooltipData.tooltipType		= UI.tooltipTypes.MODULE
        	tooltipData.defName 		= module:GetDefName()
			tooltipData.dstShipData		= UI.ModuleTooltipWnd.ShipData:CreateForEntity( myShip:GetId(), ai.SpaceShipModuleSlot.SPECIAL )

    		self.specModuleSlot:SetTooltipData( tooltipData )
			
		-- пустой слот без модуля
		else
		
			self.specModuleData = nil

			self.specModuleSlot:SetEmpty()
			
			-- клавиша бинда активации
			
			self.specModuleSlot:SetKey( UI:GetModuleKey( ai.SpaceShipModuleSlot.SPECIAL ) )
			self.specModuleSlot:ShowKey()
			self.specModuleSlot:AnimateKeyInactive()

		end

	end

	if self.specModuleData then
	
		local module = self.specModuleData.module

		local bActive			= module:IsActive()
		local bCanBeActivated	= module:CanBeActivated()

		if bActive ~= self.specModuleData.bActive or bCanBeActivated ~= self.specModuleData.bCanBeActivated then

			-- main animation

			if bActive then
				self.specModuleSlot:AnimateIcoSuperActive()
	
			elseif bCanBeActivated then
				self.specModuleSlot:AnimateIcoActive()
	
			else
				self.specModuleSlot:AnimateIcoInactive()
			end
	
			-- key ico status

			if bCanBeActivated ~= self.specModuleData.bCanBeActivated then

				if bCanBeActivated then
					self.specModuleSlot:AnimateKeyActive()
				else
					self.specModuleSlot:AnimateKeyInactive()
				end
		
			end

		end

		-- cooldown

		local cooldownVal = module:GetUiCooldownLeft()
		if self.specModuleData.cooldownVal ~= cooldownVal then		

			local fixedCooldownVal		= cooldownVal > 0 and math.ceil( cooldownVal ) or -1
			local fixedCooldownVal_old	= ( self.specModuleData.cooldownVal and self.specModuleData.cooldownVal > 0 ) and math.ceil( self.specModuleData.cooldownVal ) or -1

			if fixedCooldownVal ~= fixedCooldownVal_old then

				if fixedCooldownVal ~= -1 then	-- сравнивается на -1, а не на 0, т.к. 0, который был получен в результате округления во время кулдауна, может отображаться
					self.specModuleSlot:ShowCooldownTime( fixedCooldownVal )
				else
					self.specModuleSlot:HideCooldownTime()
					self.specModuleSlot:ShowFlash()
				end

			end

		end

		self:UpdateCooldownClock( self.specModuleSlot, self.specModuleData, module, cooldownVal )	-- [MOD cooldown-clock]

		-- num targets under effect

		local numTargets = self.specModuleSlot:IsIcoInactive() and 0 or module:GetTargetCountHint()
		if numTargets ~= self.specModuleData.numTargets then

			if numTargets > 0 then
				self.specModuleSlot:ShowTargetsCount( numTargets )
			else
				self.specModuleSlot:HideTargetsCount()
			end
	
		end

		-- количество зарядов

		local ammo = module:GetAmmo()
		if ammo ~= self.specModuleData.ammo then

			if ammo ~= -1 then
				self.specModuleSlot:ShowAmmoCount( ammo )
			else
				self.specModuleSlot:HideAmmoCount()
			end

		end

		-- перезарядка

		local reloadMax		= module:GetAmmoRegenTime()
		local reloadVal		= reloadMax ~= 0 and module:GetAmmoRegenTimeLeft() / reloadMax or 0

		if reloadVal ~= self.specModuleData.reloadVal then

			if reloadVal > 0 then
				self.specModuleSlot:ShowAmmoReload( reloadVal )
			else
				self.specModuleSlot:HideAmmoReload()
			end

		end

		-- уничтоженное состояние

		local bDead = module:IsDead() or self.specModuleData.capacitorModule ~= nil and self.specModuleData.capacitorModule:IsDead()
		if bDead ~= self.specModuleData.bDead then

			if bDead then
				self.specModuleSlot:ShowDestroyed()
			else
				self.specModuleSlot:HideDestroyed()
			end

		end

		self.specModuleData.bActive			= bActive
		self.specModuleData.bCanBeActivated	= bCanBeActivated
		self.specModuleData.cooldownVal		= cooldownVal
		self.specModuleData.numTargets		= numTargets
		self.specModuleData.reloadVal			= reloadVal
		self.specModuleData.ammo				= ammo
		self.specModuleData.bDead				= bDead

	end

end


-- [MOD cooldown-clock] 
function UI.HudModulesWnd:UpdateCooldownClock( slotWnd, slotData, module, cooldownLeft, total )

	if not slotWnd or not slotData then
		return
	end

	if not cooldownLeft or cooldownLeft <= 0 then
		if slotData.cooldownTotal then
			slotData.cooldownTotal = nil
			slotWnd:HideCooldownClock()
			slotWnd:StartReadyFlash()
		end
		slotWnd:UpdateReadyFlash()
		return
	end

	if total and total > 0 then
		slotData.cooldownTotal = total
	end

	if not slotData.cooldownTotal and module then

		local ok, total = pcall( function() return module:GetUiCooldown() end )
		if not ok or type( total ) ~= "number" then
			total = 0
		end

		-- log the first few so the total can be checked in the game log
		self.cooldownClockLogCount = ( self.cooldownClockLogCount or 0 ) + 1
		if self.cooldownClockLogCount <= 5 then
			sys.log( "[cooldown-clock] %s: GetUiCooldown()=%s left=%.2f", tostring( module:GetDefName() ), tostring( ok and total or "ERROR" ), cooldownLeft )
		end

		slotData.cooldownTotal = total

	end

	if cooldownLeft > ( slotData.cooldownTotal or 0 ) then
		slotData.cooldownTotal = cooldownLeft
	end

	slotWnd:ShowCooldownClock( 1 - cooldownLeft / slotData.cooldownTotal )

end


--
function UI.HudModulesWnd:UpdateModuleIco( moduleSlotId, module, ship, slotWnd )

	if not module or not ship or not slotWnd then
		sys.log( "UI.HudModulesWnd:UpdateModuleIco()[ERROR]: invalid params" )
		return
	end

	local moduleDefName		= module:GetDefName()
	local buildingDefName	= self:GetBuildingModuleDefName( module )
	local defNameToShow		= buildingDefName ~= "" and buildingDefName or moduleDefName
	local phase				= ship:GetModulePhase( moduleSlotId ) 

	slotWnd:ShowIco( defNameToShow, phase )

end


--
function UI.HudModulesWnd:GetBuildingModuleDefName( module )

	local buildingDefName = ""

	local moduleDefName	= module:GetDefName() 
	local def = UI:GetDef( moduleDefName )

	if def.class == "BattleStationModule" then

		local upgradeLevel	= module:GetStationLevel()
		local buildingIdx	= module:GetStationBuildingIdx()

		if upgradeLevel ~= -1 and buildingIdx ~= -1 then

			upgradeLevel	= upgradeLevel + 1 + 1	-- нумерация в cpp c 0, также см. #0082396,комм.(0361587)
			buildingIdx		= buildingIdx + 1		-- нумерация в cpp c 0

			if type( def.station ) == "string" then

				local stationDefName	= def.station
    			local stationDef		= UI:GetDef( stationDefName )

				if stationDef then

					if type( stationDef.upgrades ) == "table" then

						if type( stationDef.upgrades[ upgradeLevel ] ) == "table" then

							local upgradeData = stationDef.upgrades[ upgradeLevel ]
							if type( upgradeData.modifications ) == "table" then

								if type( upgradeData.modifications[ buildingIdx ] ) == "table" then

									local modificationData = upgradeData.modifications[ buildingIdx ]

									if type( modificationData.def ) == "string" then
										buildingDefName = modificationData.def
									else
										sys.log( "UI.HudModulesWnd:GetBuildingModuleDefName()[ERROR]: invalid type of Def[\"%s\"].upgrades[%d].modifications[%d].def; \"string\" expected, got \"%s\"", stationDefName, upgradeLevel, buildingIdx, type( stationDef.upgrades[ upgradeLevel ].modifications[ buildingIdx ].def ) )
									end

								else
									sys.log( "UI.HudModulesWnd:GetBuildingModuleDefName()[ERROR]: invalid type of Def[\"%s\"].upgrades[%d].modifications[%d]; \"table\" expected, got \"%s\"", stationDefName, upgradeLevel, buildingIdx, type( stationDef.upgrades[ upgradeLevel ].modifications[ buildingIdx ] ) )
								end
							else
								sys.log( "UI.HudModulesWnd:GetBuildingModuleDefName()[ERROR]: invalid type of Def[\"%s\"].upgrades[%d].modifications; \"table\" expected, got \"%s\"", stationDefName, upgradeLevel, type( stationDef.upgrades[ upgradeLevel ].modifications ) )
							end
						else
							sys.log( "UI.HudModulesWnd:GetBuildingModuleDefName()[ERROR]: invalid type of Def[\"%s\"].upgrades[%d]; \"table\" expected, got \"%s\"", stationDefName, upgradeLevel, type( stationDef.upgrades[ upgradeLevel ] ) )
						end
					else
						sys.log( "UI.HudModulesWnd:GetBuildingModuleDefName()[ERROR]: invalid type of Def[\"%s\"].upgrades; \"table\" expected, got \"%s\"", stationDefName, type( stationDef.upgrades ) )
					end
				else
					sys.log( "UI.HudModulesWnd:GetBuildingModuleDefName()[ERROR]: cannot find Def[\"%s\"]", stationDefName )
				end
			else
				sys.log( "UI.HudModulesWnd:GetBuildingModuleDefName()[ERROR]: invalid type of Def[\"%s\"].station; \"string\" expected, got \"%s\"", moduleDefName, type( stationDefName ) )
			end

		end

--		sys.out( "^5def=\"%s\"; GetStationLevel()=%d; GetStationBuildingIdx()=%d; building def=\"%s\"", module:GetDefName(), module:GetStationLevel(), module:GetStationBuildingIdx(), buildingDefName )

	end

	return buildingDefName

end


--
function UI.HudModulesWnd:F_OnAfterAddChild( child )

	self:OnAfterAddChild( child )
	
	self:UpdateZOrder()

end


--
function UI.HudModulesWnd:UpdateZOrder()

	--#0108144 справа у слотов есть выступающий элемет (кружок с цифрой), который может налазить на соседние справа слоты,
	-- поэтому каждый слот справа рисуется в z-порядке ниже своего соседа слева
	-- (позиции слотов могут меняться в редакторе интерфейса)
	
	local slotsLeftToRight = {}
	
	local child = self:GetFirstChild()
	while child do
		table.insert( slotsLeftToRight, child )
		child = child:GetNextSibling()
	end
	
	local fnSort = function( slot1, slot2 )
		return slot1:GetLeft() < slot2:GetLeft()
	end
	
	table.sort( slotsLeftToRight, fnSort )
	
	for slotIdx, slotWnd in ipairs( slotsLeftToRight ) do
		self:MoveChildToFirstPosition( slotWnd )
	end

end


--
function UI.HudModulesWnd:F_OnMouseLButtonDown( mouseX, mouseY, wndThatReceivedInput )

	if _G.IsCursorHidden() then
		return true
	end

	if self:OnMouseLButtonDown( mouseX, mouseY, wndThatReceivedInput ) then
		return true
	end

	local wnd = UI:GetUiObjByHandleT( wndThatReceivedInput )

	if UI:IsWndKindOf( wnd, "Modules_SlotWnd" ) then
	
		if _G.GetCurrentGameMode() == ai.Gameplay.BATTLE_ROYALE then

			local playerId		= UI.HudWnd.localPlayerId
			local spectateId	= _G.GetSpectatorTargetIdx()
			local bIsSpectator	= playerId ~= spectateId

			if not bIsSpectator then
			
				local moduleSlotId = self:GetValidModuleIdForUnequip( wnd )
				if moduleSlotId ~= -1 then
					self:UnequipItem( moduleSlotId )
				end
				
			end
			
		end

	end

	return true

end


--
function UI.HudModulesWnd:F_OnMouseRButtonDown( mouseX, mouseY, wndThatReceivedInput )

	if _G.IsCursorHidden() then
		return true		
	end

	if self:OnMouseRButtonDown( mouseX, mouseY, wndThatReceivedInput ) then
		return true
	end

	local wnd = UI:GetUiObjByHandleT( wndThatReceivedInput )

	if UI:IsWndKindOf( wnd, "Modules_SlotWnd" ) then
	
		if _G.GetCurrentGameMode() == ai.Gameplay.BATTLE_ROYALE then

			local playerId		= UI.HudWnd.localPlayerId
			local spectateId	= _G.GetSpectatorTargetIdx()
			local bIsSpectator	= playerId ~= spectateId

			if not bIsSpectator then
				self:ShowPopUpMenuForItem( wnd )
			end
			
		end

	end

	return true

end


--
function UI.HudModulesWnd:F_OnEventListActivateRecord( hSender, iParam0, iParam1, fParam0, fParam1 )

	if not self:IsOnScreen() then
		return
	end

	if hSender == UI.PopUpMenuWnd:GetUiHandle() and UI.PopUpMenuWnd:GetOwner() == self:GetUiHandle() then

    	local menuType = UI.PopUpMenuWnd:GetMenuType()
    	if menuType == UI.popUpMenuTypes.LOOT then
    		self:OnPopUpMenu( iParam0 )
    	else
    		sys.log( "UI.HudModulesWnd:F_OnEventListActivateRecord()[ERROR]: unhandled pop-up menu type: \"%s\"", tostring( menuType ) )
    	end

	end

end  


--
function UI.HudModulesWnd:ShowPopUpMenuForItem( slotWnd )

	local moduleSlotId = self:GetValidModuleIdForUnequip( slotWnd )	
	if moduleSlotId == -1 then
		return
	end

	local unequipData = {}
	unequipData.slotType		= UI.popUpMenuSlotTypes.REMOVE_EQUIPPED_ITEM_HUD
	unequipData.moduleSlotId	= moduleSlotId
	unequipData.text			= UI:GetStringByName( "popUpMenu_unequipItem" )
	
	local module = UI.HudWnd.myShip:GetModule( moduleSlotId )
	local defName = module:GetDefName()
	
	UI.PopUpMenuWnd:Setup( self:GetUiHandle(), UI.popUpMenuTypes.LOOT, UI:GetEntityLocalizedNameByDef( defName, true, false, true ) )
	UI.PopUpMenuWnd:AddRecord( unequipData )

end


--
function UI.HudModulesWnd:OnPopUpMenu( recordIdx )

	local data = UI.PopUpMenuWnd:GetRecordData( recordIdx )
	if not data then
		sys.log( "UI.HudModulesWnd:OnPopUpMenu()[ERROR]: cannot find pop-up menu data for record %d", recordIdx )
		return
	end

	if data.slotType == UI.popUpMenuSlotTypes.REMOVE_EQUIPPED_ITEM_HUD then
		self:UnequipItem( data.moduleSlotId )
	end

end


--
function UI.HudModulesWnd:UnequipItem( moduleSlotId )

	_G.CL_RequestUnequipModule( moduleSlotId )

end


--
function UI.HudModulesWnd:GetValidModuleIdForUnequip( slotWnd )

	local moduleSlotId = -1
	
	local data = slotWnd:GetData()
	if data and data.moduleSlotId then
		moduleSlotId = data.moduleSlotId
	end
	
	if moduleSlotId ~= -1 then
		if moduleSlotId == ai.SpaceShipModuleSlot.SPECIAL or not UI.HudWnd.myShip or not UI.HudWnd.myShip:GetModule( moduleSlotId ) then
			moduleSlotId = -1
		end
	end
	
	return moduleSlotId

end