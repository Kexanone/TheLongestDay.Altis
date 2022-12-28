#include "script_component.hpp"

// Server side post init
if (isServer) then {
    private _skill = 0.01 * ("Skill" call BIS_fnc_getParamValue);
    {_x setSkill _skill} forEach allUnits;
};
