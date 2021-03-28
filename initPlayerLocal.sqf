if ((roleDescription player) find "Engineer" >= 0) then {
	player setVariable ["ace_isEngineer", 1, true];
};

waituntil {!(IsNull (findDisplay 46))};

if ((player getVariable "ace_isEngineer") >= 1) then {
	edn_fortification_keydown = (findDisplay 46) displayAddEventHandler ["KeyDown","_this call edn_fnc_keyCheck"];
};

_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", 'if (_this select 1 == 59) then {if (!(isNull (findDisplay 999))) exitWith {closeDialog 0;};if (!(isNull (findDisplay 998))) exitWith {closeDialog 0;};createDialog "jjx_menu";}'];

[] spawn {
   while {true} do {
        player setVariable ["PlayerFPS", floor diag_fps, true];
        sleep 0.1;
    };
};

waitUntil {_adminState = call BIS_fnc_admin; sleep 0.5; (!isNull (findDisplay 312)) || (_adminState == 2)};
addMissionEventHandler ["Draw3D", {
	{
		_distance = (ATLToASL (positionCameraToWorld [0,0,0])) distance _x;
		if (_distance < 800) then {
			_playerFPS = _x getVariable ["PlayerFPS", -1];
			if (_playerFPS == -1) then
			{
				drawIcon3D
				["", [1,0.65,0,1], ASLToAGL getPosASL _x, 1, 2, 0, "FPS Error", 2, 0.03, "PuristaMedium", "center"];
			}
			else {
				if (_playerFPS  <20) then 
				{
					drawIcon3D
					["", [1,0,0,1], ASLToAGL getPosASL _x, 1, 2, 0, format["%1 FPS: %2", name _x, str _playerFPS], 2, 0.05, "PuristaMedium", "center"];
				}
				else
				{
					drawIcon3D
					["", [0,1,0,0.8], ASLToAGL getPosASL _x, 1, 2, 0, format["%1 FPS: %2", name _x, str _playerFPS], 2, 0.03,"PuristaMedium", "center"];
				};
			}
		};
	} forEach allPlayers;
}];