#include "script_component.hpp"

private _filtered = false;
if (headgear player in TLD_HELMET_BLACKLIST) then {
    removeHeadgear player;
    _filtered = true;
};

private _playerOptics = primaryWeaponItems player select 2;
{
    if (_x == _playerOptics) then {
        player removePrimaryWeaponItem _x;
        _filtered = true;
    };
} forEach TLD_OPTICS_BLACKLIST;

private _playerItems = assignedItems player;
{
    if (_x in _playerItems) then {
        player unassignItem _x;
        _filtered = true;
    };
} forEach TLD_NVG_BLACKLIST;
{
    if (_x in _playerItems) then {
        player removeWeapon _x;
        _filtered = true;
    };
} forEach TLD_BINO_BLACKLIST;

_playerItems = (uniformItems player + vestItems player + backpackItems player);
{
    if (_x in _playerItems) then {
        player removeItem _x;
        _filtered = true;
    };
} forEach (TLD_HELMET_BLACKLIST + TLD_OPTICS_BLACKLIST + TLD_NVG_BLACKLIST + TLD_BINO_BLACKLIST);

if (_filtered) then {
    hint localize "STR_TLD_arsenal_tiEquipmentRemoved";
    playSound "FD_Start_F";
};

if (player isKindOf TLD_HELI_PILOT_CLASS) then {
    _filtered = false;
    if (primaryWeapon player isNotEqualTo "") then {
        player removeWeapon primaryWeapon player;
        _filtered = true;
    };
    if (secondaryWeapon player isNotEqualTo "") then {
        player removeWeapon secondaryWeapon player;
        _filtered = true;
    };
    if (handgunWeapon player isNotEqualTo "") then {
        player removeWeapon handgunWeapon player;
        _filtered = true;
    };
    if (_filtered) then {
        hint localize "STR_TLD_arsenal_weaponRemoved";
        playSound "FD_Start_F";
    };
};
