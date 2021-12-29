#include "script_component.hpp";

["localized_hint", {
    params ["", "_identifier"];
    hint localize _identifier;
}] call TLD_fnc_eventHandler_add;
