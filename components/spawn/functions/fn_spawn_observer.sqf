#include "script_component.hpp";

params [
    ["_outerPolygon", [], [[]]],
    ["_innerPolygon", [], [[]]],
    ["_side", east, [sideUnknown]],
    ["_toSpawn", [], [configFile, []]]
];

private _group = [
    [_outerPolygon, _innerPolygon] call TLD_fnc_samplePosInPolygon,
    _side, _toSpawn, [], [], [], [], [], random 360, false
] call TLD_fnc_spawn_group;
[_group] call TLD_fnc_task_observe;
_group // return value
