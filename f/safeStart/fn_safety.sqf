params ["_safetyOn"];
if(isDedicated) exitwith {};

switch (_safetyOn) do {
    case true: {
        if (isNil "f_eh_safetyMan") then {
            f_eh_safetyMan = player addEventHandler["Fired", {
                params ["","","","","","","_projectile"];
                deletevehicle _projectile;
            }];
        };

        if (vehicle player != player && {player in [gunner vehicle player,driver vehicle player,commander vehicle player]}) then {
            player setVariable ["f_var_safetyVeh",vehicle player];
            (player getVariable "f_var_safetyVeh") allowDamage false;

            if (isNil "f_eh_safetyVeh") then {
                f_eh_safetyVeh = (player getVariable "f_var_safetyVeh") addEventHandler["Fired", {
                params ["","","","","","","_projectile"];
                deletevehicle _projectile;
                }];
            };
        };

        player allowDamage false;
        _selfArsenal = player addAction ["Arsenal", {[player, player, true] call ace_arsenal_fnc_openBox;}];
    };

    case false;
    default {

        if !(isNil "f_eh_safetyMan") then {
            player removeEventhandler ["Fired", f_eh_safetyMan];
            f_eh_safetyMan = nil;
        };

        if !(isNull(player getVariable ["f_var_safetyVeh",objnull])) then {
            (player getVariable "f_var_safetyVeh") allowDamage true;

            if !(isNil "f_eh_safetyVeh") then {
                (player getVariable "f_var_safetyVeh") removeeventhandler ["Fired", f_eh_safetyVeh];
                f_eh_safetyVeh = nil;
            };
            player setVariable ["f_var_safetyVeh",nil];
        };

        player allowDamage true;
        player removeAction _selfArsenal;
    };
};
