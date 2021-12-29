#include "script_component.hpp"

// Client side post init
if (hasInterface) then {
    ["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
};

// Server side post init
if (isServer) then {
    ["Initialize"] call BIS_fnc_dynamicGroups;
    [
        {
            {
                _x params ["_group", "_insignia", "_name"];
               ["RegisterGroup", [_group, leader _group, [_insignia, _name, true]]] call BIS_fnc_dynamicGroups;
            } forEach TLD_INITIAL_GROUP_DATA;
        },
        0.001
    ] call TLD_fnc_waitAndExecute;
};
