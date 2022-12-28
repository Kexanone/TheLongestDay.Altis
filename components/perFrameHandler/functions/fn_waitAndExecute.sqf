#include "script_component.hpp"

params [
    ["_function", {}, [{}]],
    ["_delay", 0, [0]],
    ["_args", [], [[]]]
];

[_function, _delay, _args, {true}, true, true] call TLD_fnc_perFrameHandler_add;
