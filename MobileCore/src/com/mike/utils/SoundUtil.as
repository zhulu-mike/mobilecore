package com.mike.utils
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Dictionary;
	
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	

	public class SoundUtil
	{
		public function SoundUtil()
		{
		}
		
		private static var soundLoader:BulkLoader = new BulkLoader("soundloader");
		
		public static var allCanPlay:Boolean = true;
		
		public static function getSoundThread(url:String):SoundThread
		{
			return soundList[url];
		}
		
		private static var soundList:Dictionary = new Dictionary();
		
		public static function playSound(url:String, callBack:Function=null):void
		{
			if (soundList[url] == undefined){
				registerSound(url,callBack);
			}
			else if (soundList[url] != 1 && soundList[url].sound != null)
				soundList[url].channel = soundList[url].sound.play(0);
		}
		
		public static function playLoopSound(url:String):void
		{
			if (soundList[url] == undefined)
				registerSound(url,null,true);
			else if (soundList[url] != 1){
				var t:SoundThread = soundList[url];
				if (t.sound != null && allCanPlay)
				{
					if (t.channel != null)
						t.channel.stop();
					t.channel = t.sound.play(0,int.MAX_VALUE);
				}
				t.state = SoundState.PLAY;
			}
		}
		
		public static function stopAllSound():void
		{
			var obj:SoundThread, channel:SoundChannel;
			for each (obj in soundList)
			{
				channel = obj.channel;
				if (channel)
				{
					channel.stop();
					channel = null;
				}
			}
		}
		
		public static function recoverAllSound():void
		{
			var obj:SoundThread, channel:SoundChannel;
			for each (obj in soundList)
			{
				if (obj.canPlay() && obj.isLoop)
					obj.channel = obj.sound.play(0,int.MAX_VALUE);
			}
		}
		
		public static function stopSound(url:String):void
		{
			if (soundList.hasOwnProperty(url) && soundList[url] != undefined && soundList[url] != 1 && soundList[url].channel!=null){
				soundList[url].channel.stop();
				soundList[url].state = SoundState.STOP;
				soundList[url].channel = null;
			}
		}
		
		private static function registerSound(url:String, callBack:Function=null, loop:Boolean=false,count:int=1):void
		{
			var t:SoundThread = new SoundThread();
			t.url = url;
			t.repeatCount = count;
			t.isLoop = loop;
			t.state = SoundState.PLAY;
			soundList[url] = t;
			var loadData:LoadingItem = soundLoader.add(url);
			var comp:Function = function(e:flash.events.Event):void
			{
				loadData.removeEventListener(flash.events.Event.COMPLETE, comp);
				t.sound = loadData.content as Sound;
				if (allCanPlay && t.isLoop && t.canPlay())
				{
					t.channel = t.sound.play(0,int.MAX_VALUE);
				}
				if (callBack)
				{
					callBack();
				}
			}
			loadData.addEventListener(flash.events.Event.COMPLETE, comp);
			soundLoader.loadNow(loadData);
		}
	}
}