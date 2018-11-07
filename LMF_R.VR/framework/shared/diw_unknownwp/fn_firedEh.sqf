/*
  Function: diwako_unknownwp_fnc_firedEh

  Description:
    Fired evenhandler function

  Parameters:
    _weapon - Weapon that fired

  Returns:
    nothing

  Author:
  diwako 2018-10-26
*/
params ["_weapon"];
if !(primaryWeapon ace_player == _weapon) exitWith {};
if (isNil "diwako_unknownwp_weapon_whitelist") exitWith {};

private _weaponData = ace_overheating_cacheWeaponData getVariable _weapon;
if (isNil "_weaponData") then {
  private _weaponUpper = toUpper(_weapon);
  // weapon class has not been initialized
  if !(_weaponUpper in diwako_unknownwp_weapon_whitelist || {_weaponUpper in diwako_unknownwp_local_weapons}) then {
    // weapon not in whitelist
    private _weaponData = [_weapon] call ace_overheating_fnc_getWeaponData;
      /*
      * 0: dispresion <NUMBER>
      * 1: slowdownFactor <NUMBER>
      * 2: jamChance <NUMBER>
      */
    private _weaponData = _weaponData vectorAdd [diwako_unknownwp_dispersion_add,0,diwako_unknownwp_jamchance_add / 100];
    ace_overheating_cacheWeaponData setVariable [_weapon, _weaponData];
  };
};