package  {
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	/**
	 * ...
	 * @author William
	 */
	public class MoveBotBlock extends CommandBlock{
		private var vec:b2Vec2;
		public function MoveBotBlock(vector:b2Vec2) {
			vec = vector;
			super(1, vector);
		}
		
		override public function command(world:b2World, bot:BotActor):void {
			var point:b2Vec2 = new b2Vec2(vec.x, vec.y);
			point.Normalize();
			point.NegativeSelf();
			point.Add(bot.Body.GetPosition());
			bot.Body.ApplyImpulse(vec, point);
		}
	}

}