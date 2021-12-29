#include "script_component.hpp";

params [
    ["_outerPolygon", [], [[]]],
    ["_innerPolygon", [], [[]]],
    ["_side", east, [sideUnknown]],
    ["_toSpawn", [], [configFile, []]]
];

private _group = [
    [_outerPolygon, _innerPolygon] call TLD_fnc_samplePosInPolygon,
    _side,
    _toSpawn
] call BIS_fnc_spawnGroup;
[_group, _outerPolygon, _innerPolygon] call TLD_fnc_spawn_taskPatrol;
_group enableDynamicSimulation true;
