package  
{
	import Box2D.Dynamics.b2World;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	/**
	 * ...
	 * @author William
	 */
	public class ShootBlock extends CommandBlock{
		
		public function ShootBlock(parent:DisplayObjectContainer, location:Point) {
			super(parent, "Shoot", location, 0);
		}
		
		override public function command(world:b2World, bot:BotActor):void {
			bot.shoot();
			super.command(world, bot);
		}
	}

}