#include "script_component.hpp";

params [
    ["_eventName", "", [""]],
    ["_handle", -1, [0]]
];

private _queue = TLD_eventHandlers get _eventName;
_queue deleteAt _handle;
if (count _queue isEqualTo 0) then {
    TLD_eventHandlers deleteAt _eventName;
};
