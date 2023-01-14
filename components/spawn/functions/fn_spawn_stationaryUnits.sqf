#include "script_component.hpp"

params ["_layerName", "_counts", ["_side", east, [sideUnknown]]];

{
    _x params ["_unitClasses", "_attributesList"];
    _attributesList = _attributesList call BIS_fnc_arrayShuffle;
    private _toSpawn = [];
    for "_" from 1 to (_counts select _forEachIndex) do {
        _toSpawn pushBack selectRandom _unitClasses;
    };
    private _group = [_attributesList select 0 select 0, _side, _toSpawn] call TLD_fnc_spawn_group;
    {
        private _attributes = _attributesList select _forEachIndex;
        _x setPos (_attributes select 0);
        _x setDir (_attributes select 1);
        _x doWatch (getPos _x getPos [300, _attributes select 1]);
        if (count _attributes isEqualTo 3) then {
            _x setUnitPos (_attributes select 2);
        };
        _x disableAI "PATH";
    } forEach (units _group);
} forEach (TLD_spawn_stationaryUnitData get _layerName);
