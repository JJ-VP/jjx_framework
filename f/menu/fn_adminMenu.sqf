/*
 * fn_adminMenu.sqf
 * Author: JJ
 *
 * Args:
 * nil (No arguments)
 *
 * Return Value:
 * nil (No return)
 *
 * This function opens the admin menu and adds data to the menu
 */

#define jjx_admin_red [ 1, 0.22, 0.22, 1]
#define jjx_admin_green [ 0.22, 0.7, 0.2, 1]

_isAdmin = player call jjx_fnc_isAdmin;

if (!_isAdmin) exitWith {};

[_isAdmin] spawn {
	while {_this select 0} do { //Stop admins from getting frozen
		waitUntil {userInputDisabled};
		disableUserInput false;
		hintSilent parseText format ["%1 Someone tried to freeze you!<br />Don't worry, I saved you", hintHeader];[] spawn {uiSleep 4;hintSilent "";};
	};
};


jjx_admin_open = {
	if (!isNull (findDisplay -1)) exitWith {closeDialog 2;}; //If menu is already open, close it
	createDialog "adminMenu"; //Open the menu
	waitUntil {!isNull (findDisplay -1)}; //Wait for the menu to be open
	[] spawn jjx_admin_update; //Spawn the update function
	[] spawn jjx_loadout_update;
};

jjx_admin_update = {
	while {!isNull (findDisplay -1)} do {
		call jjx_admin_players;
		{
			lbAdd [1500, name _x];
			((findDisplay -1) displayCtrl 1500) ctrlSetEventHandler ["LBDblClick", "call jjx_admin_playerInfo"];
			lbSetTooltip [1500, _forEachIndex, format ["Name: %1 ~ Steam: %2 ~ UID: %3", name _x, _x getVariable "steamName", getPlayerUID _x]];
		} forEach playerList; //For all online players, add them to the player list in the GUI

		_allLoadouts = profileNamespace getVariable ["jjx_loadouts", []];
		_loadoutIndex = 0;
		{
			_name = _allLoadouts select _loadoutIndex select 0 select 0;
			lbAdd [1502, _name];
			_loadoutIndex = _loadoutIndex + 1;
		} forEach _allLoadouts;

		_isAdmin = player call jjx_fnc_isAdmin;

		features = [];
		{
			features pushback _x;
		} forEach featuresOff; publicVariable "features";

		{
			switch(_x select 1) do {
				case "god": {
					if ((lbCurSel 1500) != -1) then {
						if (isNil {((playerList select (lbCurSel 1500)) getVariable "jjx_god")} || {!((playerList select (lbCurSel 1500)) getVariable "jjx_god")}) then {
							lbAdd [1501, format ["%1 - OFF", _x select 0]];
							lbSetColor [1501,  _forEachIndex, jjx_admin_red];
							lbSetTooltip [1501, _forEachIndex, _x select 3];
						} else {
							lbAdd [1501, format ["%1 - ON", _x select 0]];
							lbSetColor [1501, _forEachIndex, jjx_admin_green];
							lbSetTooltip [1501, _forEachIndex, _x select 3];
						};
					} else {
						lbAdd [1501, format ["%1 - OFF", _x select 0]];
						lbSetColor [1501,  _forEachIndex, jjx_admin_red];
						lbSetTooltip [1501, _forEachIndex, _x select 3];
					};
				};
				case "mapTP": {
					if ((lbCurSel 1500) != -1) then {
						if (isNil {((playerList select (lbCurSel 1500)) getVariable "jjx_mapTP")} || {!((playerList select (lbCurSel 1500)) getVariable "jjx_mapTP")}) then {
							lbAdd [1501, format ["%1 - OFF", _x select 0]];
							lbSetColor [1501,  _forEachIndex, jjx_admin_red];
							lbSetTooltip [1501, _forEachIndex, _x select 3];
						} else {
							lbAdd [1501, format ["%1 - ON", _x select 0]];
							lbSetColor [1501, _forEachIndex, jjx_admin_green];
							lbSetTooltip [1501, _forEachIndex, _x select 3];
						};
					} else {
						lbAdd [1501, format ["%1 - OFF", _x select 0]];
						lbSetColor [1501,  _forEachIndex, jjx_admin_red];
						lbSetTooltip [1501, _forEachIndex, _x select 3];
					};
				};
				case "freeze": {
					if ((lbCurSel 1500) != -1) then {
						if (isNil {((playerList select (lbCurSel 1500)) getVariable "jjx_frozen")} || {!((playerList select (lbCurSel 1500)) getVariable "jjx_frozen")}) then {
							lbAdd [1501, format ["%1 - OFF", _x select 0]];
							lbSetColor [1501,  _forEachIndex, jjx_admin_red];
							lbSetTooltip [1501, _forEachIndex, _x select 3];
						} else {
							lbAdd [1501, format ["%1 - ON", _x select 0]];
							lbSetColor [1501, _forEachIndex, jjx_admin_green];
							lbSetTooltip [1501, _forEachIndex, _x select 3];
						};
					} else {
						lbAdd [1501, format ["%1 - OFF", _x select 0]];
						lbSetColor [1501,  _forEachIndex, jjx_admin_red];
						lbSetTooltip [1501, _forEachIndex, _x select 3];
					};
				};
				case "markers": {
					if ((lbCurSel 1500) != -1) then {
						if (isNil {((playerList select (lbCurSel 1500)) getVariable "mapMarkers")} || {!((playerList select (lbCurSel 1500)) getVariable "mapMarkers")}) then {
							lbAdd [1501, format ["%1 - OFF", _x select 0]];
							lbSetColor [1501,  _forEachIndex, jjx_admin_red];
							lbSetTooltip [1501, _forEachIndex, _x select 3];
						} else {
							lbAdd [1501, format ["%1 - ON", _x select 0]];
							lbSetColor [1501, _forEachIndex, jjx_admin_green];
							lbSetTooltip [1501, _forEachIndex, _x select 3];
						};
					} else {
						lbAdd [1501, format ["%1 - OFF", _x select 0]];
						lbSetColor [1501,  _forEachIndex, jjx_admin_red];
						lbSetTooltip [1501, _forEachIndex, _x select 3];
					};
				};
				//next case...
				default {
					lbAdd [1501, _x select 0];
					lbSetTooltip [1501, _forEachIndex, _x select 3];
				};
			};
		} forEach features; //If a feature is specified here it will have custom formatting applied to it.

		uiSleep 0.05; //Menu refresh rate (currently 20Hz)
		lbClear 1500; //Clear the players list
		lbClear 1501; //Clear the features list
		lbClear 1502; //Clear the loadout list
	};
};





//ADMIN MENU 





jjx_admin_exec = {
	params ["_player","_feature"];
	if (_feature != -1) then { //If a feature is selected
		if ((features select _feature) select 2) then { //If the feature has its "Player required" field set to true
			if (_player != -1) then { //If a player is selected
				_code = format ["[%1] spawn jjx_admin_%2", _player, (features select _feature) select 1];
				call compile _code;
			} else { //If a player isn't selected
				hintSilent parseText format ["%1 To execute <t color='#f45f42'>%2</t> you need to select a player", hintHeader, (features select _feature) select 0];[] spawn {;uiSleep 4;hintSilent "";};
			};
		} else { //If the feature has its "Player required" field set to false
			_code = format ["[] spawn jjx_admin_%1", (features select _feature) select 1];
			call compile _code;
			};
	} else { //If a feature isn't selected
		hintSilent parseText format ["%1 Select a feature", hintHeader]; //Tell the user to select a feature
	};
};
publicVariable "jjx_admin_exec";

jjx_admin_init = {
	hintHeader = "<t color='#41f48c' size='2'>JJx Admin Menu</t><br /><t size='0.68'>by JJ</t><br />-------- -_- --------<br /><br />";
	publicVariable hintHeader;

	features = [];
	featuresOff = [ //List of all features to display in the format ["Display Name", "funmctionName","Requires Player selected", "ToolTip"],
		//Need to test if I can add a header / spacer (actions)
		["Kill", "kill", true, "Select a player to kill"],
		["Heal", "heal", true, "Select a player to heal"],
		["TP to player", "tpToPlayer", true, "Select a player to teleport to"],
		["TP player here", "tpPlayerHere", true, "Select a player to teleport them here"],
		["Repair", "repair", true, "Select a player to repair their vehicle or don't select a player to repair whatever you are looking at"],
		["Delete", "delete", false, "Select a player to delete their vehicle or don't select a player to delete whatever you are looking at"],
		["Explode vehicle", "explode", true, "Select a player to destroy their vehicle"],
		["Destroy vehicle", "destroy", true, "Select a player to destroy their vehicle (No explosion)"],
		["Spectate", "spectator", true, "Select a player to spectate"],
		["Freecam", "freecam", true, "Select a player to put them into freecam"],
		["Arsenal", "arsenal", true, "Select a player to open the arsenal for them"],
		["Garage", "garage", true, "Select a player to open the garage for them"],
		["Take loadout", "takeLoadout", true, "Select a player to take their loadout"],
		["Give loadout", "giveLoadout", true, "Select a player to give them your loadout"],
		["Piss", "pee", true, "Make the player you select have the sudden urge to piss"],
		//Header / spacer (Toggleable)
		["God", "god", true, "Select a player to toggle their imortality"],
		["Map TP", "mapTP", true, "Select a player to toggle their map teleportation"],
		["Freeze", "freeze", true, "Select a player to toggle freeze them"],
		["Map Markers", "markers", true, "Select a player to toggle map markers for them"],
		//Header /spacer (Utility)
		["Go to lobby", "lobby", true, "Select a player to send them to the lobby"],
		["Player info", "info", true, "Get info on the selected player"]
	];
	publicVariable "featuresOff";

	if (isMultiplayer) then {
		jjx_admin_players = {playerList = allPlayers;}; //If multiplayer playerList = all players
		publicVariable "playerList";
	} else {
		jjx_admin_players = {playerList = switchableUnits;}; //If not multiplayer playerList = switchable units
		publicVariable "playerList";
	};

	call jjx_admin_players;
};

jjx_admin_start = {
	waitUntil {time > 0};
	if (_isAdmin) then { //If UID is in jjx_admin
		call jjx_admin_init; //Initalise menu
		call jjx_admin_publishVar; //Turn all functions into public variables
		waitUntil{!isNull (findDisplay 46)}; //Wait untill the game screen is avalible
		call jjx_admin_open; //Open the menu
	};
};

jjx_admin_playerInfo = { //Returns the In-game name, Steam name, UID and current loadout of the selected player
	params["_idc", "_selectedIndex"];
	_infoName = format ["Name: %1", name (playerList select _selectedIndex)];
	_infoSteam = format ["Steam: %1", (playerList select _selectedIndex) getVariable "steamName"];
	_infoUID = format ["UID: %1", getPlayerUID (playerList select _selectedIndex)];
	_infoLoadout = getUnitLoadout (playerList select _selectedIndex);
	copyToClipboard format ["%1 -> %2 ~ %3 ~ %4 ~~ -_- ~~ Loadout below %5", "JJX admin menu", _infoName, _infoSteam, _infoUID, _infoLoadout];
	hintSilent parseText format ["%1 %2 <br /> %3 <br /> %4 <br /><br /> <t size='1.6' color='#f45f42'>The players equipment was copied to clipboard, press CTRL+V in a note program to paste it.</t>", hintHeader, _infoName, _infoSteam, _infoUID]; [] spawn {uiSleep 4;hintSilent "";};
}; 


// FEATURES BELOW


jjx_admin_kill = {
	params["_selectedIndex"];
	_player = playerList select _selectedIndex;
	hintSilent parseText format ["%1You killed<br/><t color='#42ebf4'>%2</t>", hintHeader, name _player];
	(player setDamage 1) remoteExec ["call", _player];
	uiSleep 3;hintSilent "";
};

jjx_admin_heal = {
	params["_selectedIndex"];
	_player = playerList select _selectedIndex;
	if (isClass (configFile >> 'CfgPatches' >> 'ace_main')) then {
		[player] remoteExecCall ["ace_medical_treatment_fnc_fullHealLocal", _player];
		hintSilent parseText format ["%1You Ace healed<br/><t color='#42ebf4'>%2</t>", hintHeader, name _player];
	} else {
		(_player setDamage 0) remoteExec ["call", _player];
		hintSilent parseText format ["%1You healed<br/><t color='#42ebf4'>%2</t>", hintHeader, name _player];
	};
	uiSleep 3;hintSilent "";
};

jjx_admin_god = {
	params["_selectedIndex"];
	_player = playerList select _selectedIndex;
	if (isDamageAllowed _player) then {
		_player allowDamage false;
		hintSilent parseText format ["%1You made<br/><t color='#42ebf4'>%2</t><br />immortal", hintHeader, name _player];uiSleep 3;hintSilent "";
	} else {
		_player allowDamage true;
		hintSilent parseText format ["%1You made<br/><t color='#42ebf4'>%2</t><br />mortal", hintHeader, name _player];uiSleep 3;hintSilent "";
	};
};

jjx_admin_tpToPlayer = {
	params["_selectedIndex"];
	_player = playerList select _selectedIndex;
	hintSilent parseText format ["%1You teleported to<br/><t color='#42ebf4'>%2</t>", hintHeader, name _player];
	player setPosASL (getPosASL _player);
	uiSleep 3;hintSilent "";
};

jjx_admin_tpPlayerHere = {
	params["_selectedIndex"];
	_player = playerList select _selectedIndex;
	hintSilent parseText format ["%1You teleported<br/><t color='#42ebf4'>%2</t><br />to you", hintHeader, name _player];
	_player setPosASL (getPosASL player);
	uiSleep 3;hintSilent "";
};

jjx_admin_mapTP = {
	params["_selectedIndex"];
	_player = playerList select _selectedIndex;
	hintSilent parseText format ["%1You toggled map TP for<br/><t color='#42ebf4'>%2</t>", hintHeader, name _player];
	remoteExec ["jjx_admin_mapTPExec", _player];
	uiSleep 3;hintSilent "";
};
jjx_admin_mapTPExec = {
	if ((isNil {player getVariable "jjx_mapTP"}) || {!(player getVariable "jjx_mapTP")}) then {
		player setVariable ["jjx_mapTP", true, true];
		hint parseText format ["%1 An admin has enabled map teleportation for you!<br /><t color='#f45f42'>ALT + click</t><br />on the map to teleport", hintHeader];
		player onMapSingleClick "if (_alt) then { player setPosATL _pos }";
		uiSleep 5;hintSilent "";
	} else {
		player setVariable ["jjx_mapTP", false, true];
		hint parseText format ["%1 An admin has disabled map teleportation for you!", hintHeader];
		player onMapSingleClick "if (_alt) then {};";
		uiSleep 5;hintSilent "";
	};
};

jjx_admin_freeze = {
	params["_selectedIndex"];
	_player = playerList select _selectedIndex;
	if (_player == player) then {
		hintSilent parseText format ["%1You tried to freeze yourself!<br />Don't worry I saved you", hintHeader];uiSleep 3;hintSilent "";
	} else {
		hintSilent parseText format ["%1You toggled freeze for<br/><t color='#42ebf4'>%2</t>", hintHeader, name _player];
		remoteExec ["jjx_admin_freezeExec", _player];
		uiSleep 3;hintSilent "";
	};
};
jjx_admin_freezeExec = {
	if (userInputDisabled) then {
		disableUserInput false;
		player setVariable ["jjx_frozen", false, true];
	} else {
		disableUserInput true;
		player setVariable ["jjx_frozen", true, true];
	};
};

jjx_admin_repair = {
	params["_selectedIndex"];
	_player = playerList select _selectedIndex;
	hintSilent parseText format ["%1You repaired<br/><t color='#42ebf4'>%2's</t><br />vehicle", hintHeader, name _player];
	if (local objectParent _player) then {
		objectParent _player setDamage 0;
	} else {
		"objectParent player setDamage 0;" remoteExec ["call", owner _vehicle];
	};
	uiSleep 3;hintSilent "";
};

jjx_admin_delete = {
	if !(isNull objectParent player) then {
		hintSilent parseText format ["%1You deleted<br/><t color='#42ebf4'>your vehicle</t>", hintHeader];
		deleteVehicle (objectParent player);
		uiSleep 3;hintSilent "";
	} else {
		hintSilent parseText format ["%1You deleted<br/><t color='#42ebf4'>%2</t>", hintHeader, typeOf cursorObject];
		deleteVehicle cursorObject;
		uiSleep 3;hintSilent "";
	};
};

jjx_admin_explode = {
	params["_selectedIndex"];
	_player = playerList select _selectedIndex;
	hintSilent parseText format ["%1You exploded<br/><t color='#42ebf4'>%2's</t><br />vehicle", hintHeader, name _player];
	if (local objectParent _player) then {
		objectParent _player setDamage [1, true];
	} else {
		"objectParent _player setDamage [1, true];" remoteExec ["call", owner _vehicle];
	};
	uiSleep 3;hintSilent "";
};
jjx_admin_destroy = {
	params["_selectedIndex"];
	_player = playerList select _selectedIndex;
	hintSilent parseText format ["%1You destroyed<br/><t color='#42ebf4'>%2's</t><br />vehicle", hintHeader, name _player];
	if (local objectParent _player) then {
		objectParent _player setDamage [1, false];
	} else {
		"objectParent _player setDamage [1, false];" remoteExec ["call", owner _vehicle];
	};
	uiSleep 3;hintSilent "";
};

jjx_admin_spectator = {
	params["_selectedIndex"];
	_player = playerList select _selectedIndex;
	hintSilent parseText format ["%1You are now spectating<br/><t color='#42ebf4'>%2</t><br />to stop spectating press F10", hintHeader, name _player];
	_player switchCamera "INTERNAL";
	stopSpectating = (findDisplay 46) displayAddEventHandler ["KeyDown",
		"if ((_this select 1) == 68) then {
			(findDisplay 46) displayRemoveEventHandler ['KeyDown', stopSpectating];
			player switchCamera 'INTERNAL';
		};false"
	];
	uiSleep 3;hintSilent "";
};

jjx_admin_markers = {
	params["_selectedIndex"];
	if (isNil "_selectedIndex") then {
		call jjx_admin_markersExec;
	} else {
		_player = playerList select _selectedIndex;
		hintSilent parseText format ["%1You enabled map markers for<br/><t color='#42ebf4'>%2</t>", hintHeader, name _player];
		remoteExec ["jjx_admin_markersExec", _player];
		uiSleep 3;hintSilent "";
	};
};
jjx_admin_markersExec = {
	if (((isNil {player getVariable "mapMarkers"}) || (isNil {player getVariable "markerList"})) || {!(player getVariable "mapMarkers")}) then {
		player setVariable ["mapMarkers", true, true];
		player setVariable ["markerList", [], true];
		{
			pName = "";
			{pName = pName + _x; pName} forEach ((name _x) splitString " ");
			_markerTest = format ["marker_%1", pName];
			if (!(_markerTest in allMapMarkers)) then {
				_code = format ['createMarkerLocal ["marker_%1", [%2, %3]];
				"marker_%1" setMarkerShapeLocal "ICON";
				"marker_%1" setMarkerTypeLocal "mil_dot";
				"marker_%1" setMarkerColorLocal "ColorPink";
				"marker_%1" setMarkerTextLocal "%1";
				', pName, (position _x select 0), (position _x select 1)];
				call compile _code;
				(player getVariable "markerList") pushback _x;
			};
		} forEach allPlayers;

		[] spawn {
			while {(player getVariable "mapMarkers")} do {
				{
					sName = "";
					{sName = sName + _x; sName} forEach ((name _x) splitString " ");
					_code = format ['"marker_%1" setMarkerPosLocal [%2, %3]',
					sName, (position _x select 0), (position _x select 1)];
					call compile _code;
				} forEach (player getVariable "markerList");
				uiSleep 0.01;
			};
		};
		exit;
	} else {
		player setVariable ["mapMarkers", false, true];
		{
			xName = "";
			{xName = xName + _x; xName} forEach ((name _x) splitString " ");
			deleteMarkerLocal format ["marker_%1", xName];
		} forEach (player getVariable "markerList");

		player setVariable ["markerList", [], true];
	};
};

jjx_admin_freecam = {
	params["_selectedIndex"];
	_player = playerList select _selectedIndex;
	hintSilent parseText format ["%1You put<br/><t color='#42ebf4'>%2</t><br />in to spectator", hintHeader, name _player];
	([] execVM "a3\functions_f\Debug\fn_camera.sqf") remoteExec ["call", _player];
	uiSleep 3;hintSilent "";
};

jjx_admin_lobby = {
	params["_selectedIndex"];
	_player = playerList select _selectedIndex;
	hintSilent parseText format ["%1You sent<br/><t color='#42ebf4'>%2</t><br />to the lobby", hintHeader, name _player];
	((findDisplay 46) closeDisplay 0)remoteExec ["call", _player];
	uiSleep 3;hintSilent "";
};

jjx_admin_arsenal = {
	params["_selectedIndex"];
	_player = playerList select _selectedIndex;
	hintSilent parseText format ["%1You put<br/><t color='#42ebf4'>%2</t><br />in to the arsenal", hintHeader, name _player];
	if (isClass (configFile >> 'CfgPatches' >> 'ace_main')) then {
		([player, player, true] call ace_arsenal_fnc_openBox) remoteExec ["call", _player];
	} else {
		["Open", true] remoteExec ["BIS_fnc_arsenal", _player];
	};
	uiSleep 3;hintSilent "";
};

jjx_admin_garage = {
	params["_selectedIndex"];
	_player = playerList select _selectedIndex;
	hintSilent parseText format ["%1You put<br/><t color='#42ebf4'>%2</t><br />in to the garage", hintHeader, name _player];
	["Open", true] remoteExec ["BIS_fnc_garage", _player];
	uiSleep 3;hintSilent "";
};

jjx_admin_takeLoadout = {
	params["_selectedIndex"];
	_player = playerList select _selectedIndex;
	hintSilent parseText format ["%1You took<br/><t color='#42ebf4'>%2's</t><br />loadout", hintHeader, name _player];
	player setUnitLoadout (getUnitLoadout _player);
	uiSleep 3;hintSilent "";
};

jjx_admin_giveLoadout = {
	params["_selectedIndex"];
	_player = playerList select _selectedIndex;
	hintSilent parseText format ["%1You gave<br/><t color='#42ebf4'>%2</t><br />your loadout", hintHeader, name _player];
	_player setUnitLoadout (getUnitLoadout player);
	uiSleep 3;hintSilent "";
};

jjx_admin_info = {
	params["_selectedIndex"];
	_player = playerList select _selectedIndex;
	hintSilent parseText format ["%1<t size='1.2' color='#f4e242'>Name: </t><br />%2<br /><br /><t size='1.2' color='#f4e242'>UID: </t><br />%3<br /><br /><t size='1.2' color='#f4e242'>Position: </t><br />%4<br /><br /><t size='1.2' color='#f4e242'>Equiptment: </t><br />%5<br /><br /><t size='1.6' color='#f45f42'>Player equipment copied to clipboard.</t>", hintHeader, name _player, getPlayerUID _player, position _player, getUnitLoadout _player];
	copyToClipboard str(getUnitLoadout _player);
	uiSleep 10;hintSilent "";
};

jjx_admin_pee = {
	params["_selectedIndex"];
	_player = playerList select _selectedIndex;
	hintSilent parseText format ["%1You made<br/><t color='#42ebf4'>%2</t><br />have a sudden urge to pee", hintHeader, name _player];
	remoteExec ["jjx_admin_peeExec", _player];
	uiSleep 3;hintSilent "";
};
jjx_admin_peeExec = {
	player playMove "Acts_AidlPercMstpSlowWrflDnon_pissing"; sleep 4;
	player allowDamage true; 
	player enableSimulation true;
	player enableSimulationGlobal true;
	player triggerDynamicSimulation true;
	_updateDir = true;
	[_updateDir] spawn {
		while {_this select 0} do {
			pissDir = getDir player;
			uiSleep 0.05;
		};
	};
	[] spawn {
		_stream = "#particlesource" createVehicleLocal [0,0,0];
		_stream setParticleRandom [0,[0.004,0.004,0.004],[0.01,0.01,0.01],30,0.01,[0,0,0,0],1,0.02,360];
		_stream setDropInterval 0.001;
		_stream attachTo [player,[0.1,0.15,-0.10],"Pelvis"] ;
		for "_i" from 0 to 1 step 0.01 do { _stream setParticleParams [["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,3,[0,0,0],[sin (pissDir) * _i,cos (pissDir) * _i,0],0,1.5,1,0.1,[0.02,0.02,0.1],[[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]]; sleep 0.02; }; sleep 4;
		for "_i" from 1 to 0.4 step -0.01 do { _stream setParticleParams [["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,3,[0,0,0],[sin (pissDir) * _i,cos (pissDir) * _i,0],0,1.5,1,0.1,[0.02,0.02,0.1],[[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]]; sleep 0.02;};
		for "_i" from 0.4 to 0.8 step 0.02 do { _stream setParticleParams [["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,3,[0,0,0],[sin (pissDir) * _i,cos (pissDir) * _i,0],0,1.5,1,0.1,[0.02,0.02,0.1],[[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]]; sleep 0.0};
		for "_i" from 0.8 to 0.2 step -0.01 do { _stream setParticleParams [["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,3,[0,0,0],[sin (pissDir) * _i,cos (pissDir) * _i,0],0,1.5,1,0.1,[0.02,0.02,0.1],[[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]]; sleep 0.02;};
		for "_i" from 0.2 to 0.3 step 0.02 do { _stream setParticleParams [["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,3,[0,0,0],[sin (pissDir) * _i,cos (pissDir) * _i,0],0,1.5,1,0.1,[0.02,0.02,0.1],[[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]]; sleep 0.02;};
		for "_i" from 0.3 to 0.1 step -0.01 do { _stream setParticleParams [["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,3,[0,0,0],[sin (pissDir) * _i,cos (pissDir) * _i,0],0,1.5,1,0.1,[0.02,0.02,0.1],[[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]]; sleep 0.02;};
		for "_i" from 0.1 to 0 step -0.01 do { _stream setParticleParams [["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,3,[0,0,0],[sin (pissDir) * _i,cos (pissDir) * _i,0],0,1.5,1,0.1,[0.02,0.02,0.1],[[0.8,0.7,0.2,_i],[0.8,0.7,0.2,_i],[0.8,0.7,0.2,0]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]]; sleep 0.02;};
		deleteVehicle _stream;
	};
	sleep 4.12;
	_updateDir = false;
};

// LOADOUT MENU

jjx_loadout_save = {
	_loadoutName = ctrlText 1400;
	if (_loadoutName != "") then {
		_currentLoadout = getUnitLoadout player; 
		_allLoadouts = profileNamespace getVariable ["jjx_loadouts", []]; 
		_allLoadouts append [[[_loadoutName], _currentLoadout]]; 
		profileNamespace setVariable ["jjx_loadouts", _allLoadouts];
		[_loadoutName] spawn {hintSilent parseText format ["%1You created loadout<br/><t color='#42ebf4'>%2</t>", hintHeader, _this select 0];}
	} else { 
		[] spawn {hintSilent parseText format ["%1You need to specify a loadout name", hintHeader];uiSleep 3;hintSilent "";}
	};
};

jjx_loadout_load = {
	_index = lbCurSel 1502;
	if (_index != -1) then {
		_allLoadouts = profileNamespace getVariable ["jjx_loadouts", []];
		_name = lbText [1502, _index];
		_loadout = _allLoadouts select _index select 1;
		player setUnitLoadout _loadout;
		[_name] spawn {hintSilent parseText format ["%1You equiped loadout<br/><t color='#42ebf4'>%2</t>", hintHeader, _this select 0];}
	} else { 
		[] spawn {hintSilent parseText format ["%1You need to select a loadout", hintHeader];uiSleep 3;hintSilent "";} 
	};
};

jjx_loadout_delete = {
	_index = lbCurSel 1502;
	if (_index != -1) then {
		_allLoadouts = profileNamespace getVariable ["jjx_loadouts", []];
		_name = lbText [1502, _index];
		_allLoadouts deleteAt _index;
		profileNamespace setVariable ["jjx_loadouts", _allLoadouts];
		[_name] spawn {hintSilent parseText format ["%1You deleted loadout<br/><t color='#42ebf4'>%2</t>", hintHeader, _this select 0];}
	} else { 
		[] spawn {hintSilent parseText format ["%1You need to select a loadout", hintHeader];uiSleep 3;hintSilent "";}
	};
};

// AFTER

jjx_admin_publishVar = {
	{
	publicVariable format ["jjx_admin_%1", _x select 1]; //Turn all functions into public variables
	} forEach featuresOff;
};

call jjx_admin_start; //Start the menu
