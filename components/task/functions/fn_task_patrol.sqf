#include "script_component.hpp";

params [
    ["_group", grpNull, [grpNull]],
    ["_outerPolygon", [], [[]]],
    ["_innerPolygon", [], [[]]],
    ["_nWaypoints", 5, [0]],
    ["_timeoutDist", [0, 5, 10], [[]]]
];

private _i = 1;
private _prevPos = getPos leader _group;
while {_i <= _nWaypoints} do {
    private _pos =  [_outerPolygon, _innerPolygon] call TLD_fnc_samplePosInPolygon;
    // Only accept new point if 
    // 1) New position is far enough from the previous one
    // 2) The resulting line does not intersect with the inner polygon
    if (_pos distance2D _prevPos >= 50 && {!([[_pos, _prevPos], _innerPolygon] call TLD_fnc_segmentIntersectsPolygon2D)}) then {
        private _waypoint = _group addWaypoint [_pos, 10, _i];
        _waypoint setWaypointTimeout _timeoutDist;
        _prevPos = _pos;
        _i = _i + 1;
    };
};

if (_nWaypoints >= 1) then {
    private _waypoint = [_group, 1];
    _waypoint setWaypointBehaviour "SAFE";
    _waypoint setWaypointSpeed "LIMITED";
    _waypoint setWaypointFormation "COLUMN";

    _waypoint = _group addWaypoint [_prevPos, 10, _nWaypoints + 1];
    _waypoint setWaypointType  "CYCLE";
};
