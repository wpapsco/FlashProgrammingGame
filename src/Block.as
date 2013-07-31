package  {
	import Box2D.Dynamics.b2World;
	import com.bit101.components.PushButton;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author William
	 */
	public class Block {
		
		public var _numParams:int;
		public var _previousBlock:Block;
		public var _previousBlocks:Array;
		public var _params:Array;
		public var _parent:DisplayObjectContainer
		public var _selectButton:PushButton;
		public var _location:Point;
		
		public function Block(parent:DisplayObjectContainer, title:String, location:Point, numParams:int, ...params) {
			_params = params;
			_parent = parent;
			_selectButton = new PushButton(parent, location.x, location.y, title, buttonPushed);
			_location = location;
			_previousBlocks = new Array();
		}
		
		private function buttonPushed(e:Event):void {
			(_parent as Main2).blockSelected(this);
		}
		
		public function destroy():void {
			if (_parent.contains(_selectButton)) {
				_parent.removeChild(_selectButton);
			}
			onDestroy();
		}
		
		public function incite(world:b2World, bot:BotActor):Block { return null; }
		
		public function tryAttach(to:Block):void { }
		
		public function tryRemove(block:Block):void { }
		
		public function onDestroy():void {}
	}

}