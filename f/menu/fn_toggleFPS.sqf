if (isNil "toggle") then {
	toggle = true;
};

if (toggle) then {
	toggle = false;
	fpsHandler = addMissionEventHandler ["Draw3D", {
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
} else {
	toggle = true;
	removeMissionEventHandler ["Draw3D", fpsHandler];
};