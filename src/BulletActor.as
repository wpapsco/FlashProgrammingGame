package  {
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author William
	 */
	public class BulletActor extends Actor {
		
		public function BulletActor(position:b2Vec2, parent:DisplayObjectContainer) {
			var shape:b2CircleShape = new b2CircleShape(10 / Values.RATIO);
			
			var fixDef:b2FixtureDef = new b2FixtureDef();
			fixDef.density = 1.0;
			fixDef.restitution = 0;
			fixDef.shape = shape;
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.allowSleep = false;
			bodyDef.bullet = true;
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.position = position;
			
			var body:b2Body = Values.world.CreateBody(bodyDef);
			body.CreateFixture(fixDef);
			body.SetUserData(this);
			
			super(body, null, false, parent);
		}
		
	}

}