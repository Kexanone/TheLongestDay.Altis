#include "script_component.hpp";

if (isNil "TLD_perFrameHandler_queue") then {
    TLD_perFrameHandler_queue = createHashMap;
};

[
    "TLD_perFrameHandler_worker", "onEachFrame", {
        {
            _y params ["_function", "_delay", "_args", "_condition", "_singleExecution", "_triggerTime"];
            if (time >= _triggerTime && {_args call _condition}) then {
                [_args, _x] call _function;
                if (_singleExecution) then {
                    _x call TLD_fnc_perFrameHandler_remove;
                } else {
                    _y set [5, _triggerTime + _delay];
                };
            };
        } forEach TLD_perFrameHandler_queue;
    }
] call BIS_fnc_addStackedEventHandler;
