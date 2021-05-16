if ((roleDescription player) find "Engineer" >= 0) then {
	player setVariable ["ace_isEngineer", 1, true];
};

waituntil {!(IsNull (findDisplay 46))};

if (f_var_mission_timer <= 0) then {
	removeAllActions player;
	selfArsenal = player addAction ["<t size=2 color='#0000ff' font='PuristaLight'>Arsenal</t>", {[player, player, true] call ace_arsenal_fnc_openBox;}];
	saveKit = player addAction["<t size=2 color='#00ff00' font='PuristaLight'>Save Kit</t>", {["Custom",["Loudout saved","Loadout will be given on death."]] call BIS_fnc_showNotification;[player] remoteExec ["jjx_fnc_saveKit", 0]}];
	_this spawn {uiSleep 120;player removeAction selfArsenal;player removeAction saveKit;}
};

if ((player getVariable "ace_isEngineer") >= 1) then {
	edn_fortification_keydown = (findDisplay 46) displayAddEventHandler ["KeyDown","_this call edn_fnc_keyCheck"];
};

_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", 'if (_this select 1 == 59) then {if (!(isNull (findDisplay 999))) exitWith {closeDialog 0;};if (!(isNull (findDisplay 998))) exitWith {closeDialog 0;};createDialog "jjx_menu";}'];


[] spawn {
   while {true} do {
        player setVariable ["PlayerFPS", floor diag_fps, true];
        if (isDamageAllowed player) then {
        	player setVariable ["jjx_god", false, true];
        } else {
        	player setVariable ["jjx_god", true, true];
        };
        if (userInputDisabled) then {
        	player setVariable ["jjx_frozen", true, true];
        } else {
        	player setVariable ["jjx_frozen", false, true];
        };
        sleep 0.1;
    };
};

player setVariable ["steamName", profileNameSteam, true]; //Set the players steamname into a variable that can be read by the server

while {true} do {
	waituntil {!(IsNull (findDisplay 312))};
	_keyDown2 = (findDisplay 312) displayAddEventHandler ["KeyDown", 'if (_this select 1 == 59) then {if (!(isNull (findDisplay 999))) exitWith {closeDialog 0;};if (!(isNull (findDisplay 998))) exitWith {closeDialog 0;};createDialog "jjx_menu";}'];
	waituntil {IsNull (findDisplay 312)};
	findDisplay 312 displayRemoveEventHandler ["keyDown",_keyDown2];
};
