package  
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	/**
	 * ...
	 * @author William
	 */
	public class HitWallBlock extends CallBackBlock 
	{
		
		public function HitWallBlock(parent:DisplayObjectContainer, location:Point) 
		{
			super(parent, "Hit wall", location);
		}
		
	}

}