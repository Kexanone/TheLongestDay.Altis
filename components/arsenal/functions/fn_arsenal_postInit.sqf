#include "script_component.hpp"

// Client side post init
if !(hasInterface) exitWith {};

// Remove all thermal imaging
// Remove weapons from pilots
// Load last arsenal respawn

["Preload"] call BIS_fnc_arsenal;
BIS_fnc_arsenal_data set [6, (BIS_fnc_arsenal_data select 6) - TLD_HELMET_BLACKLIST];
BIS_fnc_arsenal_data set [8, (BIS_fnc_arsenal_data select 8) - TLD_NVG_BLACKLIST];
BIS_fnc_arsenal_data set [9, (BIS_fnc_arsenal_data select 9) - TLD_BINO_BLACKLIST];
player setVariable ["TLD_loadout", getUnitLoadout player];

[missionnamespace, "arsenalClosed", {
    [] call TLD_fnc_arsenal_filterPlayerInventory;
    player setVariable ["TLD_loadout", getUnitLoadout player];
}] call BIS_fnc_addScriptedEventHandler;

player addEventHandler ["InventoryClosed", {
    params ["", "_container"];
    private _other = objectParent _container;
    if (isPlayer _other) then {
        [] remoteExecCall ["TLD_fnc_arsenal_filterPlayerInventory", _other];
    };
    [] call TLD_fnc_arsenal_filterPlayerInventory;
}];

["TLD_playerRespawned", {
    player setUnitLoadout (player getVariable "TLD_loadout")
}] call TLD_fnc_eventHandler_add;

// Disable thermals on darter
player addEventHandler ["WeaponAssembled", {
    params ["", "_weapon"];
    _weapon disableTIEquipment true
}];

if (player isKindOf TLD_HELI_PILOT_CLASS) then {
    inGameUISetEventHandler ["Action", "
        params ['', '', '', '_engineName'];
        if (_engineName in ['TakeWeapon', 'Takebag']) then {
            hint localize 'STR_TLD_arsenal_cannotTakeWeapon';
            playSound 'FD_Start_F';
            true
        } else {
            false
        };
    "];
};
