package  {
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	import com.bit101.components.ComboBox;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	/**
	 * ...
	 * @author William
	 */
	public class StrafeBlock extends CommandBlock {
		var _right:Boolean
		var _comboBox:ComboBox;
		public function StrafeBlock(parent:DisplayObjectContainer, location:Point) {
			_comboBox = new ComboBox(parent, location.x, location.y + 20, "Select a direction", new Array("Right", "Left"));
			super(parent, "Strafe", location, 0);
		}
		
		override public function command(world:b2World, bot:BotActor):void {
			if (_comboBox.selectedItem == "Right") {
				_right = true;
			} else {
				_right = false;
			}
			var add:Number = 0;
			if (_right) {
				add = 1.5707;
			} else {
				add = -1.5707;
			}
			var vec:b2Vec2 = new b2Vec2(Math.cos(bot.Body.GetAngle() + add), Math.sin(bot.Body.GetAngle() + add));
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
		
		override public function onDestroy():void {
			if (_parent.contains(_comboBox)) {
				_parent.removeChild(_comboBox);
			}
			super.onDestroy();
		}
	}

}