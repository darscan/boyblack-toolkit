//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted you to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package net.boyblack.tools.egg
{

	public class Process
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		public var description:String;

		public var pid:String;

		public function get running():Boolean
		{
			return Boolean(runningSegment);
		}

		public var segments:Array = [];

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var runningSegment:ProcessSegment;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function Process(pid:String, description:String = ''):void
		{
			this.pid = pid;
			this.description = description;
		}


		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function cancel():void
		{
			runningSegment && runningSegment.cancel();
			runningSegment = null;
		}

		public function start():void
		{
			runningSegment && runningSegment.cancel();
			runningSegment = new ProcessSegment();
			segments.push(runningSegment);
			runningSegment.start();
		}

		public function stop():void
		{
			runningSegment && runningSegment.stop();
			runningSegment = null;
		}

		public function toString():String
		{
			return 'Egg: ' + pid
				+ (description ? ' (' + description + '): ' : ': ')
				+ segments;
		}
	}
}
