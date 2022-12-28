#include "script_component.hpp"

params ["", "", "_toSpawn", ["_relPositions", [], [[]]]];
// Fix relative positions unless they are already specified via group config or
// via the _relPositions argument
// Prevents units from being spawned on top of each other
if (_toSpawn isEqualType [] && {_relPositions isEqualTo []}) then {
    private _type = _toSpawn select 0;
    private _offset = switch (true) do {
        case (_type isKindOf "Man"): {5};
        case (_type isKindOf "Air"): {50};
        default {10};
    };

    private _relPos = [0, 0, 0];
    for "_i" from 0 to count _toSpawn - 1 do {
        _relPos set [1, -(_relPos select 1)];
        if (_i mod 2 isEqualTo 1) then {
            _relPos = _relPos vectorAdd [-_offset, _offset, 0]
        };
        _relPositions pushBack +_relPos;
    };
};

private _group = _this call BIS_fnc_spawnGroup;
{
    _x setVehicleLock "LOCKED";
    _x allowCrewInImmobile true;
    _x enableDynamicSimulation true;
} forEach ([_group, true] call BIS_fnc_groupVehicles);
private _skill = 0.01 * ("Skill" call BIS_fnc_getParamValue);
{_x setSkill _skill} forEach units _group;
_group allowFleeing 0;
_group enableDynamicSimulation true;
_group // return value
