#include "script_component.hpp";

_this spawn {
    params [
        ["_group", grpNull, [grpNull]],
        ["_timeoutDist", [20, 35, 60], [[]]]
    ];

    {
        _x disableAI "PATH";
    } forEach units _group;

    while {count units _group > 0} do {
        {
            _x doWatch (getPos _x getPos [300, random 360]);
        } forEach units _group;
        sleep random _timeoutDist;
    };
};
