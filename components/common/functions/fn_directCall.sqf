#include "script_component.hpp"

params [
    ["_code", {}, [{}]],
    ["_args",[]]
];

isNil {_args call _code};
