#include "script_component.hpp"

// Execute on server
if !(isServer) exitWith {
    _this remoteExeccall [_fnc_scriptName, 2];
};

params ["_entity"];

TLD_baseProtectionHandler_queue = TLD_baseProtectionHandler_queue - [_entity];
