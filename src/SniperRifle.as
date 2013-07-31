package {
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.b2Color;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	/**
	 * ...
	 * @author William
	 */
	public class SniperRifle implements RangedWeaponInterface {
		
		private var _bullet:BulletActor;
		
		public function SniperRifle() {
			
		}
		
		public function shoot(bot:BotActor, parent:DisplayObjectContainer):void {
			var vec:b2Vec2 = new b2Vec2(Math.cos(bot.Body.GetAngle()), Math.sin(bot.Body.GetAngle()));
			var point:b2Vec2 = new b2Vec2(vec.x, vec.y);
			point.Normalize();
			point.Multiply(7.5);
			vec.Multiply(2);
			vec.Add(bot.Body.GetPosition());
			_bullet = new BulletActor(vec, parent);
			_bullet.Body.ApplyImpulse(point, vec);
		}
	}

}