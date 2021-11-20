Source:
- Learning Regular Expressions 1st Edition; Addison-Wesley Professional
- https://www.computerhope.com/unix/regex-quickref.html
---

# Table of contents

- [Overview](#paragraph1)
- [Matching](#paragraph2)
  - [Literal match](#paragraph2.1)


# Overview <a name="paragraph1"></a>

> Some people, when confronted with a problem, think "I know, I'll use regular expressions." Now they have two problems.<br>
> \- Jamie Zawinski, August 12, 1997

<br>

Regular expression (RegEx for short) is a sequence of characters that define a search pattern, which is usually used by text searching algorithms for ***find*** or ***find and replace*** operations on texts, as well as in input validation.

<p align="center"><img src="../_screenshots/regex2.png" align="center" width="500px" alt="regex2.png"></p>


# Matching

By default the first match in finding mode is returned. This can be overwritten using the "/pattern/g" (g stands for global) modifier to return all matches.
<!-- m modifier: multi line. Causes ^ and $ to match the begin/end of each -->
<!-- i modifier: insensitive. Case insensitive match (ignores case of [a-zA-Z]) -->
<!-- /regex/ delimiters are conventional and can be replaced with ~ # @ ; % or `. -->

## Literal match <a name="paragraph2"></a>

RegEx: /code/g
Text: "My original `code` was saved in the file code1.js and the updated version is in codeFinal.js."


## dot `.`

/code./ - this syntax will match any word **code** followed by **any single character** (except line breakers/newline sign)

RegEx: /code./g<br>
Text: "My original code was saved in the file `code1`.js and the updated version is in `codeF`inal.js."

:warning: If `g` modifier (or regex flag) wouldn't be used only the first match - `code1` would have been returned.


## Metacharacters

- [x] metacharacters are digits with special meaning not the sign itself (literal meaning)
- [x] there are two types of metacharacters:
    - ones finding text - "*"
    - ones used as a part of RegEx syntax - `[` or `]`

RegEx: /1 \+ 3 \* \(2 \+ 2\)/g<br>
Text: "`1 + 3 * (2 + 2)`"


### White signs metacharacters

`\b` - backspace
`\f` - form feed
`\n` - line feed
`\r` - carriage return
`\t` - tabulator
`\v` - vertical tab

RegEx: /\n\n/<br>
Text: "Line one.
`Line two.`
Line three."


#### White signs metacharacters shorthands:

`[\f\n\r\t\v]` - can be replaced as `\s` matching **any whitespace character**
`[^\f\n\r\t\v]` can be eplaced as `\S` matching **any non-whitespace character**

:exclamation: `\b` is not included in `\s` nor `\S`.


## Character classes

- [x] allow matching a number of characters
- [x] defined using `[` and `]` metacharacters
- [x] anything enclosed with `[` and `]` is a part of the class, meaning any of the class characters must match (but not all)

RegEx: /[XYZ]code\.js/g<br>
Text: "I have few JS files named `Xcode.js`, `Ycode.js` and `Zcode.js` but I don’t have the file file named Wcode.js or g`Xcode.js`."

:bulb: "... Wcode.js ..." part wasn’t matched because not all ("W" isn’t part of "[XYZ]") conditions of regex were met
:bulb: "...g`Xcode.js`" is an example when RegEx pattern should be more specific

RegEx: /[Cc]ode\.js/g<br>
Text: "There are two files, `Code.js` and `code.js`."


## Range of characters (set of characters)

- [x] range of characters within a class can be defined using dash `-` between two values
- [x] `[0123456789]` is equal to `[0-9]`, same rule applies to character sets defining non-numbers
- [x] reverse ranges such as `[Z-A]` or `[5-1]` do not work
- [ ] dash `-` becomes a metacharacter only when used in a class (`[x-z]`), otherwise it is interpreted as a literal

RegEx: /[A-Za-z0-9]\.js/g<br>
Text: "There are three files, `a.js`, `B.js` and `5.js`."


### Set of characters shorthands:

- [x] [0-9] can be replaced as [\d] matching any number
- [x] [^0-9] or [a-zA-z] can be replaced as [\D] matching any sign different from numbers
- [x] [0-9a-zA-Z] can be replaced as [\w] matching any alphanumeric sign
- [x] [^0-9a-zA-Z] can be replaced as [\W] matching any non-alphanumeric sign

RegEx: /[d]\.js/g<br>
Text: "There are three files, a.js, B.js and `5.js`."

RegEx: /[\D]\.js/g<br>
Text: "There are three files, `a.js`, `B.js` and 5.js."


## Negated character classes/sets

- [x] caret (^) metacharacter can be used to deny a character class/set; this can be achieved by placing it after the opening square bracket of a character set
- [x] multiple character sets can be negated at once
- [x] it negates all characters defined in the set

RegEx: /[^0-9]/g<br>
Text: "`Today is `2018`, I am `20` years old.`"

RegEx: /[^0-9^A-Z]/g<br>
Text: "T`oday is `2018`, `I` am `20` years old.`"


## Quantifiers

`?` - matches zero or one of the preceding character or set

RegEx: /br?eak/<br>
Text: "break and beak"

RegEx: /Jan(uary)?/<br> will match both Jan and January
Text: "Jan and January"

RegEx: /Jan(uary)? 5(th)?/ will match January 5th, January 5, Jan 5th and Jan 5
Text: "Jan 5th and Jan 5 and January 5th and January 5"

`+` - matches one or more instances of the preceding character or set

RegEx: /[0-9]+/<br>
Text: "123abc456"
Text: "aa1234bb"
Text: "+1001234"

`*` - matches zero or more instances of the preceding character or set

RegEx: /abc[0-9]*/<br>
Text: "abc"
Text: "abc0"
Text: "abc123"


## Anchors

- [x] anchors specify an exact position in the string or text where an occurence of a match is necessary.
- [x] it looks for a match in that specified position only.
- [x] a single character before the caret or after the dollar sign causes the match to fail.

/^Begin/ will not match " Begin"
/end$/ will not match "end."
/^A$/ will not match "AA"

The caret (^) is a start of string anchor, which specifies that a match must occur at the beginning of the line/stringext.

RegEx: /^www/
Text: "Check out those two websites - www.wp.pl and www.google.pl."
The dollar ($) is the end anchor, that indicates the end of the line/stringext.

RegEx: /pl$/<br>
Text: "Check out those two websites - www.wp.pl and www.google.pl."




TODO: Stopped working on it here.
## Intervals
Intervals are specified between { and } metacharacters. They can take either one argument for exact interval matching {X}, two arguments for range interval matching {min, max}. If the comma is present but max is omitted, the maximum number of matches is infinite and the minimum number of matches is at least min.
? metacharacter is equivalent to {0,1}
+ metacharacter is equivalent to {1,}




## Word boundaries

`\b` - word boundary
`\B` - non-word boundary

RegEx: /\bnumber\b\/<br>
Text: "I declared a number variable named my_number_var."

RegEx: /\Bnumber\/<br>
Text: "I declared a number variable named my_number_var."

NOTE: It is important to use the \b on both sides of the pattern. For example, if you use it only at the beginning (\bnumber) then it will match both

Text: "I declared a number variable named my_number_var."<br>
because regex only validates is the starting word. Meanwhile, the ending one (number\b) will match anything ending with the word number.



## Overmatching

+ and * metacharacters are greedy and by default will try to match maximum they can

RegEx: /<[Bb]>.*<\/[Bb]>/<br>
Text: "<b>First</b> and <b>Second</b> words bold"

Lazy matching on the other hand tries to match the minimum it can.
RegEx: /<[Bb}>.*?<\/[Bb]>/<br>
Text: "<b>First</b> and <b>Second</b> words bold"

* (greedy) vs *? (lazy)
+ (greedy) vs +? (lazy)
? (greedy) vs ?? (lazy)
{x,} (greedy) vs {x,}? (lazy)

# Grouping
To group expressions following metacharacters should be used ( and ).
RegEx: /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/
Text: "This is a valid IP address: 127.0.0.1"
This can be simplified using grouping metacharacters.
RegEx: /(\d{1,3}\.){3}\d{1,3}/
Text: "This is a valid IP address: 127.0.0.1"

# Escaping

to escape metacharacters precede them with a backslash.
to escape backslash precede it with another backslash.


/((?<=\/).*){2}/
#This will match whatever is written after second occurance of "/" (without the sign itself) sign till the end of the string.
