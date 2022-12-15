//---=== modFriendlyHUD ===---
enum EBuffsDisplayMode
{
	BDM_ShowPotions,
	BDM_ShowBombs,
	BDM_ShowOils,
	BDM_ShowBuffs
};

class CModRadialMenuPotions
{
	public var dirtyFlag		: bool; default dirtyFlag = 0;
	
	private var config			: CModFriendlyHUDConfig;
	private var buffsModule		: CR4HudModuleBuffs;
	private var playerInventory : CInventoryComponent;
	private var potionNames		: array< string >;
	private var potions			: array< SItemUniqueId >;
	private var bombNames		: array< string >;
	private var bombs			: array< SItemUniqueId >;
	private var oilNames		: array< string >;
	private var oils			: array< SItemUniqueId >;
	private var keyNames		: array< string >;
	private var mode			: EBuffsDisplayMode;
	private var padCurrent		: int; default padCurrent = 0;
	private var numItems		: int; default numItems = 0;
	private var disallowOilsInCombat, oilsHaveAmmo : bool;
	
	private function InitNames()
	{
		config.FillPotionNames( potionNames );
		config.FillBombNames( bombNames );
		config.FillOilNames( oilNames );
		config.FillKeyNames( keyNames );
	}
	
	public function SetDisplayMode( newMode : EBuffsDisplayMode )
	{
		if ( mode != newMode )
		{
			padCurrent = 0;
			mode = newMode;
			if ( mode == BDM_ShowBuffs )
			{
				buffsModule.ToggleShowKeys( false );
				buffsModule.ForceUpdateBuffs();
			}
			else
			{
				buffsModule.ToggleShowKeys( true );
				ReplaceBuffsFlash();
			}
		}
	}
	
	public function Init()
	{
		config = GetFHUDConfig();
		disallowOilsInCombat = GetWitcherPlayer().prepDisallowOilsInCombat;
		oilsHaveAmmo = GetWitcherPlayer().prepOilsHaveAmmo;
		playerInventory = thePlayer.GetInventory();
		buffsModule = (CR4HudModuleBuffs)theGame.GetHud().GetHudModule( "BuffsModule" );
		ToggleBuffsModule( true, "RadialMenuPotions" );
		InitNames();
		GetInventoryPotions();
		GetInventoryBombs();
		GetInventoryOils();
		RegisterModInput();
		mode = config.defaultDisplayMode;
		if ( mode != BDM_ShowBuffs )
		{
			buffsModule.ToggleShowKeys( true );
			ReplaceBuffsFlash();
		}
		buffsModule.ForceUpdatePosition();
	}
	
	public function Uninit()
	{
		buffsModule.ToggleShowKeys( false );
		ToggleBuffsModule( false, "RadialMenuPotions" );
		UnregisterModInput();
		ClearBuffsFlash();
		buffsModule.ForceUpdateBuffs();
		buffsModule.ForceUpdatePosition();
	}

	public function Update()
	{
		UpdateBuffsFlash();
	}

	private function RegisterModInput()
	{
		theInput.RegisterListener( this, 'OnShowPotionsHelper', 'ShowPotionsHelper' );
		theInput.RegisterListener( this, 'OnShowBombsHelper', 'ShowBombsHelper' );
		theInput.RegisterListener( this, 'OnShowOilsHelper', 'ShowOilsHelper' );
		theInput.RegisterListener( this, 'OnShowActiveBuffs', 'ShowActiveBuffs' );
		theInput.RegisterListener( this, 'OnSwitchBuffsMode', 'SwitchBuffsMode' );
		theInput.RegisterListener( this, 'OnUseItem1', 'UseItem1' );
		theInput.RegisterListener( this, 'OnUseItem2', 'UseItem2' );
		theInput.RegisterListener( this, 'OnUseItem3', 'UseItem3' );
		theInput.RegisterListener( this, 'OnUseItem4', 'UseItem4' );
		theInput.RegisterListener( this, 'OnUseItem5', 'UseItem5' );
		theInput.RegisterListener( this, 'OnUseItem6', 'UseItem6' );
		theInput.RegisterListener( this, 'OnUseItem7', 'UseItem7' );
		theInput.RegisterListener( this, 'OnUseItem8', 'UseItem8' );
		theInput.RegisterListener( this, 'OnUseItem9', 'UseItem9' );
		theInput.RegisterListener( this, 'OnUseItem10', 'UseItem10' );
		theInput.RegisterListener( this, 'OnUseItem11', 'UseItem11' );
		theInput.RegisterListener( this, 'OnUseItem12', 'UseItem12' );
		theInput.RegisterListener( this, 'OnItemsPadUp', 'ItemsPadUp' );
		theInput.RegisterListener( this, 'OnItemsPadDown', 'ItemsPadDown' );
		theInput.RegisterListener( this, 'OnItemsPadLeft', 'ItemsPadLeft' );
		theInput.RegisterListener( this, 'OnItemsPadRight', 'ItemsPadRight' );
		theInput.RegisterListener( this, 'OnItemsPadUse', 'ItemsPadUse' );
	}
	
	private function UnregisterModInput()
	{
		theInput.UnregisterListener( this, 'ShowPotionsHelper' );
		theInput.UnregisterListener( this, 'ShowBombsHelper' );
		theInput.UnregisterListener( this, 'ShowActiveBuffs' );
		theInput.UnregisterListener( this, 'SwitchBuffsMode' );
		theInput.UnregisterListener( this, 'UseItem1' );
		theInput.UnregisterListener( this, 'UseItem2' );
		theInput.UnregisterListener( this, 'UseItem3' );
		theInput.UnregisterListener( this, 'UseItem4' );
		theInput.UnregisterListener( this, 'UseItem5' );
		theInput.UnregisterListener( this, 'UseItem6' );
		theInput.UnregisterListener( this, 'UseItem7' );
		theInput.UnregisterListener( this, 'UseItem8' );
		theInput.UnregisterListener( this, 'UseItem9' );
		theInput.UnregisterListener( this, 'UseItem10' );
		theInput.UnregisterListener( this, 'UseItem11' );
		theInput.UnregisterListener( this, 'UseItem12' );
		theInput.UnregisterListener( this, 'ItemsPadUp' );
		theInput.UnregisterListener( this, 'ItemsPadDown' );
		theInput.UnregisterListener( this, 'ItemsPadLeft' );
		theInput.UnregisterListener( this, 'ItemsPadRight' );
		theInput.UnregisterListener( this, 'ItemsPadUse' );
	}

	private function PadUseCurrentPotion()
	{
		var i, j : int;
		
		for( i = 0; i < potions.Size(); i +=1 )
		{
			if ( playerInventory.IsIdValid( potions[i] )  )
			{
				if ( padCurrent == j )
				{
					ConsumePotion( potions[i] );
					return;
				}
				j += 1;
			}
		}
	}
	
	private function PadUseCurrentBomb()
	{
		var i, j : int;
		
		for( i = 0; i < bombs.Size(); i +=1 )
		{
			if ( playerInventory.IsIdValid( bombs[i] )  )
			{
				if ( padCurrent == j )
				{
					EquipBomb( bombs[i] );
					return;
				}
				j += 1;
			}
		}
	}
	
	private function PadUseCurrentOil()
	{
		var i, j : int;
		
		for( i = 0; i < oils.Size(); i +=1 )
		{
			if ( playerInventory.IsIdValid( oils[i] )  )
			{
				if ( padCurrent == j )
				{
					ApplyOil( oils[i] );
					return;
				}
				j += 1;
			}
		}
	}
	
	event OnItemsPadUse( action : SInputAction )
	{
		if ( IsReleased( action ) && ( theInput.LastUsedGamepad() || config.enableWASD ) )
		{
			if( mode == BDM_ShowPotions )
			{
				PadUseCurrentPotion();
			}
			else if ( mode == BDM_ShowBombs )
			{
				PadUseCurrentBomb();
			}
			else if ( mode == BDM_ShowOils )
			{
				PadUseCurrentOil();
			}
		}
	}
	
	event OnItemsPadUp( action : SInputAction )
	{
		var newPos : int;
		if ( IsReleased( action ) && ( theInput.LastUsedGamepad() || config.enableWASD ) )
		{
			newPos = padCurrent - 4;
			if ( newPos >= 0 && newPos < numItems )
			{
				padCurrent = newPos;
				ReplaceBuffsFlash();
				theSound.SoundEvent( "gui_global_highlight" );
			}
			else
			{
				theSound.SoundEvent( "gui_global_denied" );
			}
		}
	}
	
	event OnItemsPadDown( action : SInputAction )
	{
		var newPos : int;
		if ( IsReleased( action ) && ( theInput.LastUsedGamepad() || config.enableWASD ) )
		{
			newPos = padCurrent + 4;
			if ( newPos >= 0 && newPos < numItems )
			{
				padCurrent = newPos;
				ReplaceBuffsFlash();
				theSound.SoundEvent( "gui_global_highlight" );
			}
			else
			{
				theSound.SoundEvent( "gui_global_denied" );
			}
		}
	}
	
	event OnItemsPadLeft( action : SInputAction )
	{
		var newPos : int;
		if ( IsReleased( action ) && ( theInput.LastUsedGamepad() || config.enableWASD ) )
		{
			newPos = padCurrent - 1;
			if ( newPos >= 0 && newPos < numItems )
			{
				padCurrent = newPos;
				ReplaceBuffsFlash();
				theSound.SoundEvent( "gui_global_highlight" );
			}
			else
			{
				theSound.SoundEvent( "gui_global_denied" );
			}
		}
	}
	
	event OnItemsPadRight( action : SInputAction )
	{
		var newPos : int;
		if ( IsReleased( action ) && ( theInput.LastUsedGamepad() || config.enableWASD ) )
		{
			newPos = padCurrent + 1;
			if ( newPos < numItems )
			{
				padCurrent = newPos;
				ReplaceBuffsFlash();
				theSound.SoundEvent( "gui_global_highlight" );
			}
			else
			{
				theSound.SoundEvent( "gui_global_denied" );
			}
		}
	}
	
	event OnShowPotionsHelper( action : SInputAction )
	{
		if ( IsPressed( action ) && potions.Size() > 0 )
		{
			SetDisplayMode( BDM_ShowPotions );
		}
	}
	
	event OnShowBombsHelper( action : SInputAction )
	{
		if ( IsPressed( action ) && bombs.Size() > 0 )
		{
			SetDisplayMode( BDM_ShowBombs );
		}
	}
	
	event OnShowOilsHelper( action : SInputAction )
	{
		if ( IsPressed( action ) && oils.Size() > 0 )
		{
			SetDisplayMode( BDM_ShowOils );
		}
	}
	
	event OnShowActiveBuffs( action : SInputAction )
	{
		if ( IsPressed( action ) )
		{
			SetDisplayMode( BDM_ShowBuffs );
		}
	}
	
	event OnSwitchBuffsMode( action : SInputAction )
	{
		var cycle : EBuffsDisplayMode;
		
		if ( IsPressed( action ) )
		{
			cycle = mode;
			CycleModes( cycle );
			if ( cycle != mode )
			{
				SetDisplayMode( cycle );
			}
		}
	}
	
	private function CycleModes( out cycle : EBuffsDisplayMode )
	{
		var i : int;
	
		for( i = 1; i <= 3; i += 1 )
		{
			cycle = (EBuffsDisplayMode)(cycle + 1);
			if( cycle > BDM_ShowBuffs || ( cycle == BDM_ShowBuffs && !config.cycleThroughBuffs ) )
			{
				cycle = BDM_ShowPotions;
			}
			switch( cycle )
			{
				case BDM_ShowPotions:
					if( potions.Size() > 0 )
					{
						return;
					}
					break;
				case BDM_ShowBombs:
					if( bombs.Size() > 0 )
					{
						return;
					}
					break;
				case BDM_ShowOils:
					if( oils.Size() > 0 && ( !disallowOilsInCombat || !thePlayer.IsInCombat() ) )
					{
						return;
					}
					break;
				case BDM_ShowBuffs:
					return;
				default:
					break;
			}
		}
	}
	
	event OnUseItem1( action : SInputAction )
	{
		if( IsPressed( action ) )
		{
			if( mode == BDM_ShowPotions && potions.Size() > 0 )
			{
				ConsumePotion( potions[0] );
			}
			if( mode == BDM_ShowBombs && bombs.Size() > 0 )
			{
				EquipBomb( bombs[0] );
			}
			if( mode == BDM_ShowOils && oils.Size() > 0 )
			{
				ApplyOil( oils[0] );
			}
		}
	}
	
	event OnUseItem2( action : SInputAction )
	{
		if( IsPressed( action ) )
		{
			if( mode == BDM_ShowPotions && potions.Size() > 1 )
			{
				ConsumePotion( potions[1] );
			}
			if( mode == BDM_ShowBombs && bombs.Size() > 1 )
			{
				EquipBomb( bombs[1] );
			}
			if( mode == BDM_ShowOils && oils.Size() > 1 )
			{
				ApplyOil( oils[1] );
			}
		}
	}
	
	event OnUseItem3( action : SInputAction )
	{
		if( IsPressed( action ) )
		{
			if( mode == BDM_ShowPotions && potions.Size() > 2 )
			{
				ConsumePotion( potions[2] );
			}
			if( mode == BDM_ShowBombs && bombs.Size() > 2 )
			{
				EquipBomb( bombs[2] );
			}
			if( mode == BDM_ShowOils && oils.Size() > 2 )
			{
				ApplyOil( oils[2] );
			}
		}
	}
	
	event OnUseItem4( action : SInputAction )
	{
		if( IsPressed( action ) )
		{
			if( mode == BDM_ShowPotions && potions.Size() > 3 )
			{
				ConsumePotion( potions[3] );
			}
			if( mode == BDM_ShowBombs && bombs.Size() > 3 )
			{
				EquipBomb( bombs[3] );
			}
			if( mode == BDM_ShowOils && oils.Size() > 3 )
			{
				ApplyOil( oils[3] );
			}
		}
	}
	
	event OnUseItem5( action : SInputAction )
	{
		if( IsPressed( action ) )
		{
			if( mode == BDM_ShowPotions && potions.Size() > 4 )
			{
				ConsumePotion( potions[4] );
			}
			if( mode == BDM_ShowBombs && bombs.Size() > 4 )
			{
				EquipBomb( bombs[4] );
			}
			if( mode == BDM_ShowOils && oils.Size() > 4 )
			{
				ApplyOil( oils[4] );
			}
		}
	}
	
	event OnUseItem6( action : SInputAction )
	{
		if( IsPressed( action ) )
		{
			if( mode == BDM_ShowPotions && potions.Size() > 5 )
			{
				ConsumePotion( potions[5] );
			}
			if( mode == BDM_ShowBombs && bombs.Size() > 5 )
			{
				EquipBomb( bombs[5] );
			}
			if( mode == BDM_ShowOils && oils.Size() > 5 )
			{
				ApplyOil( oils[5] );
			}
		}
	}
	
	event OnUseItem7( action : SInputAction )
	{
		if( IsPressed( action ) )
		{
			if( mode == BDM_ShowPotions && potions.Size() > 6 )
			{
				ConsumePotion( potions[6] );
			}
			if( mode == BDM_ShowBombs && bombs.Size() > 6 )
			{
				EquipBomb( bombs[6] );
			}
			if( mode == BDM_ShowOils && oils.Size() > 6 )
			{
				ApplyOil( oils[6] );
			}
		}
	}
	
	event OnUseItem8( action : SInputAction )
	{
		if( IsPressed( action ) )
		{
			if( mode == BDM_ShowPotions && potions.Size() > 7 )
			{
				ConsumePotion( potions[7] );
			}
			if( mode == BDM_ShowBombs && IsPressed( action ) && bombs.Size() > 7 )
			{
				EquipBomb( bombs[7] );
			}
			if( mode == BDM_ShowOils && oils.Size() > 7 )
			{
				ApplyOil( oils[7] );
			}
		}
	}
	
	event OnUseItem9( action : SInputAction )
	{
		if( IsPressed( action ) )
		{
			if( mode == BDM_ShowPotions && potions.Size() > 8 )
			{
				ConsumePotion( potions[8] );
			}
			if( mode == BDM_ShowOils && oils.Size() > 8 )
			{
				ApplyOil( oils[8] );
			}
		}
	}
	
	event OnUseItem10( action : SInputAction )
	{
		if( IsPressed( action ) )
		{
			if( mode == BDM_ShowPotions && potions.Size() > 9 )
			{
				ConsumePotion( potions[9] );
			}
			if( mode == BDM_ShowOils && oils.Size() > 9 )
			{
				ApplyOil( oils[9] );
			}
		}
	}
	
	event OnUseItem11( action : SInputAction )
	{
		if( IsPressed( action ) )
		{
			if( mode == BDM_ShowPotions && potions.Size() > 10 )
			{
				ConsumePotion( potions[10] );
			}
			if( mode == BDM_ShowOils && oils.Size() > 10 )
			{
				ApplyOil( oils[10] );
			}
		}
	}
	
	event OnUseItem12( action : SInputAction )
	{
		if( IsPressed( action ) )
		{
			if( mode == BDM_ShowPotions && potions.Size() > 11 )
			{
				ConsumePotion( potions[11] );
			}
			if( mode == BDM_ShowOils && oils.Size() > 11 )
			{
				ApplyOil( oils[11] );
			}
		}
	}
	
	private function ConsumePotion( potionID : SItemUniqueId )
	{
		if( thePlayer.IsCiri() || !playerInventory.IsIdValid( potionID ) )
		{
			return;
		}
		if ( GetWitcherPlayer().ToxicityLowEnoughToDrinkPotion( EES_Potion1, potionID ) && playerInventory.SingletonItemGetAmmo( potionID ) != 0 )
		{
			GetWitcherPlayer().DrinkPreparedPotion( EES_Potion1, potionID );
			//if( playerInventory.SingletonItemGetAmmo( potionID ) == 0 )
			//{
				ReplaceBuffsFlash();
			//}
		}
		else
		{
			theSound.SoundEvent( "gui_global_denied" );
		}
	}
	
	private function EquipBomb( bombID : SItemUniqueId )
	{
		if( thePlayer.IsCiri() || !playerInventory.IsIdValid( bombID ) )
		{
			return;
		}
		theSound.SoundEvent( "gui_inventory_bombs_attach" );
		thePlayer.EquipItem( bombID, EES_Petard1 );
		thePlayer.OnRadialMenuItemChoose( "Slot1" );
		ReplaceBuffsFlash();
		dirtyFlag = true;
	}
	
	private function ApplyOil( oilID : SItemUniqueId )
	{
		var swordId : SItemUniqueId;
	
		if( thePlayer.IsCiri() || !playerInventory.IsIdValid( oilID ) )
		{
			return;
		}
		if( disallowOilsInCombat && thePlayer.IsInCombat() || oilsHaveAmmo && playerInventory.SingletonItemGetAmmo( oilID ) < 1 )
		{
			theSound.SoundEvent( "gui_global_denied" );
			return;
		}
		if( config.applyOilToDrawnSword )
		{
			if( thePlayer.GetCurrentMeleeWeaponType() == PW_Steel && playerInventory.ItemHasTag( oilID, 'SteelOil' ) )
			{
				GetWitcherPlayer().GetItemEquippedOnSlot( EES_SteelSword, swordId );
			}
			else if( thePlayer.GetCurrentMeleeWeaponType() == PW_Silver && playerInventory.ItemHasTag( oilID, 'SilverOil' ) )
			{
				GetWitcherPlayer().GetItemEquippedOnSlot( EES_SilverSword, swordId );
			}
		}
		else if( playerInventory.ItemHasTag( oilID, 'SteelOil' ) )
		{
			GetWitcherPlayer().GetItemEquippedOnSlot( EES_SteelSword, swordId );
		}
		else if( playerInventory.ItemHasTag( oilID, 'SilverOil' ) )
		{
			GetWitcherPlayer().GetItemEquippedOnSlot( EES_SilverSword, swordId );
		}
		if( swordId != GetInvalidUniqueId() )
		{
			thePlayer.ApplyOil( oilID, swordId );
			theSound.SoundEvent( "gui_preparation_potion" );
			ReplaceBuffsFlash();
		}
		else
		{
			theSound.SoundEvent( "gui_global_denied" );
		}
	}
	
	private function GetInventoryPotions()
	{
		var i		: int;
		var invItem	: SItemUniqueId;
		
		for( i = 0; i < potionNames.Size(); i += 1 )
		{
			invItem = GetPotionByName( potionNames[i] );
			potions.PushBack( invItem );
		}
	}

	private function GetPotionByName( potionName : string ) : SItemUniqueId
	{
		var playerPotions	: array< SItemUniqueId >;
		var i				: int;
		
		playerPotions = playerInventory.GetItemsByTag( 'Potion' );
		for( i = 0; i < playerPotions.Size(); i += 1 )
		{
			if( StrContains( NameToString( playerInventory.GetItemName( playerPotions[i] ) ), potionName ) )
			{
				return playerPotions[i];
			}
		}
		return GetInvalidUniqueId();
	}
	
	private function GetInventoryBombs()
	{
		var i		: int;
		var invItem	: SItemUniqueId;
		
		for( i = 0; i < bombNames.Size(); i += 1 )
		{
			invItem = GetBombByName( bombNames[i] );
			bombs.PushBack( invItem );
		}
	}

	private function GetBombByName( bombName : string ) : SItemUniqueId
	{
		var playerBombs	: array< SItemUniqueId >;
		var i			: int;
		
		playerBombs = playerInventory.GetItemsByTag( 'Petard' );
		for( i = 0; i < playerBombs.Size(); i += 1 )
		{
			if( StrContains( NameToString( playerInventory.GetItemName( playerBombs[i] ) ), bombName ) )
			{
				return playerBombs[i];
			}
		}
		return GetInvalidUniqueId();
	}
	
	private function GetInventoryOils()
	{
		var i		: int;
		var invItem	: SItemUniqueId;
		
		for( i = 0; i < oilNames.Size(); i += 1 )
		{
			invItem = GetOilByName( oilNames[i] );
			oils.PushBack( invItem );
		}
	}

	private function GetOilByName( oilName : string ) : SItemUniqueId
	{
		var playerOils	: array< SItemUniqueId >;
		var i			: int;
		
		playerOils = playerInventory.GetItemsByTag( 'SilverOil' );
		for( i = 0; i < playerOils.Size(); i += 1 )
		{
			if( StrContains( NameToString( playerInventory.GetItemName( playerOils[i] ) ), oilName ) )
			{
				return playerOils[i];
			}
		}
		playerOils = playerInventory.GetItemsByTag( 'SteelOil' );
		for( i = 0; i < playerOils.Size(); i += 1 )
		{
			if( StrContains( NameToString( playerInventory.GetItemName( playerOils[i] ) ), oilName ) )
			{
				return playerOils[i];
			}
		}
		return GetInvalidUniqueId();
	}
	
	private function GetKeyStr( i : int ) : string
	{
		if ( i >= 0 && i < keyNames.Size() )
		{
			return keyNames[i];
		}
		return "";
	}
	
	private function ReplaceBuffsFlash()
	{
		var l_flashArray			: CScriptedFlashArray;
		
		l_flashArray = buffsModule.GetTempFlashArray();
		switch( mode )
		{
			case BDM_ShowPotions:
				GetPotionsFlashArray( l_flashArray );
				break;
			case BDM_ShowBombs:
				GetBombsFlashArray( l_flashArray );
				break;
			case BDM_ShowOils:
				GetOilsFlashArray( l_flashArray );
				break;
			default:
				break;
		}
		buffsModule.SetBuffsFlashArray( l_flashArray );
	}
	
	private function GetPotionsFlashArray( out l_flashArray : CScriptedFlashArray )
	{
		var i, j					: int;
		var l_flashObject			: CScriptedFlashObject;
		var effects					: array< CBaseGameplayEffect >;
		var effectType				: EEffectType;
		var abilityName				: name;
		var titleText				: string;
		var duration				: float;
		var initialDuration 		: float;
		
		j = 0;
		for( i = 0; i < potions.Size(); i += 1 )
		{
			if ( playerInventory.IsIdValid( potions[i] ) )
			{
				l_flashObject = buffsModule.GetTempFlashObject();
				playerInventory.GetPotionItemBuffData( potions[i], effectType, abilityName );
				titleText = GetTitleText( GetKeyStr( i ), GetLocStringByKeyExt( theGame.effectMgr.GetEffectNameLocalisationKey( effectType ) ) );
				if( ( theInput.LastUsedGamepad() || config.enableWASD ) && padCurrent == j )
				{
					if( playerInventory.SingletonItemGetAmmo( potions[i] ) == 0 )
					{
						titleText = config.zeroQuantCurTextFont + titleText + "</font>";
					}
					else
					{
						titleText = config.currentTextFont + titleText + "</font>";
					}
				}
				else if( playerInventory.SingletonItemGetAmmo( potions[i] ) == 0 )
				{
					titleText = config.zeroQuantityTextFont + titleText + "</font>";
				}
				effects = thePlayer.GetBuffs( effectType );
				if ( effects.Size() < 1 )
				{
					l_flashObject.SetMemberFlashInt( "format", 1 ); // counter
					l_flashObject.SetMemberFlashInt( "isPositive", 2 ); // neutral
					initialDuration = playerInventory.SingletonItemGetMaxAmmo( potions[i] );
					duration = playerInventory.SingletonItemGetAmmo( potions[i] );
				}
				else
				{
					l_flashObject.SetMemberFlashInt( "format", 3 ); // timer
					l_flashObject.SetMemberFlashInt( "isPositive", 1 ); // positive
					initialDuration = effects[0].GetInitialDuration();
					duration = effects[0].GetDurationLeft();
				}
				l_flashObject.SetMemberFlashString( "iconName", playerInventory.GetItemIconPathByUniqueID( potions[i] ) );
				l_flashObject.SetMemberFlashString( "title", titleText );
				l_flashObject.SetMemberFlashNumber( "duration", duration );
				l_flashObject.SetMemberFlashNumber( "initialDuration", initialDuration );
				l_flashObject.SetMemberFlashBool( "isVisible", true );
				l_flashObject.SetMemberFlashBool( "IsPotion", false );
				l_flashArray.PushBackFlashObject( l_flashObject );
				j += 1;
			}
		}
		numItems = j;
	}
	
	private function GetBombsFlashArray( out l_flashArray : CScriptedFlashArray )
	{
		var i, j					: int;
		var l_flashObject			: CScriptedFlashObject;
		var titleText				: string;
		
		j = 0;
		for( i = 0; i < bombs.Size(); i += 1 )
		{
			if ( playerInventory.IsIdValid( bombs[i] ) )
			{
				l_flashObject = buffsModule.GetTempFlashObject();
				titleText = GetTitleText( GetKeyStr( i ), GetItemShortName( bombs[i] ) );
				if( ( theInput.LastUsedGamepad() || config.enableWASD ) && padCurrent == j )
				{
					if( playerInventory.SingletonItemGetAmmo( bombs[i] ) == 0 )
					{
						titleText = config.zeroQuantCurTextFont + titleText + "</font>";
					}
					else
					{
						titleText = config.currentTextFont + titleText + "</font>";
					}
				}
				else if( playerInventory.SingletonItemGetAmmo( bombs[i] ) == 0 )
				{
					titleText = config.zeroQuantityTextFont + titleText + "</font>";
				}
				if( GetWitcherPlayer().IsItemEquipped( bombs[i] ) )
				{
					l_flashObject.SetMemberFlashInt( "isPositive", 1 ); // positive
				}
				else
				{
					l_flashObject.SetMemberFlashInt( "isPositive", 2 ); // neutral
				}
				l_flashObject.SetMemberFlashString( "iconName", playerInventory.GetItemIconPathByUniqueID( bombs[i] ) );
				l_flashObject.SetMemberFlashString( "title", titleText );
				l_flashObject.SetMemberFlashNumber( "duration", 0 );
				l_flashObject.SetMemberFlashNumber( "initialDuration", 0 );
				l_flashObject.SetMemberFlashBool( "isVisible", true );
				l_flashObject.SetMemberFlashBool( "IsPotion", false );
				l_flashObject.SetMemberFlashInt( "format", 1 ); // counter
				l_flashArray.PushBackFlashObject( l_flashObject );
				j += 1;
			}
		}
		numItems = j;
	}
	
	private function GetOilsFlashArray( out l_flashArray : CScriptedFlashArray )
	{
		var i, j, ammo, maxAmmo		: int;
		var l_flashObject			: CScriptedFlashObject;
		var titleText				: string;
		var duration				: float;
		var initialDuration 		: float;
		
		j = 0;
		for( i = 0; i < oils.Size(); i += 1 )
		{
			if ( playerInventory.IsIdValid( oils[i] ) )
			{
				l_flashObject = buffsModule.GetTempFlashObject();
				titleText = GetTitleText( GetKeyStr( i ), GetItemShortName( oils[i] ) );
				if( ( theInput.LastUsedGamepad() || config.enableWASD ) && padCurrent == j )
				{
					if( oilsHaveAmmo && playerInventory.SingletonItemGetAmmo( oils[i] ) < 1 )
					{
						titleText = config.zeroQuantCurTextFont + titleText + "</font>";
					}
					else
					{
						titleText = config.currentTextFont + titleText + "</font>";
					}
				}
				else if( oilsHaveAmmo && playerInventory.SingletonItemGetAmmo( oils[i] ) < 1 )
				{
					titleText = config.zeroQuantityTextFont + titleText + "</font>";
				}
				
				l_flashObject.SetMemberFlashString( "iconName", playerInventory.GetItemIconPathByUniqueID( oils[i] ) );
				l_flashObject.SetMemberFlashString( "title", titleText );
				if( GetOilAmmo( oils[i], ammo, maxAmmo ) )
				{
					l_flashObject.SetMemberFlashInt( "isPositive", 1 ); // positive
					l_flashObject.SetMemberFlashInt( "format", 1 ); // counter
					duration = ammo;
					initialDuration = maxAmmo;
				}
				else
				{
					l_flashObject.SetMemberFlashInt( "isPositive", 2 ); // neutral
					if( oilsHaveAmmo )
					{
						l_flashObject.SetMemberFlashInt( "format", 1 ); // counter
						duration = playerInventory.SingletonItemGetAmmo( oils[i] );
						initialDuration = playerInventory.SingletonItemGetMaxAmmo( oils[i] );
					}
					else
					{
						l_flashObject.SetMemberFlashInt( "format", 0 ); // nothing
						duration = 0;
						initialDuration = 0;
					}
				}
				l_flashObject.SetMemberFlashNumber( "duration", duration );
				l_flashObject.SetMemberFlashNumber( "initialDuration", initialDuration );
				l_flashObject.SetMemberFlashBool( "isVisible", true );
				l_flashObject.SetMemberFlashBool("IsPotion", false);
				l_flashArray.PushBackFlashObject( l_flashObject );
				j += 1;
			}
		}
		numItems = j;
	}
	
	private function GetItemShortName( itemID : SItemUniqueId ) : string
	{
		var key, left, right : string;
	
		key = playerInventory.GetItemLocalizedNameByUniqueID( itemID );
		StrSplitLast( key, "_", left, right );
		return GetLocStringByKeyExt( left + "_1" );
	}
	
	private function GetTitleText( keyString, nameString : string ) : string
	{
		var result : string;
		
		result = config.itemNamePattern;
		result = StrReplace( result, "<key>", keyString );
		result = StrReplace( result, "<name>", nameString );
		return result;
	}
	
	private function UpdateBuffsFlash()
	{
		switch( mode )
		{
			case BDM_ShowPotions:
				UpdatePotionsFlash();
				break;
			case BDM_ShowBombs:
				UpdateBombsFlash();
				break;
			case BDM_ShowOils:
				UpdateOilsFlash();
				break;
			default:
				break;
		}
	}
	
	private function UpdatePotionsFlash()
	{
		var effects		: array< CBaseGameplayEffect >;
		var effectType	: EEffectType;
		var abilityName	: name;
		var i, j		: int;
		var duration	: float;
		var initialDuration : float;
		
		j = 0;
		for( i = 0; i < potions.Size(); i += 1 )
		{
			if ( playerInventory.IsIdValid( potions[i] ) )
			{
				playerInventory.GetPotionItemBuffData( potions[i], effectType, abilityName );
				effects = thePlayer.GetBuffs( effectType );
				if ( effects.Size() < 1 )
				{
					initialDuration = playerInventory.SingletonItemGetMaxAmmo( potions[i] );
					duration = playerInventory.SingletonItemGetAmmo( potions[i] );
				}
				else
				{
					initialDuration = effects[0].GetInitialDuration();
					duration = effects[0].GetDurationLeft();
				}
				buffsModule.SetBuffsPercent( j, duration, initialDuration );
				j += 1;
			}
		}
		numItems = j;
	}
	
	private function UpdateBombsFlash()
	{
		var i, j : int;
		
		j = 0;
		for( i = 0; i < bombs.Size(); i += 1 )
		{
			if ( playerInventory.IsIdValid( bombs[i] ) )
			{
				//if( GetWitcherPlayer().IsItemEquipped( bombs[i] ) )
					buffsModule.SetBuffsPercent( j, playerInventory.SingletonItemGetAmmo( bombs[i] ), playerInventory.SingletonItemGetMaxAmmo( bombs[i] ) );
				//else
					//buffsModule.SetBuffsPercent( j, 0, 0 );
				j += 1;
			}
		}
		numItems = j;
	}
	
	private function UpdateOilsFlash()
	{
		var i, j, ammo, maxAmmo : int;
		
		j = 0;
		for( i = 0; i < oils.Size(); i += 1 )
		{
			if ( playerInventory.IsIdValid( oils[i] ) )
			{
				if( oilsHaveAmmo )
				{
					if( !GetOilAmmo( oils[i], ammo, maxAmmo ) )
					{
						ammo = playerInventory.SingletonItemGetAmmo( oils[i] );
						maxAmmo = playerInventory.SingletonItemGetMaxAmmo( oils[i] );
					}
					buffsModule.SetBuffsPercent( j, ammo, maxAmmo );
				}
				else
				{
					if( GetOilAmmo( oils[i], ammo, maxAmmo ) )
					{
						buffsModule.SetBuffsPercent( j, ammo, maxAmmo );
					}
					else
					{
						buffsModule.SetBuffsPercent( j, 0, 0 );
					}
				}
				j += 1;
			}
		}
		numItems = j;
	}
	
	private function GetSwordOilAmmo( oilID : SItemUniqueId, swordID : SItemUniqueId, out ammo : int, out maxAmmo : int ) : bool
	{
		var i : int;
		var oils : array< W3Effect_Oil >;
		var oilName: name;

		oilName = playerInventory.GetItemName( oilID );
		oils = playerInventory.GetOilsAppliedOnItem( swordID );
		for( i = 0; i < oils.Size(); i += 1 )
		{
			if( oils[i].GetOilItemName() == oilName )
			{
				ammo = oils[i].GetAmmoCurrentCount();
				maxAmmo = oils[i].GetAmmoMaxCount();
				if( ammo > 0 )
				{
					return true;
				}
			}
		}
		return false;
	}
	
	private function GetOilAmmo( oilID : SItemUniqueId, out ammo : int, out maxAmmo : int ) : bool
	{
		var swordID : SItemUniqueId;
		
		if( config.applyOilToDrawnSword )
		{
			if ( thePlayer.GetCurrentMeleeWeaponType() == PW_Steel && playerInventory.ItemHasTag( oilID, 'SteelOil' ) )
			{
				swordID = thePlayer.GetEquippedSword( true );
			}
			else if ( thePlayer.GetCurrentMeleeWeaponType() == PW_Silver && playerInventory.ItemHasTag( oilID, 'SilverOil' ) )
			{
				swordID = thePlayer.GetEquippedSword( false );
			}
			return GetSwordOilAmmo( oilID, swordID, ammo, maxAmmo );
		}
		
		swordID = thePlayer.GetEquippedSword( true );
		if( !GetSwordOilAmmo( oilID, swordID, ammo, maxAmmo ) )
		{
			swordID = thePlayer.GetEquippedSword( false );
			if( GetSwordOilAmmo( oilID, swordID, ammo, maxAmmo ) )
			{
				return true;
			}
			return false;
		}
		return true;
	}
	
	private function ClearBuffsFlash()
	{
		buffsModule.SetBuffsFlashArray( buffsModule.GetTempFlashArray() );
	}
}
//---=== modFriendlyHUD ===---
