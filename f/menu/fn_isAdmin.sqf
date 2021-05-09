/*
 * fn_isAdmin.sqf
 * Author: JJ
 *
 * Args:
 * 1: the player you want to check if they are an admin <OBJECT>
 *
 * Return Value:
 * True if player is admin, false if not admin <BOOL>
 *
 */

params["_player"];

_uid = getPlayerUID _player;

if (_uid in jjx_admin) exitWith {true};

false
