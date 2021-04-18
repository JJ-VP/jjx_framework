_adminState = call BIS_fnc_admin;
_uid = getPlayerUID player;
if ((_adminState isEqualTo 2) || (_uid in jjx_admin)) then {
	closeDialog 0;
	createDialog "jjx_zeusMenu";
};