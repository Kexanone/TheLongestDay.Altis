#include "script_component.hpp"

params ["_heli", "_role", "_unit"];
if (_role isEqualTo "driver" && {!(_unit isKindOf TLD_HELI_PILOT_CLASS) && _heli isKindOf "Air"}) then {
    moveOut _unit;
    hint localize "STR_TLD_heli_pilotsOnly";
    playSound "FD_Start_F";
};
