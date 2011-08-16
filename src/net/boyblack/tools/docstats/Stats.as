//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted you to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package net.boyblack.tools.docstats
{

	public class Stats
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

		public var infos:Array = [];

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

		public function add(info:Info):void
		{
			docCount++;
			infos.push(info);
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

}
