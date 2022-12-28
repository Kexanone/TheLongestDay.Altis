#include "script_component.hpp"

// Client side pre init
if (hasInterface) then {
    private _code = {
        private _identity = switch (typeOf player) do {
            case "B_Story_SF_Captain_F": {"EPA_B_Miller"};
            case "B_CTRG_soldier_M_medic_F": {"EPA_B_James"};
            case "B_CTRG_soldier_AR_A_F": {"EPA_B_McKay"};
            case "B_CTRG_soldier_GL_LAT_F": {"EPA_B_Northgate"};
            case "B_CTRG_Sharphooter_F": {"EPA_B_Armorer"};
            case "B_CTRG_soldier_engineer_exp_F": {"EPA_B_Hardy"};
            default {""};
        };
        if (_identity isNotEqualTo "") then {
            ["TLD_setIdentity", [player, _identity], player] call TLD_fnc_globalEvent;
        };
    };

    ["TLD_playerRespawned", _code] call TLD_fnc_eventHandler_add;
    [missionnamespace, "arsenalClosed", _code] call BIS_fnc_addScriptedEventHandler;
};
