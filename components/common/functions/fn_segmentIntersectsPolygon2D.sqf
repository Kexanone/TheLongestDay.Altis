#include "script_component.hpp";

params [
    ["_segment", [], [[]], 2],
    ["_polygon", [], [[]]]
];
private _return = false;
private _n = count _polygon;
if (_n isEqualTo 0) exitWith {_return}; // return value

for "_i" from 0 to (_n - 2) do {
    diag_log format ["%1 | %2 | %3 | %4", _i, _segment, _polygon select [_i, 2], [_segment, _polygon select [_i, 2]] call TLD_fnc_segmentsIntersect2D];
    if ([_segment, _polygon select [_i, 2]] call TLD_fnc_segmentsIntersect2D) exitWith {_return = true};
};
if !(_return) then {
    _return = [_segment, [_polygon#0, _polygon#(_n - 1)]] call TLD_fnc_segmentsIntersect2D;
};
_return // return value
