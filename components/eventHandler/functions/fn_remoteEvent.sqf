#include "script_component.hpp";

params [
    ["_eventName", "", [""]],
    ["_args", []],
    ["_target", 0],
    ["_jip", false]
];

// Generate a unique ID by combinding the event name and jip param
if (_jip isEqualType objNull || {_jip isEqualType grpNull}) then {
    _jip = netID _jip;
};
if (_jip isEqualType "") then {
    _jip = format ["%1:%2", _eventName, _jip];
};

[_eventName, _args] remoteExecCall ["TLD_fnc_localEvent", _target, _jip];
