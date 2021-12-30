#include "script_component.hpp";

// Collab
{
    _x params ["_toSpawn", ["_count", 1, [0]]];
    for "_i" from 1 to _count do {
        [TLD_COLLAB_OUTER_POLYGON, TLD_COLLAB_INNER_POLYGON, east, _toSpawn] call TLD_fnc_spawn_patrol;
    };
} forEach [
    [["O_G_Offroad_01_armed_F"], 2],
    [configFile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_ReconSquad", 2],
    [configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_ReconTeam", 1]
];

// Comms
{
    _x params ["_toSpawn", ["_count", 1, [0]]];
    for "_i" from 1 to _count do {
        [TLD_COMMS_OUTER_POLYGON, TLD_COMMS_MIDDLE_POLYGON, east, _toSpawn] call TLD_fnc_spawn_patrol;
    };
} forEach [
    [configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Mechanized" >> "OIA_MechInf_AT", 1],
    [["O_MRAP_02_hmg_F"], 1],
    [["O_UGV_01_rcws_F"], 2],
    [configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_ReconSquad", 1],
    [configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA", 2]
];
{
    _x params ["_toSpawn", ["_count", 1, [0]]];
    for "_i" from 1 to _count do {
        [TLD_COMMS_MIDDLE_POLYGON, TLD_COMMS_INNER_POLYGON, east, _toSpawn] call TLD_fnc_spawn_patrol;
    };
} forEach [
    [configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam", 3]
];
{
    _x params ["_toSpawn", ["_count", 1, [0]]];
    for "_i" from 1 to _count do {
        [TLD_COMMS_OUTER_POLYGON, TLD_COMMS_MIDDLE_POLYGON, east, _toSpawn] call TLD_fnc_spawn_observer;
    };
} forEach [
    [["O_APC_Tracked_02_AA_F"], 1]
];

// Varsuk
{
    _x params ["_toSpawn", ["_count", 1, [0]]];
    for "_i" from 1 to _count do {
        [TLD_VARSUKS_OUTER_POLYGON, TLD_VARSUKS_MIDDLE_POLYGON, east, _toSpawn] call TLD_fnc_spawn_patrol;
    };
} forEach [
    [["O_MRAP_02_gmg_F"], 1],
    [["O_MRAP_02_hmg_F"], 1],
    [["O_UGV_01_rcws_F"], 2],
    [configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_ReconSquad", 2]
];
{
    _x params ["_toSpawn", ["_count", 1, [0]]];
    for "_i" from 1 to _count do {
        [TLD_VARSUKS_MIDDLE_POLYGON, TLD_VARSUKS_INNER_POLYGON, east, _toSpawn] call TLD_fnc_spawn_patrol;
    };
} forEach [
    [configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardSquad", 2],
    [configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam", 2],
    [configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardSentry", 1]
];
{
    _x params ["_toSpawn", ["_count", 1, [0]]];
    for "_i" from 1 to _count do {
        [TLD_VARSUKS_OUTER_POLYGON, TLD_VARSUKS_MIDDLE_POLYGON, east, _toSpawn] call TLD_fnc_spawn_observer;
    };
} forEach [
    [["O_APC_Tracked_02_AA_F"], 3]
];
