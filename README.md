#  Frequency Analysis Tool
#

#### Available on TestFlight [TestFlight Link](https://testflight.apple.com/join/u9EszEwk)
#
Frequency analysis is the study of the distribution of the letters in a text.

## Input
 ##### Frequency Analysis Tool will input a text file that is UTF-8 compatible.

- UTF-8 text files
        - [10000 word list](https://www.mit.edu/~ecprice/wordlist.10000)
        - [Project Gutenberg’s](http://www.gutenberg.org/files/100/100-0.txt)
        - [gwicks.net](http://www.gwicks.net/dictionaries.htm)
 #
 ## Output
 ##### Will output a frequency analysis of the most common consecutive one-character, two-character, and three-character patterns. 
#
> This will allow a printing company to easily determine the most commonly used ligatures. 
#

 ## Interface
iOS App utilizes a button to input a text file and table view to show the status of frequency analysis. The frequency analysis is displayed in a SwiftUI view by clicking on the cell. (Frequency analysis must be complete to view charts)
 
 ## Frequency Analysis
Frequency analysis are conducted concurrently. Analysis can be canceled by clicking on the cell that is currently analyzing. 



