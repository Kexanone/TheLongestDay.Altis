#include "script_component.hpp"

params [
    ["_eventName", "", [""]],
    ["_eventArgs", []],
    ["_jip", false, ["", false, objNull]]
];

[_eventName, _eventArgs] remoteExecCall ["TLD_fnc_localEvent", 0, _jip];
