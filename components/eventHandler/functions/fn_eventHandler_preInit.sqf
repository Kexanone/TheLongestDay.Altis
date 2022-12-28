#include "script_component.hpp"

if (isNil "TLD_eventHandlers") then {
    TLD_eventHandlers = createHashMap;
};
