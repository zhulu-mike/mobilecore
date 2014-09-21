package com.mike.utils
{
	import com.mike.infos.MoreGameInfo;

	public class MoreGameUtil
	{
		public function MoreGameUtil()
		{
		}
		
		public static var list:Array = [];
		
		public static function parse(data:XML):void
		{
			var games:XMLList = data.game;
			var vo:MoreGameInfo;
			
			for each (data in games)
			{
				vo = new MoreGameInfo();
				vo.name = LanUtil.isChinese ? data.@name : data.@nameen;
				vo.id = data.@id;
				vo.desc = data.@desc;
				vo.icon = data.@icon;
				vo.score = data.@score;
				vo.packageName = data.@packagename;
				vo.url = String(data.text());
				list.push(vo);
			}
		}
	}
}