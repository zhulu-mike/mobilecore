package com.mike.utils
{
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class SoundThread
	{
		public function SoundThread()
		{
			
		}
		
		public var url:String;
		
		public var isLoop:Boolean = false;
		
		public var repeatCount:int = 1;
		
		public var sound:Sound;
		
		public var channel:SoundChannel;
		
		private var _state:int = SoundState.STOP;
		
		public function canPlay():Boolean
		{
			return state == SoundState.PLAY;
		}

		public function get state():int
		{
			return _state;
		}

		public function set state(value:int):void
		{
			_state = value;
		}

	}
}