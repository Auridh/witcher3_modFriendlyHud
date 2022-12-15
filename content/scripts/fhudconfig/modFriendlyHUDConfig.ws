//---=== modFriendlyHUD ===---
class CModFriendlyHUDConfig
{
	//--- Configurable section begin ---
	
	//---=== HUD Modules ===---
	
	//A threshold to display Wolf Module on vitality increase:
	//use 0 if you want to see healthbar for every vitality increase, including natural regeneration;
	//use 12 (bigger than normal + Sun and Stars) to exclude natural vitality regen;
	//use 999999 (any number big enough) to never see Wolf Module on vitality increase.
	const var vitalityRiseThreshold: float; default vitalityRiseThreshold = 12;
	
	//These are modules, which appear while you're holding Enter, M, J and K hotkeys
	//List of supported modules:
	//WolfHeadModule; BuffsModule; ItemInfoModule; DamagedItemsModule;
	//Minimap2Module; QuestsModule; CompanionModule; ControlsFeedbackModule
	const var essentialModulesStr : string; default
		essentialModulesStr = "WolfHeadModule; BuffsModule; ItemInfoModule; DamagedItemsModule; Minimap2Module; QuestsModule";
	const var minimapModulesStr : string; default
		minimapModulesStr = "Minimap2Module";
	const var questsModulesStr : string; default
		questsModulesStr = "QuestsModule";
	const var characterModulesStr : string; default
		characterModulesStr = "WolfHeadModule; BuffsModule; ItemInfoModule; DamagedItemsModule";
	//These are modules, which appear under certain conditions if enabled (see triggers above)
	const var combatModulesStr : string; default
		combatModulesStr = "WolfHeadModule; BuffsModule; ItemInfoModule; DamagedItemsModule; CompanionModule";
	const var witcherSensesModulesStr : string; default
		witcherSensesModulesStr = "Minimap2Module; QuestsModule";
	const var meditationModulesStr : string; default
		meditationModulesStr = "Minimap2Module";
	//Radial module flash script auto-hides top-left and top-right modules (WolfHeadModule, Minimap2Module), impossible to fix now
	const var radialMenuModulesStr : string; default
		radialMenuModulesStr = "ItemInfoModule";
	
	//---=== Quick Items In Radial Menu Settings ===---
	
	//Potions order in this list equals to hotkey order: 1-9, 0, -, = (buffs module flash can handle up to 12 items max!)
	const var potionsOrderStr : string; default
		potionsOrderStr = "Tawny_Owl; Thunderbolt; Blizzard; Swallow; White_Raffards_Decoction; Black_Blood; Full_Moon; Maribor_Forest; Petri_Philtre; Golden_Oriole; Cat; White_Honey";
	//Bombs order in this list equals to hotkey order: 1-8
	const var bombsOrderStr : string; default
		bombsOrderStr = "Dancing_Star; Devils_Puffball; Dragons_Dream; Grapeshot; Samum; White_Frost; Silver_Dust_Bomb; Dwimeritium_Bomb";
	//Oils order in this list equals to hotkey order: 1-9, 0, -, =
	const var oilsOrderStr : string; default
		oilsOrderStr = "Cursed_Oil; Draconide_Oil; Insectoid_Oil; Hybrid_Oil; Magicals_Oil; Necrophage_Oil; Ogre_Oil; Relic_Oil; Specter_Oil; Vampire_Oil; Beast_Oil; Hanged_Man_Venom";
	//Key strings (just text, doesn't affect actual bindings). Key bindings are displayed as pictures in-game and buffs module can't handle additional pictures.
	//This list is the best I can do for displaying your custom binds properly without going into much trouble.
	const var keysOrderStr : string; default
		keysOrderStr = "1; 2; 3; 4; 5; 6; 7; 8; 9; 0; -; =";
	//Since localized names have different length in different languages, you can use these settings to fine-tune quick items display to best fit the screen.
	//You can move <key> and <name> placeholders around and add separators. If you have hotkeys memorized, you can remove <key> indicator altogether.
	//And if using something like Better Icons mod that adds names directly to icons, you can remove <name> and leave only <key> for hotkey help.
	const var itemNamePattern : string; default itemNamePattern = "<key>:<name>";
	//Text color (html) for potions with zero quantity left
	const var zeroQuantityTextFont : string; default zeroQuantityTextFont = "<font color=\"#FF0000\">";
	//Controller related: current selection with zero quantity and current selection colors
	const var zeroQuantCurTextFont : string; default zeroQuantCurTextFont = "<font color=\"#FFFF00\">";
	const var currentTextFont : string; default currentTextFont = "<font color=\"#00FF00\">";
	
	//--- End of configurable section ---
	
	//============================================================================================
	
	//--- moved to config menu ---
	public var fadeOutTimeSeconds : float;
	public var enableCombatModules : bool;
	public var enableCombatModulesOnUnsheathe : bool;
	public var enableWolfModuleOnVitalityChanged: bool;
	public var enableWitcherSensesModules : bool;
	public var enableMeditationModules : bool;
	public var enableRadialMenuModules : bool;
	public var hideJournalUpdates : bool;
	
	public var markersDistanceTextSize : int;
	public var markersDescriptionTextSize : int;
	public var markersAltTextSize : int;
	public var markersIconSizePrc : int;
	public var markerIconType : int;
	public var markerMinDistanceSquared : float;
	public var markerMaxDistanceSquared : float;
	public var markerDescriptionDisplayMode : int;
	public var markerIconDisplayMode : int;
	public var markerDistanceDisplayMode : int;
	public var markerCompassDisplayMode : int;
	public var markerOnScreenOnly : bool;
	public var b3DMarkersEnabled : bool;
	public var compassMarkersEnabled : bool;
	public var project3DMarkersOnCompass : bool;
	public var compassScreenPosY : float;
	public var markersFadeOutDelay : float;
	public var markersShowQuests : int;
	public var markersShowQuestsAll : int;
	public var markersShowUser : int;
	public var markersShowUserAll : int;
	public var markersShowMapLoc : int;
	public var markersShowNPCs : int;
	public var markersShowPOIs : int;
	public var markersShowDisabled : int;
	public var markersShowUndiscovered : int;
	public var markersShowMisc : int;
	public var markersShowHerbs : int;
	public var markersShowEnemies : int;
	public var markersShowDeadEnemies : int;
	public var markersShowWSClues : int;
	public var markerHideActivities : bool;
	public var markerShowUndiscoveredRoadsigns : bool;
	public var markerPinWithUserMarker : bool;
	public var markersSyncWithMap : bool;
	public var markersTransparency : float;
	
	public var enableItemsInRadialMenu : bool;
	public var defaultDisplayMode : EBuffsDisplayMode;
	public var cycleThroughBuffs : bool;
	public var enableWASD : bool;
	public var applyOilToDrawnSword : bool;
	public var radialMenuTimescale : float;
	public var showTrueItemPrice : bool;
	public var showStashItemQuantity : bool;
	public var showRecyclingParts : bool;
	public var showItemCountWhenCrafting : bool;
	public var disableAllInteractionPrompts : bool;
	public var talkBubbleMode, talkButtonMode, interactionButtonMode : int;
	public var hideWSInteractionIcons : bool;
	public var maxDistanceToShowNames : float;
	public var maxDistanceToShowNamesInCbt : float;
	public var hideAnimalNames, hideHerbNames : bool;
	public var hideNPCQuestMarkers : bool;
	public var doNotShowDamage : bool;
	public var doNotShowLevels : int;
	public var showBossHP : bool;
	public var mapUnlimitedZoom : bool;
	public var mapZoomMinCoef : float;
	public var mapZoomMaxCoef : float;
	public var minimapZoomExterior : float;
	public var minimapZoomInterior : float;
	public var minimapZoomBoat : float;
	public var showItemsInSlowdownMode : bool;
	public var silentJournalUpdates : bool;
	public var disableCatWhenNotInDarkPlace : bool;
	public var enableCatAtNight : bool;

	//--- other vars ---
	public var forceShowMarkers						: bool; default forceShowMarkers = false;
	private var potionsOrder						: array< string >;
	private var bombsOrder							: array< string >;
	private var oilsOrder							: array< string >;
	private var keysOrder							: array< string >;
	public var essentialModules						: array< string >;
	public var minimapModules						: array< string >;
	public var questsModules						: array< string >;
	public var characterModules						: array< string >;
	public var combatModules						: array< string >;
	public var witcherSensesModules					: array< string >;
	public var meditationModules					: array< string >;
	public var radialMenuModules					: array< string >;
	private var resetNewItemsInCategories			: array< string >;
	
	//--- functions ---
	public function Init()
	{
		UpdateUserSettings();
		InitArrays();
	}
	
	public function InitToggleableValues()
	{
		forceShowMarkers = false;
	}

	public function Toggle3DMarkers()
	{
		forceShowMarkers = ( !forceShowMarkers );
	}
	
	public function GetResetNewItemsInCategoriesArray() : array< string >
	{
		return resetNewItemsInCategories;
	}
	
	public function FillPotionNames( out potionNames : array< string > )
	{
		potionNames = potionsOrder;
	}
	
	public function FillBombNames( out bombNames : array< string > )
	{
		bombNames = bombsOrder;
	}
	
	public function FillOilNames( out oilNames : array< string > )
	{
		oilNames = oilsOrder;
	}
	
	public function FillKeyNames( out keyNames : array< string > )
	{
		keyNames = keysOrder;
	}
	
	function InitArrays()
	{
		potionsOrder = StrToArrStr( potionsOrderStr, ";" );
		bombsOrder = StrToArrStr( bombsOrderStr, ";" );
		oilsOrder = StrToArrStr( oilsOrderStr, ";" );
		keysOrder = StrToArrStr( keysOrderStr, ";" );
		essentialModules = StrToArrStr( essentialModulesStr, ";" );
		minimapModules = StrToArrStr( minimapModulesStr, ";" );
		questsModules = StrToArrStr( questsModulesStr, ";" );
		characterModules = StrToArrStr( characterModulesStr, ";" );
		combatModules = StrToArrStr( combatModulesStr, ";" );
		witcherSensesModules = StrToArrStr( witcherSensesModulesStr, ";" );
		meditationModules = StrToArrStr( meditationModulesStr, ";" );
		radialMenuModules = StrToArrStr( radialMenuModulesStr, ";" );
	}
	
	//Update user settings
	public function UpdateUserSettings()
	{
		//modules
		enableCombatModules = theGame.GetInGameConfigWrapper().GetVarValue('fhudHUD', 'fhudEnableCombatModules');
		enableCombatModulesOnUnsheathe = theGame.GetInGameConfigWrapper().GetVarValue('fhudHUD', 'fhudEnableCombatModulesOnUnsheathe');
		enableWolfModuleOnVitalityChanged = theGame.GetInGameConfigWrapper().GetVarValue('fhudHUD', 'fhudEnableWolfModuleOnVitalityChanged');
		enableWitcherSensesModules = theGame.GetInGameConfigWrapper().GetVarValue('fhudHUD', 'fhudEnableWitcherSensesModules');
		enableMeditationModules = theGame.GetInGameConfigWrapper().GetVarValue('fhudHUD', 'fhudEnableMeditationModules');
		enableRadialMenuModules = theGame.GetInGameConfigWrapper().GetVarValue('fhudHUD', 'fhudEnableRadialMenuModules');
		hideJournalUpdates = theGame.GetInGameConfigWrapper().GetVarValue('fhudHUD', 'fhudHideJournalUpdates');
		fadeOutTimeSeconds = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('fhudHUD', 'fhudFadeOutTimeSeconds'));
		CheckModules();
		//3D markers
		markersDistanceTextSize = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudMarkersDistanceTextSize'));
		markersDescriptionTextSize = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudMarkersDescriptionTextSize'));
		markersAltTextSize = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudMarkersAltTextSize'));
		markersIconSizePrc = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudMarkersIconSizePrc'));
		markerMinDistanceSquared = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudMarkerMinDistance'));
		markerMinDistanceSquared *= markerMinDistanceSquared; //squared
		markerMaxDistanceSquared = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudMarkerMaxDistance'));
		markerMaxDistanceSquared *= markerMaxDistanceSquared; //squared
		markerDescriptionDisplayMode = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'Virtual_fhudMarkerDescriptionDisplayMode'));
		markerIconDisplayMode = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'Virtual_fhudMarkerIconDisplayMode'));
		markerDistanceDisplayMode = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'Virtual_fhudMarkerDistanceDisplayMode'));
		markerCompassDisplayMode = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'Virtual_fhudMarkerCompassDisplayMode'));
		markerOnScreenOnly = theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudMarkerOnScreenOnly');
		b3DMarkersEnabled = theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhud3DMarkersEnabled');
		compassMarkersEnabled = theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudCompassMarkersEnabled');
		project3DMarkersOnCompass = theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudProject3DMarkersOnCompass');
		compassScreenPosY = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudCompassScreenPosY'));
		markerIconType = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'Virtual_fhudMarkerIconType'));
		markersFadeOutDelay = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudMarkersFadeOutDelay'));
		markersShowQuests = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'Virtual_fhudMarkersShowQuests'));
		markersShowQuestsAll = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'Virtual_fhudMarkersShowQuestsAll'));
		markersShowUser = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'Virtual_fhudMarkersShowUser'));
		markersShowUserAll = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'Virtual_fhudMarkersShowUserAll'));
		markersShowMapLoc = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'Virtual_fhudMarkersShowMapLoc'));
		markersShowNPCs = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'Virtual_fhudMarkersShowNPCs'));
		markersShowPOIs = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'Virtual_fhudMarkersShowPOIs'));
		markersShowDisabled = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'Virtual_fhudMarkersShowDisabled'));
		markersShowUndiscovered = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'Virtual_fhudMarkersShowUndiscovered'));
		markersShowMisc = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'Virtual_fhudMarkersShowMisc'));
		markersShowHerbs = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'Virtual_fhudMarkersShowHerbs'));
		markersShowEnemies = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'Virtual_fhudMarkersShowEnemies'));
		markersShowDeadEnemies = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'Virtual_fhudMarkersShowDeadEnemies'));
		markersShowWSClues = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'Virtual_fhudMarkersShowWSClues'));
		markerHideActivities = theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudMarkerHideActivities');
		markerShowUndiscoveredRoadsigns = theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudMarkerShowUndiscoveredRoadsigns');
		markerPinWithUserMarker = theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudMarkerPinWithUserMarker');
		markersSyncWithMap = theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudMarkersSyncWithMap');
		markersTransparency = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudMarkersTransparency'));
		//quick items
		showItemsInSlowdownMode = theGame.GetInGameConfigWrapper().GetVarValue('fhudQuickItems', 'fhudShowItemsInSlowdownMode');
		enableItemsInRadialMenu = theGame.GetInGameConfigWrapper().GetVarValue('fhudQuickItems', 'fhudEnableItemsInRadialMenu');
		defaultDisplayMode = GetBuffsDisplayMode();
		cycleThroughBuffs = theGame.GetInGameConfigWrapper().GetVarValue('fhudQuickItems', 'fhudCycleThroughBuffs');
		enableWASD = theGame.GetInGameConfigWrapper().GetVarValue('fhudQuickItems', 'fhudEnableWASD');
		applyOilToDrawnSword = theGame.GetInGameConfigWrapper().GetVarValue('fhudQuickItems', 'fhudApplyOilToDrawnSword');
		radialMenuTimescale = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('fhudQuickItems', 'fhudRadialMenuTimescale'));
		//inventory
		resetNewItemsInCategories.Clear();
		if(theGame.GetInGameConfigWrapper().GetVarValue('fhudInventory', 'fhudResetNewItemsIngredients'))
			resetNewItemsInCategories.PushBack("Ingredients");
		if(theGame.GetInGameConfigWrapper().GetVarValue('fhudInventory', 'fhudResetNewItemsQuest'))
			resetNewItemsInCategories.PushBack("Quest");
		if(theGame.GetInGameConfigWrapper().GetVarValue('fhudInventory', 'fhudResetNewItemsOthers'))
			resetNewItemsInCategories.PushBack("Others");
		if(theGame.GetInGameConfigWrapper().GetVarValue('fhudInventory', 'fhudResetNewItemsEdibles'))
			resetNewItemsInCategories.PushBack("Edibles");
		if(theGame.GetInGameConfigWrapper().GetVarValue('fhudInventory', 'fhudResetNewItemsRoach'))
			resetNewItemsInCategories.PushBack("Roach");
		if(theGame.GetInGameConfigWrapper().GetVarValue('fhudInventory', 'fhudResetNewItemsAlchemy'))
			resetNewItemsInCategories.PushBack("Alchemy");
		if(theGame.GetInGameConfigWrapper().GetVarValue('fhudInventory', 'fhudResetNewItemsEquipment'))
			resetNewItemsInCategories.PushBack("Equipment");
		showTrueItemPrice = theGame.GetInGameConfigWrapper().GetVarValue('fhudInventory', 'fhudShowTrueItemPrice');
		showStashItemQuantity = theGame.GetInGameConfigWrapper().GetVarValue('fhudInventory', 'fhudShowStashItemQuantity');
		showRecyclingParts = theGame.GetInGameConfigWrapper().GetVarValue('fhudInventory', 'fhudShowRecyclingParts');
		showItemCountWhenCrafting = theGame.GetInGameConfigWrapper().GetVarValue('fhudInventory', 'fhudShowItemCountWhenCrafting');
		//interactions
		disableAllInteractionPrompts = theGame.GetInGameConfigWrapper().GetVarValue('fhudInteractions', 'fhudDisableAllInteractionPrompts');
		talkBubbleMode = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudInteractions', 'Virtual_fhudTalkBubbleMode'));
		talkButtonMode = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudInteractions', 'Virtual_fhudTalkButtonMode'));
		interactionButtonMode = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudInteractions', 'Virtual_fhudInteractionButtonMode'));
		hideWSInteractionIcons = theGame.GetInGameConfigWrapper().GetVarValue('fhudInteractions', 'fhudHideWSInteractionIcons');
		maxDistanceToShowNames = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('fhudInteractions', 'fhudMaxDistanceToShowNames'));
		maxDistanceToShowNamesInCbt = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('fhudInteractions', 'fhudMaxDistanceToShowNamesInCbt'));
		hideAnimalNames = theGame.GetInGameConfigWrapper().GetVarValue('fhudInteractions', 'fhudHideAnimalNames');
		hideHerbNames = theGame.GetInGameConfigWrapper().GetVarValue('fhudInteractions', 'fhudHideHerbNames');
		hideNPCQuestMarkers = theGame.GetInGameConfigWrapper().GetVarValue('fhudInteractions', 'fhudHideNPCQuestMarkers');
		//misc
		doNotShowDamage = theGame.GetInGameConfigWrapper().GetVarValue('fhudMisc', 'fhudDoNotShowDamage');
		doNotShowLevels = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudMisc', 'Virtual_fhudDoNotShowLevels'));
		showBossHP = theGame.GetInGameConfigWrapper().GetVarValue('fhudMisc', 'fhudShowBossHP');
		silentJournalUpdates = theGame.GetInGameConfigWrapper().GetVarValue('fhudMisc', 'fhudSilentJournalUpdates');
		disableCatWhenNotInDarkPlace = theGame.GetInGameConfigWrapper().GetVarValue('fhudMisc', 'fhudDisableCatWhenNotInDarkPlace');
		enableCatAtNight = theGame.GetInGameConfigWrapper().GetVarValue('fhudMisc', 'fhudEnableCatAtNight');
		//zooms
		mapUnlimitedZoom = theGame.GetInGameConfigWrapper().GetVarValue('fhudMap', 'fhudMapUnlimitedZoom');
		mapZoomMinCoef = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('fhudMap', 'fhudMapZoomMinCoef'));
		mapZoomMaxCoef = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('fhudMap', 'fhudMapZoomMaxCoef'));
		minimapZoomExterior = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('fhudMap', 'fhudMinimapZoomExterior'));
		minimapZoomInterior = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('fhudMap', 'fhudMinimapZoomInterior'));
		minimapZoomBoat = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('fhudMap', 'fhudMinimapZoomBoat'));
		VerifyZoomCoefs();
		UpdateMinimapZoom();
		//update toggleable values
		InitToggleableValues();
		Mod3DMarkersSignalCache3DMarkers( true );
	}
	private function CheckModules()
	{
		if ( !enableCombatModules && IsHUDGroupEnabledForReason( combatModules, "InCombat" ) )
		{
			ToggleCombatModules( false, "InCombat" );
		}
		if ( !enableCombatModulesOnUnsheathe && IsHUDGroupEnabledForReason( combatModules, "OnUnsheathe" ) )
		{
			ToggleCombatModules( false, "OnUnsheathe" );
		}
		if ( !enableWitcherSensesModules && IsHUDGroupEnabledForReason( witcherSensesModules, "WitcherSensesActive" ) )
		{
			ToggleWSModules( false, "WitcherSensesActive" );
		}
		if ( !enableMeditationModules && IsHUDGroupEnabledForReason( meditationModules, "RealTimeMeditation" ) )
		{
			ToggleMeditModules( false, "RealTimeMeditation" );
		}
		if ( !enableRadialMenuModules && IsHUDGroupEnabledForReason( radialMenuModules, "InRadialMenu" ) )
		{
			ToggleModulesToShowInRadialMenu( false, "InRadialMenu" );
		}
	}
	private function VerifyZoomCoefs()
	{
		if( mapZoomMinCoef <= 0 ) mapZoomMinCoef = 1;
		if( mapZoomMaxCoef <= 0 ) mapZoomMaxCoef = 1;
		if( minimapZoomExterior <= 0 ) minimapZoomExterior = 1;
		if( minimapZoomInterior <= 0 ) minimapZoomInterior = 2;
		if( minimapZoomBoat <= 0 ) minimapZoomBoat = 0.5;
	}
	private function UpdateMinimapZoom()
	{
		var hud : CR4ScriptedHud;
		var minimapModule : CR4HudModuleMinimap2;
		hud = (CR4ScriptedHud)theGame.GetHud();
		if( hud )
		{
			minimapModule = (CR4HudModuleMinimap2)hud.GetHudModule( "Minimap2Module" );
			if( minimapModule )
			{
				minimapModule.UpdateZoomForced();
			}
		}
	}
	public function ShowNPCName(target : CNewNPC) : bool
	{
		if( GetFHUDConfig().hideAnimalNames && target.IsAnimal() && !target.HasTag( 'playerHorse' ) )
		{
			return false;
		}
		if( !thePlayer.IsInCombat() && maxDistanceToShowNames > 0 && VecDistance(thePlayer.GetWorldPosition(), target.GetWorldPosition()) > maxDistanceToShowNames )
		{
			return false;
		}
		if( thePlayer.IsInCombat() && maxDistanceToShowNamesInCbt > 0 && VecDistance(thePlayer.GetWorldPosition(), target.GetWorldPosition()) > maxDistanceToShowNamesInCbt )
		{
			return false;
		}
		return true;
	}
	public function ShowInteractionIcon(actionName : string) : bool
	{
		if(disableAllInteractionPrompts)
			return false;
		if(actionName == "Talk")
		{
			return (talkButtonMode == 0 || talkButtonMode == 1);
		}
		return (interactionButtonMode == 0 || interactionButtonMode == 1);
	}
	public function ShowInteractionText(actionName : string) : bool
	{
		if(disableAllInteractionPrompts)
			return false;
		if(actionName == "Talk")
		{
			return (talkButtonMode == 0 || talkButtonMode == 2);
		}
		return (interactionButtonMode == 0 || interactionButtonMode == 2);
	}
	public function ShowEntityIcon(actionName : name) : bool
	{
		if(disableAllInteractionPrompts)
			return false;
		if(actionName == 'Talk')
		{
			return (talkBubbleMode == 0 || talkBubbleMode == 1);
		}
		return (interactionButtonMode == 0 || interactionButtonMode == 1);
	}
	public function ShowEntityText(actionName : name) : bool
	{
		if(disableAllInteractionPrompts)
			return false;
		if(actionName == 'Talk')
		{
			return (talkBubbleMode == 0 || talkBubbleMode == 2);
		}
		return (interactionButtonMode == 0 || interactionButtonMode == 2);
	}
	public function GetBuffsDisplayMode() : EBuffsDisplayMode
	{
		var cfgVal : int;
		cfgVal = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudQuickItems', 'Virtual_fhudDefaultDisplayMode'));
		switch( cfgVal )
		{
			case 0:
				return BDM_ShowPotions;
			case 1:
				return BDM_ShowBombs;
			case 2:
				return BDM_ShowOils;
			case 3:
				return BDM_ShowBuffs;
		}
		return BDM_ShowBuffs;
	}
	public function GetDefautltInventoryTab() : EInventoryFilterType
	{
		var cfgVal : int;
		cfgVal = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudInventory', 'Virtual_fhudDefaultInventoryTab'));
		switch( cfgVal )
		{
			case 0:
				return IFT_Weapons;
			case 1:
				return IFT_AlchemyItems;
			case 2:
				return IFT_Default;
			case 3:
				return IFT_QuestItems;
			case 4:
				return IFT_Ingredients;
		}
		return IFT_Weapons;
	}
}

function GetFHUDConfig() : CModFriendlyHUDConfig
{
	return thePlayer.fHUDConfig;
}
//---=== modFriendlyHUD ===---
