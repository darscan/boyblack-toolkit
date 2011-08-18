//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted you to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package net.boyblack.tools.docstats
{
	import flash.display.DisplayObjectContainer;
	import flash.utils.getQualifiedClassName;

	/**
	 * DocStats - A basic Display Object Container stats tool.
	 *
	 * <p>Usage: <code>trace(new DocStats(doc));</code></p>
	 *
	 * @author darscan
	 */
	public class DocStats
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		public const allStats:Stats = new Stats('All');

		public const filteredStats:Stats = new Stats('Filtered (mx., spark., flash.)');

		public const unfilteredStats:Stats = new Stats('Unfiltered (custom)');

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var doc:DisplayObjectContainer;

		private const excludePattern:RegExp = /^mx\.|^spark\.|^flash\./;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function DocStats(doc:DisplayObjectContainer)
		{
			this.doc = doc;
			iterate(doc, 0);
		}


		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function toString():String
		{
			return 'Display Object Container Stats\n\n'
				+ allStats + '\n'
				+ unfilteredStats + '\n'
				+ filteredStats + '\n';
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function iterate(doc:DisplayObjectContainer, depth:int):void
		{
			store(doc, depth);
			var i:int = doc.numChildren;
			while (i--)
			{
				var child:DisplayObjectContainer = doc.getChildAt(i) as DisplayObjectContainer;
				if (child)
					iterate(child, depth + 1);
			}
		}

		private function store(doc:DisplayObjectContainer, depth:int):void
		{
			const fqcn:String = getQualifiedClassName(doc);
			const filtered:Boolean = excludePattern.test(fqcn);
			const info:Info = new Info(doc, depth, fqcn, filtered);

			allStats.add(info);

			if (filtered)
				filteredStats.add(info);
			else
				unfilteredStats.add(info);
		}
	}

}
