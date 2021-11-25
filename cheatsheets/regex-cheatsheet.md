Source:
- https://www.computerhope.com/unix/regex-quickref.html
- Learning Regular Expressions 1st Edition; Addison-Wesley Professional
---

# Table of contents

- [Overview](#paragraph1)
- [Matching mechanisms](#paragraph2)
  - [Literal match](#paragraph2.1)
- [Grouping](#paragraph3)
- [Escaping](#paragraph4)
- [Examples](#paragraph5)


# Overview <a name="paragraph1"></a>

> Some people, when confronted with a problem, think "I know, I'll use regular expressions." Now they have two problems.<br>
> \- Jamie Zawinski, August 12, 1997

<br>

Regular expression (RegEx for short) is a sequence of characters that define a search pattern, which is usually used by text searching algorithms for ***find*** or ***find and replace*** operations on texts, as well as in input validation. The power of regular expressions comes from its use of metacharacters, which are special characters (or sequences of characters) used to represent something else.

<br>
<p align="center"><img src="../_screenshots/regex2.png" align="center" width="500px" alt="regex2.png"></p>


# Matching mechanisms <a name="paragraph2"></a>

By default the first match in finding mode is returned. This can be overwritten using the <samp>/pattern/g</samp> (**g** for global) modifier to return all matches. Most commonly used delimiters (`[` and `]`) are conventional and can be replaced with `~`, `#`, `@`, `;`, `%` or `` ` ``.

<!-- m modifier: multi line. Causes ^ and $ to match the begin/end of each -->
<!-- i modifier: insensitive. Case insensitive match (ignores case of [a-zA-Z]) -->
<!-- x modifier: Allow comments and white space in pattern -->


## Literal match <a name="paragraph2.1"></a>

Literal match is the simplest form of regular expression.

RegEx: <samp>/code/</samp><br>
Text: "My original `code` was saved in the file code1.js and the updated version is in codeFinal.js."

> :warning: Since `g` modifier (or regex flag) wasn't used only the first match - `code` has been returned.


## Metacharacters

Metacharacters are digits with special meaning not the sign itself (literal meaning) - `\` `^` `$` `.` `*` `[`  and `]`. Two types of metacharacters can be distinguished:
- ones finding text - i.e `*` or `.`
- ones used as a part of RegEx syntax - i.e. `[pattern]` or `{pattern}`

RegEx: <samp>/1 \+ 3 \* \(2 \+ 2\)/g</samp><br>
Text: "`1 + 3 * (2 + 2)`"


### White signs metacharacters

`\b` - backspace<br>
`\f` - form feed when encountered in code, causes printers to automatically advance one full page or the start of the next page<br>
`\n` - newline feed represents the end of a line of text and the beginning of a new line<br>
`\r` - carriage return<br>
`\t` - tabulator is usually the equivalent number of five or eight spaces, depending on the program<br>
`\v` - vertical tab

RegEx: <samp>/\n\n/</samp><br>
Text: "Line one.<br>
` `<br>
Line two.<br>
Line three."

> :bulb: In Windows environment it would be best to use - RegEx:/\r\n\r\n/g since carriage return (`\r`) is used to mark end of line.

`[\f\n\r\t\v]` - can be replaced with `\s` matching **any whitespace character**<br>
`[^\f\n\r\t\v]` can be replaced with `\S` matching **any non-whitespace character**

> :exclamation: `\b` is not included in `\s` nor `\S`.


## dot `.`

`.` is one of the most commonly used metacharacters respresenting any single character (except line breakers/newline sign).

<table>
  <tr>
    <td>RegEx:</td>
    <td><samp>/code./g</samp></td>
  </tr>
  <tr>
    <td>Text:</td>
    <td>"My original code was saved in the file <code>code1</code>.js and the updated version is in <code>codeF</code>inal.js."</td>
  </tr>
  <tr>
    <td>Explanation:</td>
    <td>This syntax will match any word <b>code</b> followed by <b>any single character.</td>
  </tr>
</table>

RegEx: <samp>/code./g</samp><br>
Text: "My original code was saved in the file `code1`.js and the updated version is in `codeF`inal.js."<br>
Explanation: This syntax will match any word **code** followed by **any single character**.

> :warning: Since `g` modifier (alternatively called regex flag) has beeen used all matches of `code.` were returned.


## Character class

A character class is an explicit list of the characters that may qualify for a match in a search. A character class is indicated by enclosing a class of characters in brackets (`[` and `]`). Anything enclosed with `[` and `]` is a part of the class, meaning **any of the class characters must match, but not necessarily all**.

RegEx: <samp>/[XYZ]code\.js/g</samp><br>
Text: "I have few JS files named `Xcode.js`, `Ycode.js` and `Zcode.js` but I don’t have the file file named Wcode.js or g`Xcode.js`."<br>
Explanation: "(...) Wcode.js (...)" part wasn’t matched because not all conditions of regex were met - "W" isn’t part of "[XYZ]". "(...) gXcode.js" is an example when RegEx pattern should be more specific so that it would match pattern only when it's not a part of a string.

RegEx: <samp>/[Cc]ode\.js/g</samp><br>
Text: "There are two files, `Code.js` and `code.js`."

> Other very rarely used character class can match the following:
> - hexadecimal digit like `\xOA` can be searched using - `\O`
> - octal digit like `\011` can be searched using - `\z`
> - control class like `\cZ` equal to `Ctrl+Z` can be searched using - `\c`


## Character range

Range of characters **within a class** can be defined using dash (`-`) between two values. Following class `[0123456789]` can be simplified to `[0-9]`. Similarly defining non-numbers, i.e. `[ABCDEFGHIJKLMNOPQRSTUVWXYZ]` can be simplified to `[A-Z]` improving class visibility significantly. Same applies to lower case letters. Reverse ranges such as `[Z-A]` or `[5-1]` are not accepted. Dash (`-`) becomes a metacharacter only when used in a class (i.e. `[x-z]`), otherwise it is interpreted as a literal.

RegEx: <samp>/[A-Za-z0-9]\.js/g</samp><br>
Text: "There are three files, `a.js`, `B.js` and `5.js`."

`[0-9]` can be replaced as `[\d]` matching **any number**<br>
`[^0-9]` or `[a-zA-z]` can be replaced as `[\D]` matching **any sign different from numbers**<br>
`[0-9a-zA-Z_]` can be replaced as `[\w]` matching **any alphanumeric sign** and **underscore**<br>
`[^0-9a-zA-Z_]` can be replaced as `[\W]` matching **any non-alphanumeric sign** and **underscore**

> :warning: `[A-z]` would match all signes from `A` to `z`, but it is tricky to use this range since it also icludes signs like `^` or `[` that happen to be located between in ASCII table.

RegEx: <samp>/[\d]\.js/g</samp><br>
Text: "There are three files, a.js, B.js and `5.js`."

RegEx: <samp>/[\D]\.js/g</samp><br>
Text: "There are three files, `a.js`, `B.js` and 5.js."


## Negated character class/range

Placing caret (`^`) metacharacter after the opening square bracket of a character class can be used to deny all multiple character classes/ranges at once.

RegEx: <samp>/[^0-9]/g</samp><br>
Text: "`Today is `2018`, I am `20` years old.`"

RegEx: <samp>/[^0-9^A-Z]/g</samp><br>
Text: "T`oday is `2018`, `I` am `20` years old.`"


## POSIX standard <a name="paragraph4"></a>

POSIX standard provides simplification in defining character classes or categories of characters for variety of platform supporting regex implementation.

| POSIX        | ASCII           | Shorthand | Description
| :---         | :---            | :---:     | :---
| `[:alnum:]`  | `[A-Za-z0-9]`   |           | digits, upper and lowercase letters
| `[:alpha:]`  | `[A-Za-z]`      |           | upper and lowercase letters
| `[:blank:]`  | `[ \t]` 	       | `\h`      | space and tab characters only
| `[:cntrl:]`  |	               |           | control characters
| `[:digit:]`  | `[0-9]` 	       | `\d`      | digits
| `[:graph:]`  | `[^ [:cntrl:]]` |           | graphic characters (all characters wwith graphic representation)
| `[:lower:]`  | `[a-z]`	       | `\l`      | lowercase letters
| `[:print:]`  | `[[:graph:] ]`  |           | graphic characters and space
| `[:punct:]`  |              	 |           | punctuation (all graphic characters except letters and digits)
| `[:space:]`  | `[ \t\n\r\f\v]` | `\s`      | whitespace characters
| `[:upper:]`  | `[A-Z]`	       | `\u`      | uppercase letters
| `[:xdigit:]` | `[0-9A-Fa-f]`   |           | hexadecimal digits
| `[:word:] `  | `[[:alnum:]_]`  | `\w`      | alphanumeric characters with underscore character _, meaning alnum + _. It is a bash specific character class


## Quantifiers

Quantifiers allow to declare quantities of data as part of pattern. For instance, ability to match exactly six spaces, or locate every numeric string that is between four and eight digits in length.

`?` - matches `0` or `1` of the preceding character or class

RegEx: <samp>/br?eak/g</samp><br>
Text: "`break` and `beak`"

RegEx: <samp>/Jan(uary)?/g</samp><br>
Text: "`Jan` and `January`"

RegEx: <samp>/Jan(uary)? 5(th)?/g</samp><br>
Text: "`Jan 5th` and `Jan 5` and `January 5th` and `January 5`"

`+` - matches `1` or more instances of the preceding character or class

RegEx: <samp>/[0-9]+/g</samp><br>
Text: "`123`abc`456`"<br>
Text: "aa`1234`bb"<br>
Text: "+`1001234`"

`*` - matches `0` or more instances of the preceding character or class

RegEx: <samp>/abc[0-9]*/g</samp><br>
Text: "`abc`"<br>
Text: "`abc0`"<br>
Text: "`abc123`"

## Intervals

Intervals are specified between `{` and `}` metacharacters. They can take either one argument for exact interval matching `{X}`, or two arguments for range interval matching `{min, max}`. If the comma is present but max is omitted, the maximum number of matches is **infinite** and the minimum number of matches is **at least min**.

`?` metacharacter is equivalent to `{0,1}`<br>
`+` metacharacter is equivalent to `{1,}`


<!-- ## Lookahead & Lookbehind
`a(?=b)` 	Match a in baby but not in bay
`a(?!b)` 	Match a in Stan but not in Stab
`(?<=a)b` 	Match b in crabs but not in cribs
`(?<!a)b` 	Match b in fib but not in fab -->


### Overmatching

`+` and `*` metacharacters are **greedy** and by default will try to match maximum they can.

RegEx: <samp>/<[Bb]>.*<\/[Bb]>/g</samp><br>
Text: "`<b>First</b> and <b>Second</b>` words bold"

**Lazy** matching on the other hand tries to match the minimum it can.

RegEx: <samp>/<[Bb]>.*?<\/[Bb]>/g</samp><br>
Text: "`<b>First</b>` and `<b>Second</b>` words bold"

`*` (greedy) vs `*?` (lazy)<br>
`+` (greedy) vs `+?` (lazy)<br>
`?` (greedy) vs `??` (lazy)<br>
`{x,}` (greedy) vs `{x,}?` (lazy)


## Anchors

Anchors and boundaries allow to describe text in terms of where it's located. Anchors specify **an exact position and this position only**, in the string or text where an occurence of a match is necessary.

Caret (`^`) is a start of line/string anchor in multi-line pattern which specifies that a match must occur at the **beginning of the line/string**.

RegEx: <samp>/^www/g</samp><br>
Text: "Check out those two websites - `www`<span>.wp.pl and `www`<span>.google.pl."

`\A` is a start of string anchor which specifies that a match must occur at the **beginning of the string**.

Dollar (`$`) is a end of line/string anchor in multi-line pattern, that indicates that a match must occur at the **end of the line/string**.

RegEx: <samp>/pl$/g</samp><br>
Text: "Check out those two websites - www<span>.wp.`pl` and www<span>.google.`pl`."

`\Z` is a end of string anchor which specifies that a match must occur at the **end of the string**.

`\z` is an absolute end of string anchor which specifies that a match must occur at the **absolute end of the string**.

A single character before the caret or after the dollar sign causes the match to fail:
- /^Begin/ will not match " Begin"<br>
- /end$/ will not match "end."<br>
- /^A$/ will not match "AA"


## Boundaries

`\b` - word boundary matches pattern if it is at the beggining or the end of a word
`\B` - non-word boundary matches pattern if it is not at the beginning or end of the word

RegEx: <samp>/\bnumber\b/g</samp><br>
Text: "I declared a `number` variable named my-number-var."

RegEx: <samp>/\Bnumber\B/g</samp><br>
Text: "I declared a number variable named my-`number`-var." <br>
Explanation: It is important to use the \b on both sides of the pattern. E.g. if used only at the beginning (\bnumber) it would match both occurences - "I declared a `number` variable named my-`number`-var." ,because regex only validates the starting word. Meanwhile, the ending one (number\b) will match anything ending with the word number.

`<\` - matches pattern only if it is at the beginning of a word<br>
`>\` - matches pattern only if it is at the end of a word

RegEx: <samp>/<\var/g</samp><br>
Text: "I declared a number `var`iable named my-number-var."

RegEx: <samp>/>\var/g</samp><br>
Text: "I declared a number variable named my-number-`var`."


# Grouping <a name="paragraph3"></a>

Grouping allows treating another expression as a single unit. To group expressions following metacharacters should be used - `(` and `)`.

RegEx: <samp>/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/g</samp><br>
Text: "This is a valid IP address: `127.0.0.1`"

Above example can be simplified using grouping metacharacters.

RegEx: <samp>/(\d{1,3}\.){3}\d{1,3}/g</samp><br>
Text: "This is a valid IP address: `127.0.0.1`"

<!-- (abc) 	Capture group
(a|b) 	Match a or b
(?:abc) 	Match abc, but don’t capture -->


# Escaping <a name="paragraph4"></a>

To escape metacharacters they must be preceded with a backslash. Backslash itself must be preceded with another backslash.

`\` -> `\\`<br>
`^` -> `\^`<br>
`$` -> `\$`<br>
`.` -> `\.`<br>
`*` -> `\*`<br>
`[` -> `\[`<br>
`]` -> `\]`


## Examples <a name="paragraph5"></a>

`/((?<=\/).*){2}/` - This will match whatever is written after second occurance of `/` (without the sign itself) sign till the end of the string
