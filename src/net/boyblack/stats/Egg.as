//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted you to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package net.boyblack.stats
{
	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	/**
	 * Egg - An uber simple process benchmarking tool
	 *
	 * <p>Usage:</p>
	 *
	 * <p><code>Egg.start('contact form', 'time taken for user to complete and submit contact form');</code></p>
	 *
	 * <p><code>Egg.stop('contact form'');</code></p>
	 *
	 * <p><code>trace(Egg);</code></p>
	 *
	 * <p><b>Note:</b> This tool is not for micro-benchmarking.</p>
	 *
	 * @author darscan
	 */
	public class Egg
	{

		/*============================================================================*/
		/* Private Static Properties                                                  */
		/*============================================================================*/

		private static const global:Egg = new Egg();


		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		public function get processes():Dictionary
		{
			return processByPid;
		}

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private const processByPid:Dictionary = new Dictionary();


		/*============================================================================*/
		/* Public Static Functions                                                    */
		/*============================================================================*/

		public static function cancel(pid:String):void
		{
			global.cancel(pid);
		}

		public static function start(pid:String, description:String = ''):void
		{
			global.start(pid, description);
		}

		public static function stop(pid:String):void
		{
			global.stop(pid);
		}

		public static function toString():String
		{
			return String(global);
		}


		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function cancel(pid:String):void
		{
			const process:Process = processByPid[pid] as Process;
			process && process.cancel();
		}

		public function start(pid:String, description:String = ''):void
		{
			const process:Process = processByPid[pid] ||= new Process(pid, description);
			process.start();
		}

		public function stop(pid:String):void
		{
			const process:Process = processByPid[pid] as Process;
			process && process.stop();
		}

		public function toString():String
		{
			var str:String = '';
			for each (var process:Process in processes)
				str += process.toString() + '\n';
			return str;
		}
	}
}

import flash.utils.getTimer;

class Process
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

	private var runningSegment:Segment;

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
		runningSegment = new Segment();
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

class Segment
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
