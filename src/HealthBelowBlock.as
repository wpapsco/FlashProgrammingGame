package {
	import Box2D.Dynamics.b2World;
	import com.bit101.components.HUISlider;
	import com.bit101.components.NumericStepper;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	/**
	 * ...
	 * @author William
	 */
	public class HealthBelowBlock extends CallBackBlock {
		
		public var _slider:NumericStepper;
		
		public function HealthBelowBlock(parent:DisplayObjectContainer, location:Point) {
			_slider = new NumericStepper(parent, location.x, location.y + 20);
			_slider.width = 100;
			_slider.maximum = 100;
			_slider.minimum = 0;
			super(parent, "Health below", location);
		}
		
		override public function update(world:b2World, bot:BotActor):void {
			if (bot.health < _slider.value) {
				_go = true;
			}
			super.update(world, bot);
		}
	}

}