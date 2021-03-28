params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

removeAllActions _oldUnit;

if (isNil {playerLoadout}) then {
	["Custom",["Loudout not found","Please save one in the future"]] call BIS_fnc_showNotification;
} else {
	_newUnit setUnitLoadout [playerLoadout, true];
};

if (f_var_mission_timer > 0) then {
	selfArsenal = player addAction ["Arsenal", {[player, player, true] call ace_arsenal_fnc_openBox;}];
    saveKit = player addAction["Save Kit", {["Custom",["Loudout saved","Loadout will be given on death."]] call BIS_fnc_showNotification;playerLoadout = getUnitLoadout [player, true];}];
};