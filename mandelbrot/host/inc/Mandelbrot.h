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

#ifndef __MANDELBROT_H__
#define __MANDELBROT_H__

#include "coordinates.h"

#include "aocl_utils.h"

#include "HardwareMandelbrot.h"
#include "SoftwareMandelbrot.h"

// Define labels for using software or hardware to calculate the frame
#define HARDWARE 0
#define SOFTWARE 1

// Initialize the Mandelbrot functions
int mandelbrotInitialize();

// Set the color table
int mandelbrotSetColorTable(
  unsigned int* aColorTable,
  unsigned int aColorTableSize);

// Swap between using hardware and software to calculate
int mandelbrotSwitchCalculationMethod();

// Calculate a frame
int mandelbrotCalculateFrame(
  double aStartX,
  double aStartY,
  double aScale,
  unsigned int* aFrameBuffer);

// Release the Mandelbrot resources
int mandelbrotRelease();

#endif

