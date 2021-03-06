/* 
 * The MIT License
 *
 * Copyright (c) 2008
 * United Nations Office at Geneva
 * Center for Advanced Visual Analytics
 * http://cava.unog.ch
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 package org.un.cava.birdeye.geovis.controls.viewers.toolbars
{
	public interface IMainViewToolbar 
	{
		function get numChildren():int;
		
		function get width():Number;
		
		function get height():Number;
		
		function get layout():String;
		
		function get autosizeIcons():Boolean;
		
		function set autosizeIcons(val:Boolean):void;
		
		function get upIconColor():Number;
		
 		function set upIconColor(val:Number):void;

		function get overIconColor():Number;

		function set overIconColor(val:Number):void;

		function get downIconColor():Number;

		function set downIconColor(val:Number):void;

		function get selectedUpIconColor():Number;

		function set selectedUpIconColor(val:Number):void;

		function get selectedOverIconColor():Number;

		function set selectedOverIconColor(val:Number):void;
		
		function get selectedDownIconColor():Number;
		
		function set selectedDownIconColor(val:Number):void;
	}
}