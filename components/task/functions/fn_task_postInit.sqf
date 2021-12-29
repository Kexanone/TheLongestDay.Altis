#include "script_component.hpp";

// Client side post init
if (hasInterface) then {
    player createDiaryRecord ["Diary", [localize "str_dn_vehicles", localize "STR_TLD_briefing_assets_description"]];
    player createDiaryRecord ["Diary", [localize "str_a3_diary_signal_title", localize "STR_TLD_briefing_signal_description"]];
    player createDiaryRecord ["Diary", [localize "str_a3_diary_execution_title", localize "STR_TLD_briefing_execution_description"]];
    player createDiaryRecord ["Diary", [localize "str_a3_diary_mission_title", localize "STR_TLD_briefing_mission_description"]];
    player createDiaryRecord ["Diary", [localize "str_a3_diary_situation_title", localize "STR_TLD_briefing_situation_description"]];
};

// Server side post init
if (isServer) then {
    [] call TLD_fnc_task_stageOne;
};
