#include "script_component.hpp"

_this call BIS_fnc_taskSetState;
["TLD_task_stateUpdated", _this] call TLD_fnc_localEvent;
