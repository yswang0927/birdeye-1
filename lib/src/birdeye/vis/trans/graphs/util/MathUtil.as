/* 
 * The MIT License
 *
 * Copyright (c) 2007 The SixDegrees Project Team
 * (Jason Bellone, Juan Rodriguez, Segolene de Basquiat, Daniel Lang).
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
package birdeye.vis.trans.graphs.util {
	import birdeye.vis.trans.graphs.util.geom.IVisualObjectWithDimensions;
	
	import flash.geom.Point;
	
	/**
	 * This is a class to provide some static functions
	 * to help with angles and geometry.
	 * */
	public class MathUtil {
		
		private static const _LOG:String = "utils.Geometry";		
		/**
		 * Calculate the polar Angle of a Point.
		 * @param p The Point to which the Angle is needed.
		 * @return The polar angle in radians. The range is from 0 to 2 * PI. Returns 0 for the origin.
		 * */
		public static function polarAngle(p:Point):Number {
			
			/* the length is 0 if the node is the origin
			 * in this case the angle makes no sense and would
			 * be returned as NaN, so we return 0 in this case */
			if(p.length == 0) {
				return 0;
			} else {
				return normaliseAngle(Math.atan2(p.y, p.x));
			}
		}
		
		/**
		 * Calculate the polar Angle of a Point in degrees.
		 * @param p The Point to which the Angle is needed.
		 * @return The polar angle in degrees. The range is from 0 to 360. Returns 0 for the origin.
		 * */
		public static function polarAngleDeg(p:Point):Number {
			
			/* the length is 0 if the node is the origin
			 * in this case the angle makes no sense and would
			 * be returned as NaN, so we return 0 in this case */
			if(p.length == 0) {
				return 0;
			} else {
				return rad2deg(normaliseAngle(Math.atan2(p.y, p.x)));
			}
		}
		
		/**
		 * Calculate the polar radius for a given point. This just calles
		 * the length method of the Point object, which is the same. It is
		 * part of this class for consistency.
		 * @param p The point to receive the polar radius from.
		 * @return The polar radius.
		 * @see Point#length
		 * */
		public static function polarRadius(p:Point):Number {
			return p.length;
		}
		
		/**
		 * Calculate cartesian coordinates from polar coordinates,
		 * again this uses the polar method from the Point class,
		 * here for completeness.
		 * @param r The polar radius.
		 * @param a The polar angle in radians.
		 * @return A Point object with the cartesian coordinates.
		 * @see Point#polar()
		 * */
		public static function cartFromPolar(r:Number, a:Number):Point {
			return Point.polar(r,a);
		}
		
		/**
		 * Calculate cartesian coordinates from polar coordinates,
		 * again this uses the polar method from the Point class,
		 * here for completeness.
		 * @param r The polar radius.
		 * @param a The polar angle in degrees.
		 * @return A Point object with the cartesian coordinates.
		 * @see Point#polar()
		 * */
		public static function cartFromPolarDeg(r:Number, a:Number):Point {
			return Point.polar(r,deg2rad(a));
		}
		
		
		/**
		 * Normalizes angles to be within the range of 0 to 2*PI
		 * by adding or subtracting 2 * PI until the angle is within
		 * the range.
		 * @param a The angle to normalise in radians.
		 * @return The normalized angle.
		 * */
		public static function normaliseAngle(a:Number):Number {
			
			while(a >= (2 * Math.PI)) {
				a -= (2 * Math.PI);
			}
			while(a < 0) {
				a += (2 * Math.PI);
			}
			return a;
		}
		
		/**
		 * Normalizes angles to be within the range of 0 to 360
		 * by adding or subtracting 360 until the angle is within
		 * the range.
		 * @param a The angle to normalise in degrees.
		 * @return The normalized angle.
		 * */
		public static function normaliseAngleDeg(a:Number):Number {
			
			while(a >= 360) {
				a -= 360;
			}
			while(a < 0) {
				a += 360;
			}
			return a;
		}
		
		
		/**
		 * Turns an angle given in radians into degrees
		 * @param a The angle given in radians.
		 * @return The angle in degrees.
		 * */
		public static function rad2deg(a:Number):Number {
			return (a * 180 / Math.PI);

		}
		
		/**
		 * Turns an angle given in degrees into radians.
		 * @param a The angle given in degrees.
		 * @return The angle in radians.
		 * */
		public static function deg2rad(a:Number):Number {
			return (a * Math.PI / 180);
		}
		
		/**
		 * Calculates the point on a quadratic bezier curve
		 * at the given position t with 0 <= t <= 1
		 * (t = 0 being the starting anchor point and
		 * t = 1 being the ending anchor point).
		 * @param ps Starting Point of the curve.
		 * @param pc Control Point of the curve.
		 * @param pe Ending Point of the curve.
		 * @param t The point on the curve that we want. 0 <= t <= 1
		 * @returns The point B(t).
		 * */
		public static function bezierPoint(ps:Point, pc:Point, pe:Point, t:Number):Point {
			/* we calculate x and y separately */
			var x:Number;
			var y:Number;
			
			if(t < 0 || t > 1) {
				LogUtil.warn(_LOG, "bezierPointQuad: t has to be between 0 and 1, but it:"+t);
				return new Point(0,0);
			}
			
			x = Math.pow((1-t),2)*ps.x + 2*t*(1-t)*pc.x + Math.pow(t,2)*pe.x;
			y = Math.pow((1-t),2)*ps.y + 2*t*(1-t)*pc.y + Math.pow(t,2)*pe.y;
			
			return new Point(x,y);	
		}
		
		
		/**
		 * Returns sine hyperbolic function:
		 * <code>sinh(x) = 0.5*(e^x-e^(-x))</code>.
		 * @param x
		 * @return
		 */
		public static function sinh(x:Number):Number {
    		var expX:Number = Math.exp(x);
			return 0.5 * (expX - 1/expX);
		}
		
		/**
		 * Returns cosine hyperbolic function:
		 * <code>cosh(x) = 0.5*(e^x+e^(-x))</code>.
		 * @param x
		 * @return
		 */
		public static function cosh(x:Number):Number {
			var expX:Number = Math.exp(x);
			return 0.5 * (expX + 1/expX);
		}
		
		/**
		 * Returns inverse of the sine hyperbolic function:
		 * <code>arsinh(x) = ln(x+sqrt(x^2+1))</code>.
		 * @param x
		 * @return
		 */
		public static function arsinh(x:Number):Number {
			return Math.log(x + Math.sqrt(x * x + 1));
		}
		
		/**
		 * Returns inverse of the sine hyperbolic function:
		 * <code>arcosh(x) = ln(x+sqrt(x^2-1))</code>.
		 * @param x
		 * @return
		 */
		public static function arcosh(x:Number):Number {
			return Math.log(x + Math.sqrt(x * x - 1));
		}
    
    	/**
    	 * Calculates the point in the middle of the straight line
    	 * between the two given points.
    	 * @param p The first endpoint of the virtual line.
    	 * @param q The second endpoint of the virtual line.
    	 * @returns The point at the center of the virtual line.
    	 * */
    	public static function midPointOfLine(p:Point,q:Point):Point {
			
			if(p != null && q != null) {
				return new Point(
					(p.x + q.x) / 2.0,
					(p.y + q.y) / 2.0
					);
			} else {
				return null;
			}
		}
    
		/**
		 * Function that tests if two points are equal within tolerance
		 * The current tolerance limit is (1, 1) - same as pixel resolution on screen
		 */
		public static function equal(p1:Point, p2:Point):Boolean {
			return (Math.abs(p1.x - p2.x) <= 1) && (Math.abs(p1.y - p2.y) <= 1);
		}
		
		/**
		 * Function that returns the center point of a display object
		 */
		public static function getCenter(c:IVisualObjectWithDimensions):Point {
			return new Point(c.width / 2, c.height / 2);
		}

		/**
		 * Returns the positive angle between two lines OP and OQ at point O, where:<br>
		 * P = [x1, y1]<br>
		 * Q = [x2, y2]<br>
		 * O = [atX, atY]<br>
		 * 
		 * XXX why not use Math.atan2(y2 - y1, x2 - x1)?
		 * How can point O affect the angle between 2 lines??
		 */
		public static function getAngle(x1:Number, y1:Number,
										 x2:Number, y2:Number,
										 atX:Number, atY:Number):Number {
			var m1:Number = (y1 - atY) / (x1 - atX);
			var m2:Number = (y2 - atY) / (x2 - atX);
			var rtn:Number = Math.atan((m1 - m2) / (1 + m1 * m2));
			return Math.abs(rtn);
		}
		/** 
		 * Returns the endpoint Q of a line OP that is rotated clock-wise about point O, where:<br>
		 * O = [centerX, centerY]<br>
		 * P = [startX, startY]<br>
		 * Q = [endX, endY]<br>
		 * 
		 * XXX Why not use Point.polar here?
		 * 
		 * initAngle = Math.atan2(startY - centerY, startx - centerX);
		 * newAngle = initAngle + angleDelta
		 * length = Point.distance(P,O);
		 * resultQ = Point.polar(length,newAngle);
		 * resultQ.offset(P.x,P.y)
		 * 
		 * should do it. 
		 * 
		 */
		public static function getRotation(angleDelta:Number,
											 centerX:Number, centerY:Number,
											 startX:Number, startY:Number):Point {
			var radius:Number = Math.sqrt((centerX - startX) * (centerX - startX) + (centerY - startY) * (centerY - startY));
			var angle:Number, ax:Number, ay:Number;
			
			// Compute rotation based on location of points
			// TO-DO: Perhaps, this can be further simplified
			if (startY < centerY) { //quadrant 1 and 2
				if (startX > centerX) {
					// Quad 1:
					angle = Math.acos((startX - centerX) / radius);
					ax = centerX + Math.cos(angle + angleDelta) * radius;
					ay = centerY - Math.sin(angle + angleDelta) * radius;
				} else {
					// Quad 2:
					angle = Math.acos((centerY - startY) / radius);
					ax = centerX - Math.sin(angle + angleDelta) * radius;
					ay = centerY - Math.cos(angle + angleDelta) * radius;
				}
			} else { //quadrant 3 and 4
				if (startX < centerX) {
					// Quad 3:
					angle = Math.acos((centerX - startX) / radius);
					ax = centerX - Math.cos(angle + angleDelta) * radius;
					ay = centerY + Math.sin(angle + angleDelta) * radius;
				} else {
					// Quad 4:
					angle = Math.acos((startY - centerY) / radius);
					ax = centerX + Math.sin(angle + angleDelta) * radius;
					ay = centerY + Math.cos(angle + angleDelta) * radius;
				}
			}
			return new Point(ax,ay);
		}
	}
}