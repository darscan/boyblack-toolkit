//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted you to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package net.boyblack.tools.egg
{
	import flash.utils.Dictionary;

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
	 * <p><b>Note:</b> This is not a micro-benchmarking tool.</p>
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

