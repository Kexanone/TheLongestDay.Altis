#include "script_component.hpp"

// Client side pre init
if (hasInterface) then {
    // Fix for Zeus: Reassign curator module on respawn
    ["TLD_playerRespawned", {
        params ["_newUnit", "_oldUnit"];

        private _curatorLogic = getAssignedCuratorLogic _oldUnit;
        if !(isNull _curatorLogic) then {
            ["TLD_assignCurator", [_newUnit, _curatorLogic]] call TLD_fnc_serverEvent;
        };
        ["TLD_addCuratorEditableObjects", [_newUnit]] call TLD_fnc_serverEvent;
    }] call TLD_fnc_eventHandler_add;
};

// Server side pre init
if (isServer) then {
   ["TLD_vehicleRespawned", {
        params ["_newHeli"];

        ["TLD_addCuratorEditableObjects", [_newHeli]] call TLD_fnc_serverEvent;
    }] call TLD_fnc_eventHandler_add;
};
