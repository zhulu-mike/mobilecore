package com.mike.utils
{
	import flash.system.Capabilities;

	public class LanUtil
	{
		public function LanUtil()
		{
		}
		
		public static var isChinese:Boolean = false;
		
		public static function getCurrentLangeFile():String
		{
			var lan:String = "";
			if (Capabilities.languages.length > 0)
			{
				lan = Capabilities.languages[0];
				if (lan.indexOf("zh") >= 0)
					lan = LanType.ZHONGGUO;
				else if (lan.indexOf("en") >= 0)
					lan = LanType.ENGLISH;
				else if (lan.indexOf("ja") >= 0)
					lan = LanType.JAPANESE;
			}else{
				lan = LanType.ENGLISH;
			}
			var file:String = "english";
			switch (lan)
			{
				case LanType.ZHONGGUO:
					file = "chinese";
					isChinese = true;
					break;
				case LanType.JAPANESE:
					file = "japanese";
					break;
				case LanType.HANYU:
					file = "hanyu";
					break;
				default:
					break;
			}
			return file + ".xml";
		}
		
		
			
	}
}