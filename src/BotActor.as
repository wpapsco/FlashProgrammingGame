package {
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.Joints.b2FrictionJointDef;
	import com.bit101.components.Label;
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author William
	 */
	public class BotActor extends Actor {
		
		public const RADIUS:Number = 20.0 / Values.RATIO;
		private var _bot:Bot;
		private var _health:Number;
		private var _healthLabel:Label;
		
		public function BotActor(density:Number, parent:DisplayObjectContainer) {
			_healthLabel = new Label(parent, 0, 0, "");
			_health = 100;
			var shape:b2CircleShape = new b2CircleShape(RADIUS);
			var fixDef:b2FixtureDef = new b2FixtureDef();
			fixDef.density = density;
			fixDef.shape = shape;
			fixDef.restitution = 0.5;
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position = new b2Vec2(400 / Values.RATIO, 300 / Values.RATIO);
			bodyDef.type = b2Body.b2_dynamicBody;
			var bod:b2Body = Values.world.CreateBody(bodyDef);
			bod.CreateFixture(fixDef);
			
			var dampingVal:Number = 2.0;
			
			bod.SetLinearDamping(dampingVal);
			bod.SetAngularDamping(dampingVal);
			
			bod.SetUserData(this);
			
			bot = new Bot(new SniperRifle());
			
			super(bod, null, false, parent);
		}
		
		override protected function update():void {
			_healthLabel.text = Math.round(_health).toString();
			_healthLabel.move((Body.GetPosition().x * Values.RATIO) - _healthLabel.width / 2, (Body.GetPosition().y * Values.RATIO) - _healthLabel.height / 2 - 26);
			super.update();
		}
		
		public function shoot():void {
			bot.shoot(0, this, parent);
		}
		
		override protected function onDestroy():void {
			if (parent.contains(_healthLabel)) {
				parent.removeChild(_healthLabel);
			}
			super.onDestroy();
		}
		
		public function takeDamage(from:b2Body):void {
			_health -= from.GetLinearVelocity().Length() * from.GetMass() * 2;
		}
		
		public function takeDamageAmount(amount:Number):void {
			_health -= amount;
		}
		
		public function get bot():Bot {
			return _bot;
		}
		
		public function set bot(value:Bot):void {
			_bot = value;
		}
		
		public function get health():Number 
		{
			return _health;
		}
		
		public function set health(value:Number):void 
		{
			_health = value;
		}
	}

}