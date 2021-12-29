#include "script_component.hpp";

// Radar
{
    _x params ["_toSpawn", ["_count", 1, [0]]];
    for "_i" from 1 to _count do {
        [TLD_RADAR_OUTER_POLYGON, TLD_RADAR_INNER_POLYGON, east, _toSpawn] call TLD_fnc_spawn_patrol;
    };
} forEach [
    [configFile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_reconSquad", 2]
];

// Factory
{
    _x params ["_toSpawn", ["_count", 1, [0]]];
    for "_i" from 1 to _count do {
        [TLD_FACTORY_OUTER_POLYGON, TLD_FACTORY_INNER_POLYGON, east, _toSpawn] call TLD_fnc_spawn_patrol;
    };
} forEach [
    [configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_ReconSquad", 2],
    [configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA", 2]
];


// Xian
{
    _x params ["_toSpawn", ["_count", 1, [0]]];
    for "_i" from 1 to _count do {
        [TLD_XIAN_OUTER_POLYGON, TLD_XIAN_INNER_POLYGON, east, _toSpawn] call TLD_fnc_spawn_patrol;
    };
} forEach [
    configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Mechanized" >> "OIA_MechInf_AT",
    configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Mechanized" >> "OIA_MechInfSquad",
    configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad",
    configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad_Weapons",
    configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfAssault"
];
