package  {
	import Box2D.Common.b2Color;
	import Box2D.Common.Math.b2Transform;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	/**
	 * ...
	 * @author William
	 */
	public class AimAtEnemyBlock extends CommandBlock {
		
		public function AimAtEnemyBlock(parent:DisplayObjectContainer, location:Point) {
			super(parent, "Aim at an enemy", location, 0);
		}
		
		override public function command(world:b2World, bot:BotActor):void {
			var botToAimAt:BotActor = findBot(world, bot);
			if (botToAimAt != null) {
				var angle:Number = (Math.atan2(botToAimAt.Body.GetPosition().x - bot.Body.GetPosition().x, bot.Body.GetPosition().y - botToAimAt.Body.GetPosition().y)) * 180 / Math.PI;
				if (angle < 0) { angle += 360; }
				angle = angle - 90;
				var trans:b2Transform = bot.Body.GetTransform();
				trans.R.Set(angle * Math.PI / 180);
				bot.Body.SetTransform(trans);
				super.command(world, bot);
			}
		}
		
		private function findBot(world:b2World, bot:BotActor):BotActor {
			var body:b2Body = world.GetBodyList()
			while (true) {
				if (body == null) {
					return null;
				} else if (body.GetUserData() is BotActor && body.GetUserData() != bot)  {
					return body.GetUserData();
				} else {
					body = body.GetNext();
				}
			}
			return null;
		}
	}

}