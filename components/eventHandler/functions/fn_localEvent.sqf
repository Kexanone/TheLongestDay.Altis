#include "script_component.hpp";

params [
    ["_eventName", "", [""]],
    ["_eventArgs", []]
];

if !(_eventName in TLD_eventHandlers) exitWith {};

{
    _y params ["_handlerFunc", "_handlerArgs"];
    [_handlerArgs, _eventArgs, _x] call _handlerFunc;
} forEach (TLD_eventHandlers get _eventName);
