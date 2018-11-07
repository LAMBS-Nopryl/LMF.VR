/*
  Function: diwako_unknownwp_fnc_reloadedEh

  Description:
    Reloaded evenhandler function

  Parameters:
    Reloaded EH arguments

  Returns:
    nothing

  Author:
  diwako 2018-10-26
*/
params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];

if !(primaryWeapon ace_player == _weapon) exitWith {};
if (isNil "diwako_unknownwp_weapon_whitelist") exitWith {};

private _weaponUpper = toUpper(_weapon);
if !(_weaponUpper in diwako_unknownwp_weapon_whitelist || {_weaponUpper in diwako_unknownwp_local_weapons}) then {
  // weapon not in whitelist
  if ( (random 100) <= diwako_unknownwp_reload_failure ) then {
    // reload failed
    ace_player addMagazine [_newMagazine#0, _newMagazine#1];
    ace_player setAmmo [_weapon, 0];

    [{["Reload failed"] call ace_common_fnc_displayTextStructured;}, []] call CBA_fnc_execNextFrame;
  };
};