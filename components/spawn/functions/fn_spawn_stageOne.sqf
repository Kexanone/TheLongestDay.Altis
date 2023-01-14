#include "script_component.hpp"

// Radar
{
    _x params ["_toSpawn", ["_count", 1, [0]]];
    for "_i" from 1 to _count do {
        [TLD_RADAR_OUTER_POLYGON, TLD_RADAR_INNER_POLYGON, east, _toSpawn] call TLD_fnc_spawn_patrol;
    };
} forEach [
    [configFile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_ReconSquad", 2]
];
["TLD_destroyRadar", [
    3 + round random 1,
    3 + round random 1,
    1
]] call TLD_fnc_spawn_stationaryUnits;

// Factory
{
    _x params ["_toSpawn", ["_count", 1, [0]]];
    for "_i" from 1 to _count do {
        [TLD_FACTORY_OUTER_POLYGON, TLD_FACTORY_INNER_POLYGON, east, _toSpawn] call TLD_fnc_spawn_patrol;
    };
} forEach [
    [["O_APC_Wheeled_02_rcws_v2_F"], 1],
    [configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_ReconSquad", 2],
    [configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA", 2]
];
{
    _x params ["_toSpawn", ["_count", 1, [0]]];
    for "_i" from 1 to _count do {
        [TLD_FACTORY_INNER_POLYGON, [], east, _toSpawn] call TLD_fnc_spawn_observer;
    };
} forEach [
    [["O_APC_Wheeled_02_rcws_v2_F"], 1],
    [["O_APC_Tracked_02_cannon_F"], 1]
];
["TLD_destroyFactory", [
    2 + round random 1,
    3 + round random 1,
    3 + round random 1,
    2 + round random 2,
    8 + round random 2
]] call TLD_fnc_spawn_stationaryUnits;

// Xian
{
    _x params ["_toSpawn", ["_count", 1, [0]]];
    for "_i" from 1 to _count do {
        [TLD_XIAN_OUTER_POLYGON, TLD_XIAN_INNER_POLYGON, east, _toSpawn] call TLD_fnc_spawn_patrol;
    };
} forEach [
    configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Mechanized" >> "OIA_MechInfSquad",
    configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad",
    configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfAssault"
];
{
    _x params ["_toSpawn", ["_count", 1, [0]]];
    for "_i" from 1 to _count do {
        [TLD_XIAN_INNER_POLYGON, [], east, _toSpawn] call TLD_fnc_spawn_patrol;
    };
} forEach [
    configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam",
    configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA"
];
{
    _x params ["_toSpawn", ["_count", 1, [0]]];
    for "_i" from 1 to _count do {
        [TLD_XIAN_INNER_POLYGON, [], east, _toSpawn] call TLD_fnc_spawn_observer;
    };
} forEach [
    [["O_APC_Tracked_02_cannon_F"], 1]
];
["TLD_destroyXians", [
    4 + round random 2,
    5,
    1
]] call TLD_fnc_spawn_stationaryUnits;
{
    private _handle = _x  addEventHandler ["Killed", {
        [TLD_XIAN_INNER_POLYGON, [], east,
            ["O_Heli_Attack_02_black_F", "O_Heli_Attack_02_black_F"]
        ] call TLD_fnc_spawn_quickReactionForce;
        {
            private _handle = _x getVariable "TLD_spawn_killedHandle";
            _x removeEventHandler ["Killed", _handle];
        } forEach TLD_XIANS;
    }];
    _x setVariable ["TLD_spawn_killedHandle", _handle];
} forEach TLD_XIANS;
