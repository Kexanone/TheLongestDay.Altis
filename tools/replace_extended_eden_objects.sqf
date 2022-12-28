// Execute this script in Eden's debug console to remove all Extended Eden Objects and obtain a SQF script in the clipboard for spawning them as simple objects
rows = [];
{
    private _model = getText (configfile >> "CfgVehicles" >> typeOf _x >> "model");
    rows pushBack format ["    [""%1"", %2, %3, %4]", _model, getPosWorld _x, vectorDir _x, vectorUp _x];
    delete3DENEntities [_x];
} forEach ((all3DENEntities select 0) select {_x isKindOf "Eden_Exended_Object"});
data = rows joinString ("," + endl);
copyToClipboard ("{" + endl + "    (createSimpleObject [_x select 0, _x select 1]) setVectorDirAndUp [_x select 2, _x select 3];" + endl + "} forEach [" + endl + data + endl + "];" + endl);
