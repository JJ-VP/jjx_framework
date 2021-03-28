_uid = getPlayerUID player;
if (_uid in jjx_timer) then {
	closeDialog 0;
	createDialog "jjx_timerMenu";
};