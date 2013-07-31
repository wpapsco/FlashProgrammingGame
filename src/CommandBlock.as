package  {
	import Box2D.Dynamics.b2World;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author William
	 */
	public class CommandBlock extends Block {
		
		public var _nextBlock:Block;
		public var _arrow:Sprite;
		
		public function CommandBlock(parent:DisplayObjectContainer, title:String, location:Point, numParams:int, ...params) {
			super(parent, title, location, numParams, params);
		}
		
		override public function incite(world:b2World, bot:BotActor):Block {
			command(world, bot);
			if (_nextBlock != null) {
				return _nextBlock;
			} else {
				return null;
			}
		}
		
		override public function tryRemove(block:Block):void {
			if (_nextBlock == block) {
				if (_arrow != null) {
					if (_parent.contains(_arrow)) {
						_parent.removeChild(_arrow);
					}
				}
				_nextBlock = null;
			}
			super.tryRemove(block);
		}
		
		override public function tryAttach(to:Block):void {
			if (_nextBlock == null && to != null) {
				if (to is CallBackBlock || to is StartBlock) {
					
				} else {
					var fromLocation:Point = new Point(_location.x + (_selectButton.width / 2), _location.y + (_selectButton.height / 2));
					var toLocation:Point = new Point(to._location.x + (to._selectButton.width / 2), to._location.y + (to._selectButton.height / 2)); 
					
					_arrow = Main2.drawArrow(fromLocation, toLocation, this._parent);
					_parent.setChildIndex(_arrow, 0);
					_nextBlock = to;
					_nextBlock._previousBlocks.push(this);
				}
			}
/*			if (to == null && _nextBlock != null) {
				if (_arrow != null) {
					if (_parent.contains(_arrow)) {
						_parent.removeChild(_arrow);
					}
				}
				_nextBlock = null;
			}*/
		}
		
		override public function onDestroy():void {
			//sever connections to _nextBlock
			if (_nextBlock != null) {
				_nextBlock._previousBlocks.splice(_nextBlock._previousBlocks.indexOf(this), 1);
			}
			if (_arrow != null) {
				if (_parent.contains(_arrow)) {
					_parent.removeChild(_arrow);
				}
			}
			for each(var block:Block in _previousBlocks) {
				block.tryRemove(this);
			}
			super.onDestroy();
		}
		
		public function command(world:b2World, bot:BotActor):void { }
	}

}