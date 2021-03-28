params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

removeAllActions _oldUnit;

if (isNil {playerLoadout}) then {
	hintSilent "Loudout not found\nPlease save one in the future";
} else {
	_newUnit setUnitLoadout [playerLoadout, true];
};