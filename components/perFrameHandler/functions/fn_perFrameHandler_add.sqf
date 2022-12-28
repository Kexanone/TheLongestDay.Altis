#include "script_component.hpp"

params [
    ["_function", {}, [{}]],
    ["_delay", 0, [0]],
    ["_args", [], [[]]],
    ["_condition", {true}, [{}, ""]],
    ["_initalDelay", false, [false]],
    ["_singleExecution", false, [false]]
];

if (isNil "TLD_perFrameHandler_queue") then {
    TLD_perFrameHandler_queue = createHashMap;
};

if (_condition isEqualType "") then {
    _condition = compile _condition;
};

private _handle = selectMax keys TLD_perFrameHandler_queue;
_handle = if (isNil "_handle") then {0} else {_handle + 1};
private _triggerTime = if (_initalDelay) then {time + _delay} else {time};
TLD_perFrameHandler_queue set [_handle, [_function, _delay, _args, _condition, _singleExecution, _triggerTime]];
_handle // Return handle
