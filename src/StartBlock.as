package {
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	/**
	 * ...
	 * @author William
	 */
	public class StartBlock extends CommandBlock {
		
		public function StartBlock(parent:DisplayObjectContainer, location:Point) {
			super(parent, "Start", location, 0);
		}
		
	}

}