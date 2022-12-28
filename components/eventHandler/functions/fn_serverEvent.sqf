#include "script_component.hpp"

params [
    ["_eventName", "", [""]],
    ["_eventArgs", []]
];

[_eventName, _eventArgs, 2] call TLD_fnc_remoteEvent // Return value
