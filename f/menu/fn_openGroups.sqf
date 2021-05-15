_uid = getPlayerUID player;
if (_uid in jjx_admin) then {
	closeDialog 0;
	createDialog "jjx_groupMenu";
};

if (isMultiplayer) then {
	jjx_group_players = {playerList = allPlayers;}; //If multiplayer playerList = all players
	publicVariable "playerList";
} else {
	jjx_group_players = {playerList = switchableUnits;}; //If singleplayer playerList = switchable units
	publicVariable "playerList";
};

jjx_group_update = {
	while {!isNull (findDisplay 995)} do {
		call jjx_group_players;
		allGroupsWithPlayers = [];
		{allGroupsWithPlayers pushBackUnique group _x} forEach allPlayers;
		{
			lbadd [1521, str(_x)];
			lbSetData [1521, _x]
		} forEach allGroupsWithPlayers;
		if (lbCurSel 1521 == -1) then {
			{
				lbAdd [1520, name _x];
			} forEach playerList;
		} else {
			{
				lbAdd [1520, name _x];
			} forEach units (allGroupsWithPlayers select (lbCurSel 1521));
		};
		uiSleep 0.05;
		lbClear 1520;
		lbClear 1521;
	};
};

jjx_group_rename = {
	if (lbCurSel 1521 == -1) then {
		[] spawn {hintSilent "You didn't select a group";uiSleep 3; hintSilent "";};
	} else {
		if (ctrlText 1420 == "") then {
			[] spawn {hintSilent "You didn't specify a name";uiSleep 3; hintSilent "";};
			systemChat str(ctrlText 1420);
		} else {
			_group = (allGroupsWithPlayers select (lbCurSel 1521));
			_name = ctrlText 1420;
			_oldName = groupID _group;
			_group setGroupIDGlobal [_name];
			[_oldName,_name] spawn {hintSilent parseText format ["Renamed <br /><t color='#42ebf4'>%1</t> to <t color='#42ebf4'>%2</t>", _this select 0, _this select 1];uiSleep 3; hintSilent "";};
		};
	};
};

[] spawn jjx_group_update;