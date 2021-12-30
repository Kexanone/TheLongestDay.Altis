#include "script_component.hpp";

private _group = _this call BIS_fnc_spawnGroup;
{
    _x setVehicleLock "LOCKED";
    _x allowCrewInImmobile true;
} forEach ([_group, true] call BIS_fnc_groupVehicles);
_group allowFleeing 0;
_group enableDynamicSimulation true;
_group // return value
