#include "script_component.hpp"

params ["_vehicle"];

private _handle = _vehicle getVariable ["TLD_desertedHandle", scriptNull];
if !(isNull _handle) then {terminate _handle};
