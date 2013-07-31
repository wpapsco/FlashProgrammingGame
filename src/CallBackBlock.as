package  {
	import Box2D.Dynamics.b2World;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	/**
	 * ...
	 * @author William
	 */
	public class CallBackBlock extends CommandBlock {
		
		public var _go:Boolean = false;
		
		public function CallBackBlock(parent:DisplayObjectContainer, title:String, location:Point) {
			super(parent, title, location, 0);
		}
		
		override public function incite(world:b2World, bot:BotActor):Block {
			return _nextBlock;
		}
		
		public function update(world:b2World, bot:BotActor):void { }
	}
}