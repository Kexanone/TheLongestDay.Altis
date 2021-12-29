#include "script_component.hpp";

params [
    ["_function", {}, [{}]],
    ["_args", []]
];

[_function, 0, _args, {false}, false, true] call TLD_fnc_perFrameHandler_add;
