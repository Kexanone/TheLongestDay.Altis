#include "script_component.hpp"

params [
    ["_function", {}, [{}]],
    ["_args", []]
];

[_function, 0, _args, format["diag_frameno > %1", diag_frameno], false, true] call TLD_fnc_perFrameHandler_add;
