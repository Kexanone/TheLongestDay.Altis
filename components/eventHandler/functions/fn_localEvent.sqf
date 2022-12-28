#include "script_component.hpp"

params [
    ["_eventName", "", [""]],
    ["_eventArgs", []]
];

if !(_eventName in TLD_eventHandlers) exitWith {};

{
    _eventArgs call _y;
} forEach (TLD_eventHandlers get _eventName);
