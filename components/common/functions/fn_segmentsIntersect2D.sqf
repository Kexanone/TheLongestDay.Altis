#include "script_component.hpp"
// Reference: https://www.geeksforgeeks.org/check-if-two-given-line-segments-intersect/

params [
    ["_segment1", [], [[]], 2],
    ["_segment2", [], [[]], 2]
];
_segment1 params [
    ["_p1", [], [[]]],
    ["_q1", [], [[]]]
];
_segment2 params [
    ["_p2", [], [[]]],
    ["_q2", [], [[]]]
];

private _orientations = [
    [_p1, _q1, _p2],
    [_p1, _q1, _q2],
    [_p2, _q2, _p1],
    [_p2, _q2, _q1]
] apply {
    _x params ["_p", "_q", "_r"];
    private _val = ((_q#1 - _p#1) * (_r#0 - _q#0)) - ((_q#0 - _p#0) * (_r#1 - _q#1));
    switch (true) do {
        case (_val > 0): {1}; // Clockwise orientation
        case (_val < 0): {2}; // Counterclockwise orientation
        default {0}; // Collinear orientation
    }
};

private _onSegmentList = [
    [_p1, _p2, _q1],
    [_p1, _q2, _q1],
    [_p2, _p1, _q2],
    [_p2, _q1, _q2]
] apply {
    _x params ["_p", "_q", "_r"];
    private _val = _q#0 <= (_p#0 max _r#0);
    _val = _val && {_q#0 >= (_p#0 min _r#0)};
    _val = _val && {_q#1 <= (_p#1 max _r#1)};
    _val = _val && {_q#1 >= (_p#1 min _r#1)};
    _val
};

// General case
if ((_orientations#0 != _orientations#1) && {_orientations#2 != _orientations#3}) exitWith {true}; // return value

// Special Cases
// p1 , q1 and p2 are collinear and p2 lies on segment p1q1
if ((_orientations#0 == 0) && {_onSegmentList#0}) exitWith {true}; // return value
// p1 , q1 and q2 are collinear and q2 lies on segment p1q1
if ((_orientations#1 == 0) && {_onSegmentList#1}) exitWith {true}; // return value
// p2 , q2 and p1 are collinear and p1 lies on segment p2q2
if ((_orientations#2 == 0) && {_onSegmentList#2}) exitWith {true}; // return value
// p2 , q2 and q1 are collinear and q1 lies on segment p2q2
if ((_orientations#3 == 0) && {_onSegmentList#3}) exitWith {true}; // return value

// If none of the cases
false // return value
