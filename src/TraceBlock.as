package  {
	import Box2D.Dynamics.b2World;
	import com.bit101.components.InputText;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	/**
	 * ...
	 * @author William
	 */
	public class TraceBlock extends CommandBlock {
		
		private var _input:InputText;
		
		public function TraceBlock(parent:DisplayObjectContainer, location:Point) {
			_input = new InputText(parent, location.x, location.y + 20, "Enter text");
			super(parent, "Trace", location, 0);
		}
		
		override public function command(world:b2World, bot:BotActor):void 
		{
			trace(_input.text);
			super.command(world, bot);
		}
		
		override public function onDestroy():void 
		{
			super.onDestroy();
		}
	}
}