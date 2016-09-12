
# iOS PDF lib (Swift)
<p align="center">
  <br><br>
  <img src="https://raw.githubusercontent.com/marcomoreira92/iOS-PDF-lib/master/AppLogo.png" alt="iOS PDF lib" height="150" width="150">
</p>

##ABOUT:
This library bundles together two PDF libraries, the VFR Reader library (https://github.com/vfr/Reader) for the PDF viewer and the KurtCode PDFKitten (https://github.com/KurtCode/PDFKitten) for the search engine.

PDF lib was developed in Objective-C, while the example App was written in Swift 2.1.

For sugestions and code corrections please contact me so we can make this library better for future implementations.

To change the PDF Reader theme color please check the Constants.m file.
<p align="center">
  <br><br>
  <img src="https://raw.githubusercontent.com/marcomoreira92/iOS-PDF-lib/master/AppPreviewScreens.png" alt="iOS PDF lib" >
</p>

<br>
<br>
<br>
##HOW IT WORKS:

<p align="center">
  <br><br>
  <img src="https://raw.githubusercontent.com/marcomoreira92/iOS-PDF-lib/master/HowItWorks.png" alt="iOS PDF lib" >
</p>

To use both libraries simultaneously a SearchView was added to the ReaderMainToolbar.
 A searchHolder (a static variable holder containing the data actively being used in a search) was created that saves the keyword used in the search process (step 1) which fires the setNeedDisplay (step 2) that notifies the operating system of the need for a View update. 
The setNeedDisplay action calls the drawLayer implemented in ReaderContentPage responsible for recreating the View. However, since drawLayer is a system method it can not have any search parameters. Before beginning the recreation process a call is made to the search library (step 3), returning a set of coordinates (step 4) that indicate where the search result should be highlighted.

<br>
<br>
<br>



##LICENCE:

Copyright (c) 2016 Marco Moreira

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
