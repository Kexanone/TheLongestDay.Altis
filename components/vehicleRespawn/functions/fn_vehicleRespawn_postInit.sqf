#include "script_component.hpp"

// Server side post init
if !(isServer) exitWith {};

// Set deserted distance inside base
["TLD_baseProtection_enable", {
    params ["_entity"];
    if !(isNil {_entity getVariable "TLD_desertedDistance"}) then {
        _entity setVariable ["TLD_desertedDistance", VEHILCE_RESPAWN_DESERTED_DISTANCE_PROTECTED];
    };
}] call TLD_fnc_eventHandler_add;

// Fix for base protection: Destroy vehicles under water
["TLD_baseProtection_stillEnabled", {
    params ["_entity"];
    if (_entity isKindOf "Air" && {underwater _entity}) then {
        _entity setDamage 1;
    };
}] call TLD_fnc_eventHandler_add;

// Set deserted distance outside base
["TLD_baseProtection_disable", {
    params ["_entity"];
    if !(isNil {_entity getVariable "TLD_desertedDistance"}) then {
        _entity setVariable ["TLD_desertedDistance", VEHILCE_RESPAWN_DESERTED_DISTANCE];
    };
}] call TLD_fnc_eventHandler_add;
