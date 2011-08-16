//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted you to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package net.boyblack.tools.egg
{
	import flash.utils.getTimer;

	public class ProcessSegment
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		public var cancelled:Boolean;

		public var timeStarted:int;

		public var timeTaken:int;


		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function cancel():void
		{
			timeTaken = getTimer() - timeStarted;
			cancelled = true;
		}

		public function start():void
		{
			timeStarted = getTimer();
		}

		public function stop():void
		{
			timeTaken = getTimer() - timeStarted;
		}

		public function toString():String
		{
			return timeTaken + ' ms'
				+ (cancelled ? ' (cancelled)' : '');
		}
	}
}
