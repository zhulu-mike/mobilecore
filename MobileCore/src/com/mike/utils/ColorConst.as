package com.mike.utils
{
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;

	public class ColorConst
	{
		public function ColorConst()
		{
		}
		
		public static const HUISE:ColorMatrixFilter = new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0]);
		public static const BLACK_MIAOBIAN:GlowFilter = new GlowFilter(0);
	}
}