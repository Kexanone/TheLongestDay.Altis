#include "script_component.hpp"

params [
    ["_outerPolygon", [], [[]]],
    ["_innerPolygon", [], [[]]],
    ["_side", east, [sideUnknown]],
    ["_toSpawn", [], [configFile, []]]
];

private _targetPos = [_outerPolygon, _innerPolygon, TLD_SPAWN_OBJ_DIST] call TLD_fnc_samplePosInPolygon;
private _spawnPos = [
    _targetPos, 4000, 6000, 0, 1, 20, 0,
    allPlayers apply {[getPos _x, 4000]}
] call BIS_fnc_findSafePos;

private _group = [_spawnPos, _side, _toSpawn, [], [], [], [], [], random 360, false] call TLD_fnc_spawn_group;
_group enableDynamicSimulation false;
[_group, _targetPos] call BIS_fnc_taskAttack;
[_group, 0] setWaypointPosition [_targetPos, 10];
private _waypoint = _group addWaypoint [_targetPos, 10];
_waypoint setWaypointType  "CYCLE";
