// Copyright (C) 2013-2014 Altera Corporation, San Jose, California, USA. All rights reserved.
// Permission is hereby granted, free of charge, to any person obtaining a copy of this
// software and associated documentation files (the "Software"), to deal in the Software
// without restriction, including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to
// whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
// 
// This agreement shall be governed in all respects by the laws of the State of California and
// by the laws of the United States of America.

// Amount of loop unrolling. Higher unrolling amounts lead to higher
// performance but also greater resource usage.
#ifndef UNROLL
#define UNROLL 8
#endif

#if !defined(USE_DOUBLE) && !defined(USE_FLOAT)
#define USE_FLOAT
#endif

#ifdef USE_DOUBLE
#define MANDELBROT_HW_PRECISION double
#else
#define MANDELBROT_HW_PRECISION float
#endif

// Define the color black as 0
#define BLACK 0x00000000

////////////////////////////////////////////////////////////////////
// Hardware implementation of the mandelbrot algorithm
////////////////////////////////////////////////////////////////////
__kernel 
void hw_mandelbrot_frame (
              const MANDELBROT_HW_PRECISION x0,
							const MANDELBROT_HW_PRECISION y0,
							const MANDELBROT_HW_PRECISION stepSize,
							const unsigned int maxIterations,
							__global unsigned short int *restrict framebuffer,
							__constant const unsigned short int *restrict colorLUT,
							const unsigned int windowWidth)
{
	// Work-item position
	const size_t windowPosX = get_global_id(0);
	const size_t windowPosY = get_global_id(1);
	const MANDELBROT_HW_PRECISION stepPosX = x0 + (windowPosX * stepSize);
	const MANDELBROT_HW_PRECISION stepPosY = y0 - (windowPosY * stepSize);

	// Variables for the calculation
	MANDELBROT_HW_PRECISION x = 0.0;
	MANDELBROT_HW_PRECISION y = 0.0;
	MANDELBROT_HW_PRECISION xSqr = 0.0;
	MANDELBROT_HW_PRECISION ySqr = 0.0;
	unsigned int iterations = 0;

	// Perform up to the maximum number of iterations to solve
	// the current work-item's position in the image
  //
  // The loop unrolling factor can be adjusted based on the amount of FPGA
  // resources available.
  #ifndef DONT_USE_PRAGMA
  #pragma unroll UNROLL
  #endif
	while (	xSqr + ySqr < 4.0 &&
			iterations < maxIterations)
	{
		// Perform the current iteration
		xSqr = x*x;
		ySqr = y*y;

		y = 2*x*y + stepPosY;
		x = xSqr - ySqr + stepPosX;

		// Increment iteration count
		iterations++;
	}

	// Output black if we never finished, and a color from the look up table otherwise
	framebuffer[windowWidth * windowPosY + windowPosX] = (iterations == maxIterations)? BLACK : colorLUT[iterations];
}
