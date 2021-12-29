#include "script_component.hpp"

// Client side post init
if !(hasInterface) exitWith {};

// Fix for Zeus: Reassign curator module on respawn
["TLD_playerRespawned", {
    params ["", "_eventArgs"];
    _eventArgs params ["_newUnit", "_oldUnit"];

private _curatorLogic = getAssignedCuratorLogic _oldUnit;
if !(isNull _curatorLogic) then {
    [_newUnit, _curatorLogic] remoteExecCall ["assignCurator", 2];
};
}] call TLD_fnc_eventHandler_add;
