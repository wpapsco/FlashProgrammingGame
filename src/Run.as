package {
	/**
	 * ...
	 * @author William
	 */
	public class Run {
		
		private var _currentBlock:Block;
		private var _playerBot:BotActor;
		private var _frames:int;
		private var _frameInterval:int;
		public var _isDone:Boolean = false;
		
		public function Run(playerBot:BotActor, rootBlock:Block, frameInterval:int) {
			_currentBlock = rootBlock;
			_playerBot = playerBot;
			_frameInterval = frameInterval;
			_frames = _frameInterval;
		}
		
		public function go():void {
			if (_currentBlock != null) {
				var skipWait:Boolean = false;
				for each (var block:Block in _currentBlock._previousBlocks) {
					if (block is CallBackBlock) {
						skipWait = true;
					}
				}
				if (skipWait) {
					_currentBlock = _currentBlock.incite(Values.world, _playerBot);
					_frames = 0;
				} else {
					if (_frameInterval == _frames) {
						_currentBlock = _currentBlock.incite(Values.world, _playerBot);
						_frames = 0;
					} else {
						_frames++;
					}
				}
			} else {
				_isDone = true;
			}
		}
	}
}