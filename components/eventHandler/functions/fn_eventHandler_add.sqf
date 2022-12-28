#include "script_component.hpp"

params [
    ["_eventName", "", [""]],
    ["_handlerFunc", {}, [{}]]
];

if (isNil "TLD_eventHandlers") then {
    TLD_eventHandlers = createHashMap;
};

private ["_queue", "_handle"];

if (_eventName in TLD_eventHandlers) then {
    _queue = TLD_eventHandlers get _eventName;
    _handle = selectMax keys _queue + 1;
} else {
    _queue = createHashMap;
    _handle = 0;
};
_queue set [_handle, _handlerFunc];
TLD_eventHandlers set [_eventName, _queue];
_handle // Return handle
