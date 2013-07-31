package  {
	import Box2D.Common.Math.b2Transform;
	import Box2D.Dynamics.b2World;
	import com.bit101.components.CheckBox;
	import com.bit101.components.HRangeSlider;
	import com.bit101.components.HSlider;
	import com.bit101.components.HUISlider;
	import com.bit101.components.NumericStepper;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	/**
	 * ...
	 * @author William
	 */
	public class RotateBotBlock extends CommandBlock {
		private var _degrees:Number;
		private var _set:Boolean;
		private var _slider:NumericStepper;
		private var _checkBox:CheckBox;
		
		public function RotateBotBlock(parent:DisplayObjectContainer, location:Point) {
			_slider = new NumericStepper(parent, location.x, location.y + 20);
			_slider.maximum = 360;
			_slider.minimum = 0;
			_slider.width = 100;
			_checkBox = new CheckBox(parent, location.x, location.y + 40, "Add Rotation");
			super(parent, "Rotate", location, 0);
		}
		override public function command(world:b2World, bot:BotActor):void {
			_degrees = _slider.value;
			_set = !_checkBox.selected;
			var trans:b2Transform = bot.Body.GetTransform();
			if (_set) {
				trans.R.Set(_degrees * Math.PI / 180);
			} else {
				trans.R.Set(trans.R.GetAngle() + (_degrees * Math.PI / 180));
			}
			bot.Body.SetTransform(trans);
			super.command(world, bot);
		}
		
		override public function onDestroy():void {
			if (_parent.contains(_slider)) {
				_parent.removeChild(_slider);
			}
			if (_parent.contains(_checkBox)) {
				_parent.removeChild(_checkBox);
			}
			super.onDestroy();
		}
	}

}