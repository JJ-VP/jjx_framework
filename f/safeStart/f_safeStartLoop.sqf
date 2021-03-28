if !(isServer) exitWith {};

sleep 1;

while {f_var_mission_timer > 0} do {
    [["SafeStart",[format["Time Remaining: %1 min",f_var_mission_timer]]],"bis_fnc_showNotification",true] call BIS_fnc_MP;

    //uisleep 300;
    uisleep 60;

    if (f_var_mission_timer < 0) exitWith {};

    f_var_mission_timer = f_var_mission_timer - 1;
    publicVariable "f_var_mission_timer";
};

if (f_var_mission_timer == 0) then {
    [["SafeStartMissionStarting",["Mission starting now!"]],"bis_fnc_showNotification",true] call BIS_fnc_MP;

    //[[false],"jjx_fnc_safety",playableUnits + switchableUnits] call BIS_fnc_MP;
    [false] call jjx_fnc_safety;
};
