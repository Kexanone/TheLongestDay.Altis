#include "script_component.hpp"

params ["_oldVehicle"];

if (isNull _oldVehicle) exitWith {};

private _vehicleType = _oldVehicle getVariable "TLD_respawnVehicleType";
private _respawnPos = _oldVehicle getVariable "TLD_respawnPos";
private _respawnDir = _oldVehicle getVariable "TLD_respawnDir";
deleteVehicle _oldVehicle;

[{
    params ["_args"];
    _args params ["_vehicleType", "_respawnPos", "_respawnDir"];
    private _newVehicle = createVehicle [_vehicleType, [0,0,0], [], 0, "CAN_COLLIDE"];
    _newVehicle setPosWorld _respawnPos;
    _newVehicle setDir _respawnDir;
    [_newVehicle] call TLD_fnc_vehicleRespawn_add;

    private _vehicleCfg = configfile >> "CfgVehicles" >> _vehicleType;
    private _displayName = getText (_vehicleCfg >> "displayName");
    private _picture = (gettext (_vehicleCfg >> "picture")) call BIS_fnc_textureVehicleIcon;
    private _respawnName = format [localize "STR_A3_BIS_fnc_respawnMenuPosition_grid", mapGridPosition (getPos _newVehicle)];
    ["RespawnVehicle", [_displayName,_respawnName,_picture]] remoteExecCall ["BIS_fnc_showNotification", west];
}, [_vehicleType, _respawnPos, _respawnDir]] call TLD_fnc_execNextFrame;
