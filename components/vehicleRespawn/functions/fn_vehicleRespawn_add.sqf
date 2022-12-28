#include "script_component.hpp"

params ["_vehicle"];

// Execute on server
if !(isServer) exitWith {[_vehicle] remoteExecCall ["TLD_fnc_vehicleRespawn_add", 2]};

removeFromRemainsCollector [_vehicle];

if (isNil {_vehicle getVariable "TLD_respawnVehicleType"}) then {
    _vehicle setVariable ["TLD_respawnVehicleType", typeOf _vehicle];
    _vehicle setVariable ["TLD_respawnPos", getPosWorld _vehicle];
    _vehicle setVariable ["TLD_respawnDir", getDir _vehicle];
};
_vehicle setVariable ["TLD_desertedDelay", VEHILCE_RESPAWN_DESERTED_DELAY];
_vehicle setVariable ["TLD_desertedDistance", VEHILCE_RESPAWN_DESERTED_DISTANCE_PROTECTED];
_vehicle call TLD_fnc_desertedHandler_add;

_vehicle addMPEventHandler ["MPKilled", {
    if (isServer) then {
        params ["_vehicle"];
        _vehicle call TLD_fnc_desertedHandler_remove;
        _vehicle spawn {
            private _delay = _this getVariable "TLD_desertedDelay";
            sleep _delay;
            [TLD_fnc_respawnVehicle, _this] call TLD_fnc_directCall;
        };
    };
}];

["TLD_vehicleRespawned", [_vehicle, objNull]] call TLD_fnc_localEvent;
