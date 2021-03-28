_uid = getPlayerUID player;
if (_uid in jjx_admin) then {
	closeDialog 0;
	createDialog "jjx_adminMenu";
};