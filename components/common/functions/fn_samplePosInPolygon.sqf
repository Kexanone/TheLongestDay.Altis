#include "script_component.hpp"

params [
    ["_outerPolygon", [], [[]]],
    ["_innerPolygon", [], [[]]],
    ["_objDist", -1, [0]]
];

private _fnc_isSafe = if (_objDist >= 0) then {
    {
        params ["_pos", "_objDist"];
        // find if not safe
        (nearestObjects [_pos, [],  50 + _objDist, true]) findIf {
            (_pos distance2D _x) < ((sizeOf typeOf _x) / 2 + _objDist)
        } isEqualTo -1
    }
} else {
    {true}
};

private _center = [0, 0, 0];
{
    _center = _center vectorAdd _x;
} forEach _outerPolygon;
_center = _center vectorMultiply (1 / count _outerPolygon);

private _radius = 0;
{
    private _distance = _center distance2D _x;
    if (_distance > _radius) then {
        _radius = _distance;
    };
} forEach _outerPolygon;

private _pos = [0, 0, 0];
while {!(_pos inPolygon _outerPolygon) || {_pos inPolygon _innerPolygon || {!([_pos, _objDist] call _fnc_isSafe)}}} do {
    private _dir = random 360;
    private _distance = _radius * sqrt random 1;
    _pos = _center getPos [_distance, _dir];
};

_pos
