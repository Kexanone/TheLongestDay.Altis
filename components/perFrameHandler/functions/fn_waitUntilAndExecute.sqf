#include "script_component.hpp";

params [
    ["_condition", {}, [{}]],
    ["_function", {}, [{}]],
    ["_delay", 0, [0]],
    ["_args", [], [[]]]
];

[_function, _delay, _args, _condition, false, true] call TLD_fnc_perFrameHandler_add;
