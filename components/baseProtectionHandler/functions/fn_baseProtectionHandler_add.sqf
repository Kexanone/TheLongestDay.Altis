#include "script_component.hpp"

// Execute on server
if !(isServer) exitWith {
    _this remoteExeccall [_fnc_scriptName, 2];
};

params ["_entity"];

if (isNil "TLD_baseProtectionHandler_queue") then {
    TLD_baseProtectionHandler_queue = [];
};

TLD_baseProtectionHandler_queue pushBack _entity;
_entity // Return entity as handle
