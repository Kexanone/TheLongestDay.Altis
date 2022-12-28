#include "script_component.hpp"

if (hasInterface) then {
    ["TLD_intro", "onPreloadFinished", {
        ["TLD_intro", "onPreloadFinished"] call BIS_fnc_removeStackedEventHandler;
        [] call TLD_fnc_intro;
    }] call BIS_fnc_addStackedEventHandler;
};
