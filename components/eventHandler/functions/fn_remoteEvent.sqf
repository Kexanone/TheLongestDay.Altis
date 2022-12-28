#include "script_component.hpp"

params [
    ["_eventName", "", [""]],
    ["_eventArgs", []],
    ["_target", 0],
    ["_jip", false, ["", false, objNull]]
];

// Generate a unique ID by combinding the event name and jip param
if (_jip isEqualType objNull) then {
    private _object = _jip;
    _jip = format ["%1:%2", _eventName, netID _object];
    _object addEventHandler ["deleted", format ["remoteExecCall ["""", ""%1""]", _jip]];
};

[_eventName, _eventArgs] remoteExecCall ["TLD_fnc_localEvent", _target, _jip] // Return value
