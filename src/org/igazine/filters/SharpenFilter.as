package org.igazine.filters
{
	/**
	 * ...
	 * @author Tamas Sopronyi, igazine.org
	 */
	
	import flash.filters.ConvolutionFilter;
	
	public class  SharpenFilter extends ConvolutionFilter
	{
		public function SharpenFilter():void {
			super(3, 3, [0, -1, 0, -1, 5, -1, 0, -1, 0]);
		}
	}
	
}