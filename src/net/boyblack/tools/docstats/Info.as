//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted you to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package net.boyblack.tools.docstats
{
	import flash.display.DisplayObjectContainer;

	public class Info
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

		public function Info(doc:DisplayObjectContainer, depth:int, fqcn:String, filtered:Boolean)
		{
			this.numChildren = doc.numChildren;
			this.depth = depth;
			this.doc = doc;
			this.fqcn = fqcn;
			this.filtered = filtered;
		}
	}
}
