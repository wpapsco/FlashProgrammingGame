package {
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author William
	 */
	public class Bot {
		private var _weapons:Array;
		//private var module:Module;
		
		public function Bot(...weapons){
			_weapons = weapons;
		}
		
		public function shoot(weaponNumber:int, from:BotActor, parent:DisplayObjectContainer) {
			(_weapons[weaponNumber] as RangedWeaponInterface).shoot(from, parent);
		}
	}
}