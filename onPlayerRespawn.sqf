params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

removeAllActions _oldUnit;
_uid = getPlayerUID _newUnit;

private _clientData = missionNamespace getVariable ["jjx_disconnectedLoadouts", []];
private _uidIndex = _clientData find _uid;
if (_uidIndex > -1) then {
	private _loudoutIndex = _uidIndex + 1;
	(_clientData select _loudoutIndex) call jjx_fnc_loadClientData;
} else {
	["Custom",["Loudout not found","Please save one in the future"]] call BIS_fnc_showNotification;
};

if (f_var_mission_timer > 0) then {
	selfArsenal = player addAction ["<t size=2 color='#0000ff' font='PuristaLight'>Arsenal</t>", {[player, player, true] call ace_arsenal_fnc_openBox;}];
	saveKit = player addAction["<t size=2 color='#00ff00' font='PuristaLight'>Save Kit</t>", {["Custom",["Loudout saved","Loadout will be given on death."]] call BIS_fnc_showNotification;[player] remoteExec ["jjx_fnc_saveKit", 0]}];
};