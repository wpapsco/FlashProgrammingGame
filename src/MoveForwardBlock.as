package  {
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	/**
	 * ...
	 * @author William
	 */
	public class MoveForwardBlock extends CommandBlock {
		
		public function MoveForwardBlock(parent:DisplayObjectContainer, location:Point) {
			super(parent, "Move forward", location, 0);
		}
		override public function command(world:b2World, bot:BotActor):void {
			var vec:b2Vec2 = new b2Vec2(Math.cos(bot.Body.GetAngle()), Math.sin(bot.Body.GetAngle()));
			vec.Normalize();
			vec.Multiply(10);
			//vec.Add(bot.Body.GetPosition());
			var point:b2Vec2 = new b2Vec2(vec.x, vec.y);
			point.Normalize();
			point.NegativeSelf();
			point.Add(bot.Body.GetPosition());
			bot.Body.ApplyImpulse(vec, point);
			super.command(world, bot);
		}
	}

}