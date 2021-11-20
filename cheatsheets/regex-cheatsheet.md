<p align="center"><img src="../screenshots/regex2.png" align="center" width="500px" alt="regex2.png"></p>


# Overview

A regular expression is a sequence of characters that define a search pattern, which is usually used by string searching algorithms for “find” or “find and replace” operations on strings, as well as in input validation.


# General rules
By default the first match in finding mode is returned. This can be overwritten using the “/pattern/g(global)” parameter to return all matches.


## Literal match
RegEx: /code/g
String: “My original code was saved in the file code1.js and the updated version is in codeFinal.js.”


## dot (.)

/code./ - this will match any word “code” followed by any single character (except line breakers/newline sign)
RegEx: /code./g
String: “My original code was saved in the file code1.js and the updated version is in codeFinal.js.”


## Metacharacters

metacharacters are digits with special meaning not the sign itself (literal meaning).
there are two types of metacharacters:
ones finding text - “*”
ones used as a part of RegEx syntax - “[“ or “]”
to escape metacharacters precede them with a backslash.
to escape backslash precede it with another backslash.
RegEx: /1 \+ 3 \* \(2 \+ 2\)/
String: “1 + 3 * (2 + 2)”


## White signs metacharacters

[\b] - backspace
\f - form feed
\n - line feed
\r - carriage return
\t - tabulator
\v - vertical tab
RegEx: /\n\n/
String: “Line one.
asdasfasfasdfasfsdfsdfsdfsdfsdfsdfsfd
Line three”

### White signs metacharacters shorthands:
[\f\n\r\t\v] can be simply replaced as [\s] matching any whitespace character
[^\f\n\r\t\v] can be simply replaced as [\S] matching any non-whitespace character
NOTE: [\b] is not included in \s nor \S.


## Character classes

character classes allow matching a set of characters.
defined using the metacharacters [ ].
everything between them is a part of the set, which means any one of the set characters must match (but not all).
RegEx: /[XYZ]code\.js/
String: “I have few JS files named Xcode.js, Ycode.js and Zcode.js but I don’t have the file file named Wcode.js or gXcode.js.”
“... Wcode.js ...” part wasn’t matched because all (“W” isn’t part of “[XYZ]”) conditions of regex have to be met.
“...gXcode.js” is an example when RegEx pattern should be more specific.
RegEx: /[Cc]ode\.js/
String: “There are two files, Code.js and code.js.”


## Range of characters (set of characters)

range of characters within a class can be defined using dash “-” between two values. [0123456789] is equal to [0-9], same rule applies to character sets defining non-numbers.
reverse ranges such as [Z-A] or [5-1] do not work.
dash “-” becomes a metacharacter only when used in a class (“[xyz]”), otherwise it is interpreted as a literal.
RegEx: /[A-Za-z0-9]\.js/
String: “There are two files, a.js and B.js and 5.js.”

### Set of characters shorthands:
[0-9] can be simply replaced as [\d] matching any number.
[^0-9] or [a-zA-z] can be simply replaced as [\D] matching any sign different from numbers.
[0-9a-zA-Z] can be simply replaced as [\w] matching any alphanumeric sign.
[^0-9a-zA-Z] can be simply replaced as [\W] matching any non-alphanumeric sign.

RegEx: /[d]\.js/
String: “There are two files, a.js and B.js and 5.js.”
RegEx: /[\D]\.js/
String: “There are two files, a.js and B.js and 5.js.”


## Negated character classes/sets

caret (^) metacharacter can be used to deny a character class/set. This can be achieved by placing it after the opening square bracket of a character set.
multiple character sets can be negated at once.
it negates all characters defined in the set.
RegEx: /[^0-9]/
String: “Today is 2018, I am 20 years old.”
RegEx: /[^0-9^A-Z]/
String: “Today is 2018, I am 20 years old.”


## Quantifiers

? - matches zero or one of the preceding character or set.
RegEx: /br?eak/
String: “break and beak”
RegEx: /Jan(uary)?/ will match both Jan and January
String: “Jan and January”
RegEx: /Jan(uary)? 5(th)?/ will match January 5th, January 5, Jan 5th and Jan 5
String: “Jan 5th and Jan 5 and January 5th and January 5”

+ - matches one or more instances of the preceding character or set.
RegEx: /[0-9]+/
String: “123abc456”
String: “aa1234bb”
String: “+1001234”

* - matches zero or more instances of the preceding character or set.
RegEx: /abc[0-9]*/
String: “abc”
String: “abc0”
String: “abc123”


## Anchors

anchors specify an exact position in the string or text where an occurence of a match is necessary.
it looks for a match in that specified position only.
a single character before the caret or after the dollar sign causes the match to fail.
/^Begin/ will not match “ Begin”
/end$/ will not match “end.”
/^A$/ will not match “AA”
The caret (^) is a start of string anchor, which specifies that a match must occur at the beginning of the line/string.
RegEx: /^www/
String: “www.wp.pl, www.google.pl”
The dollar ($) is the end anchor, that indicates the end of the line/string.
RegEx: /pl$/
String: “www.wp.pl, www.google.pl”




TODO: Stopped working on it here.
## Intervals
Intervals are specified between { and } metacharacters. They can take either one argument for exact interval matching {X}, two arguments for range interval matching {min, max}. If the comma is present but max is omitted, the maximum number of matches is infinite and the minimum number of matches is at least min.
? metacharacter is equivalent to {0,1}
+ metacharacter is equivalent to {1,}




## Word boundaries
\b - word boundary
\B - non-word boundary
RegEx: /\bnumber\b\/
String: “I declared a number variable named my_number_var.”
RegEx: /\Bnumber\/
String: “I declared a number variable named my_number_var.”
NOTE: It is important to use the \b on both sides of the pattern. For example, if you use it only at the beginning (\bnumber) then it will match both:
String: “I declared a number variable named my_number_var.”
because regex only validates is the starting word. Meanwhile, the ending one (number\b) will match anything ending with the word number.



## Overmatching
+ and * metacharacters are greedy and by default will try to match maximum they can.
RegEx: /<[Bb]>.*<\/[Bb]>/
String: “<b>First</b> and <b>Second</b> words bold”
Lazy matching on the other hand tries to match the minimum it can.
RegEx: /<[Bb}>.*?<\/[Bb]>/
String: “<b>First</b> and <b>Second</b> words bold”
* (greedy) vs *? (lazy)
+ (greedy) vs +? (lazy)
? (greedy) vs ?? (lazy)
{x,} (greedy) vs {x,}? (lazy)

# Grouping
To group expressions following metacharacters should be used ( and ).
RegEx: /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/
String: “This is a valid IP address: 127.0.0.1”
This can be simplified using grouping metacharacters.
RegEx: /(\d{1,3}\.){3}\d{1,3}/
String: “This is a valid IP address: 127.0.0.1”



/((?<=\/).*){2}/
#This will match whatever is written after second occurance of "/" (without the sign itself) sign till the end of the string.
