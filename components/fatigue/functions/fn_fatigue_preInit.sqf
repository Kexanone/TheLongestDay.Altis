#include "script_component.hpp";

// Client side pre init
if (hasInterface) then {
    // Disable fatigue on player respawn
    ["TLD_playerRespawned", {
        params ["", "_eventArgs"];
        _eventArgs params ["_newUnit"];

        _newUnit enableFatigue ((["Fatigue", 0] call BIS_fnc_getParamValue) isEqualTo 1);
    }] call TLD_fnc_eventHandler_add;
};
