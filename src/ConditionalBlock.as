package  {
	import Box2D.Dynamics.b2World;
	/**
	 * ...
	 * @author William
	 */
	public class ConditionalBlock extends Block {
		
		public var _trueBlock:Block;
		public var _falseBlock:Block;
		
		public function ConditionalBlock(numParams:int, ...params) {
			super(numParams, params);
		}
		
		override public function incite(world:b2World, bot:BotActor):Block {
			if (conditional(world, bot)) {
				return _trueBlock;
			} else {
				return _falseBlock;
			}
		}
		
		override public function tryAttach(to:Block):void {
			if (_trueBlock == null) {
				_trueBlock = to;
				_trueBlock._previousBlock = this;
				return;
			} else if (_falseBlock == null) {
				_falseBlock = to;
				_trueBlock._previousBlock = this;
				return;
			}
		}
		
		public function conditional(world:b2World, bot:BotActor):Boolean { }
	}

}