//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted you to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package net.boyblack.stats
{
	import flash.display.DisplayObjectContainer;
	import flash.utils.getQualifiedClassName;

	/**
	 * DocStats - A basic Display Object Container stats tool.
	 *
	 * <p>Usage: <code>trace(new Snap(doc));</code></p>
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

		public const unfilteredStats:Stats = new Stats('Unfiltered');

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
			return 'DocStats (Display Object Container Stats)\n\n'
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
			const info:DocInfo = new DocInfo(doc, depth, fqcn, filtered);

			allStats.add(info);

			if (filtered)
				filteredStats.add(info);
			else
				unfilteredStats.add(info);
		}
	}

}

import flash.display.DisplayObjectContainer;

class Stats
{

	/*============================================================================*/
	/* Public Properties                                                          */
	/*============================================================================*/

	public function get averageDepth():Number
	{
		return Math.round((totalDepth / docCount) * 100) / 100;
	}

	public function get averageNumChildren():Number
	{
		return Math.round((totalNumChildren / docCount) * 100) / 100;
	}

	public var docCount:int;

	public var fqcns:Array = [];

	public var maxDepth:int;

	public var maxNumChildren:int;

	public var name:String;

	public var totalDepth:int;

	public var totalNumChildren:int;

	/*============================================================================*/
	/* Constructor                                                                */
	/*============================================================================*/

	public function Stats(name:String)
	{
		this.name = name;
	}


	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	public function add(info:DocInfo):void
	{
		docCount++;
		totalDepth += info.depth;
		totalNumChildren += info.numChildren;
		maxDepth = Math.max(maxDepth, info.depth);
		maxNumChildren = Math.max(maxNumChildren, info.numChildren);
		if (fqcns.indexOf(info.fqcn) == -1)
			fqcns.push(info.fqcn);
	}

	public function toString():String
	{
		return name + ' Container Stats\n'
			+ 'Containers:             ' + docCount + ' total\n'
			+ 'Children per container: ' + maxNumChildren + ' max, ' + averageNumChildren + ' avg' + '\n'
			+ 'Depths (distance):      ' + maxDepth + ' max, ' + averageDepth + ' avg' + '\n'
			+ 'Unique container types: ' + fqcns.length + ' total\n';
	}
}


class DocInfo
{

	/*============================================================================*/
	/* Public Properties                                                          */
	/*============================================================================*/

	public var depth:int;

	public var doc:DisplayObjectContainer;

	public var filtered:Boolean;

	public var fqcn:String;

	public var numChildren:int;

	/*============================================================================*/
	/* Constructor                                                                */
	/*============================================================================*/

	public function DocInfo(doc:DisplayObjectContainer, depth:int, fqcn:String, filtered:Boolean)
	{
		this.numChildren = doc.numChildren;
		this.depth = depth;
		this.doc = doc;
		this.fqcn = fqcn;
		this.filtered = filtered;
	}
}
