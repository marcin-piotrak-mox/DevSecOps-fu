Source:
- Learning Regular Expressions 1st Edition; Addison-Wesley Professional
- https://www.computerhope.com/unix/regex-quickref.html
---

# Table of contents

- [Overview](#paragraph1)
- [Matching mechanisms](#paragraph2)
  - [Literal match](#paragraph2.1)


# Overview <a name="paragraph1"></a>

> Some people, when confronted with a problem, think "I know, I'll use regular expressions." Now they have two problems.<br>
> \- Jamie Zawinski, August 12, 1997

<br>

Regular expression (RegEx for short) is a sequence of characters that define a search pattern, which is usually used by text searching algorithms for ***find*** or ***find and replace*** operations on texts, as well as in input validation. The power of regular expressions comes from its use of metacharacters, which are special characters (or sequences of characters) used to represent something else.

<br>
<p align="center"><img src="../_screenshots/regex2.png" align="center" width="500px" alt="regex2.png"></p>


# Matching mechanisms

By default the first match in finding mode is returned. This can be overwritten using the "/pattern/g" (g stands for global) modifier to return all matches. Most commonly used delimiters (`[` and `]`) are conventional and can be replaced with `~`, `#`, `@`, `;`, `%` or `` ` ``.

<!-- m modifier: multi line. Causes ^ and $ to match the begin/end of each -->
<!-- i modifier: insensitive. Case insensitive match (ignores case of [a-zA-Z]) -->
<!-- x modifier: Allow comments and white space in pattern -->


## Literal match <a name="paragraph2"></a>

Literal match is the simplest form of regular expression.

RegEx: /code/<br>
Text: "My original `code` was saved in the file code1.js and the updated version is in codeFinal.js."

> :warning: Since `g` modifier (or regex flag) wasn't used only the first match - `code` has been returned.


## Metacharacters

Metacharacters are digits with special meaning not the sign itself (literal meaning) - `\` `^` `$` `.` `*` `[`  and `]`. Two types of metacharacters can be distinguished:
- ones finding text - i.e `*` or `.`
- ones used as a part of RegEx syntax - i.e. `[pattern]` or `{pattern}`

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

`[\f\n\r\t\v]` - can be replaced as `\s` matching **any whitespace character**
`[^\f\n\r\t\v]` can be replaced as `\S` matching **any non-whitespace character**

> :exclamation: `\b` is not included in `\s` nor `\S`.


## dot `.`

`.` is one of the most commonly used metacharacters respresenting any single character (:exclamation:except line breakers/newline sign).

RegEx: /code./g<br>
Text: "My original code was saved in the file `code1`.js and the updated version is in `codeF`inal.js."
Explanation: This syntax will match any word **code** followed by **any single character**.

> :warning: Since `g` modifier (or regex flag) has beeen used all matches of - `code.` have been returned.


## Character set (class)

A character set is an explicit list of the characters that may qualify for a match in a search. A character set is indicated by enclosing a set of characters in brackets (`[` and `]`). Anything enclosed with `[` and `]` is a part of the class, meaning **any of the class characters must match, but not necessarily all**.

RegEx: /[XYZ]code\.js/g<br>
Text: "I have few JS files named `Xcode.js`, `Ycode.js` and `Zcode.js` but I don’t have the file file named Wcode.js or g`Xcode.js`."
Explanation: "(...) Wcode.js (...)" part wasn’t matched because not all conditions of regex were met - "W" isn’t part of "[XYZ]". "(...) gXcode.js" is an example when RegEx pattern should be more specific so that it would match pattern only when it's not a part of a string.

RegEx: /[Cc]ode\.js/g<br>
Text: "There are two files, `Code.js` and `code.js`."


## Character range

Range of characters within a class can be defined using dash (`-`) between two values. In other words `[0123456789]` is equal to `[0-9]`, same rule applies to character sets defining non-numbers, i.e. `[ABCDEFGHIJKLMNOPQRSTUVWXYZ]` can be simplified to `[A-Z]`. Same applies to lower case letters. Reverse ranges such as `[Z-A]` or `[5-1]` are not accepted. Dash (`-`) becomes a metacharacter only when used in a class (i.e. `[x-z]`), otherwise it is interpreted as a literal.

RegEx: /[A-Za-z0-9]\.js/g<br>
Text: "There are three files, `a.js`, `B.js` and `5.js`."

`[0-9]` can be replaced as [\d] matching **any number**
`[^0-9]` or `[a-zA-z]` can be replaced as [\D] matching **any sign different from numbers**
`[0-9a-zA-Z]` can be replaced as [\w] matching **any alphanumeric sign**
`[^0-9a-zA-Z]` can be replaced as [\W] matching **any non-alphanumeric sign**

RegEx: /[d]\.js/g<br>
Text: "There are three files, a.js, B.js and `5.js`."

RegEx: /[\D]\.js/g<br>
Text: "There are three files, `a.js`, `B.js` and 5.js."


## Negated character set/range

Placing caret (`^`) metacharacter after the opening square bracket of a character set can be used to deny all multiple character sets/ranges.

RegEx: /[^0-9]/g<br>
Text: "`Today is `2018`, I am `20` years old.`"

RegEx: /[^0-9^A-Z]/g<br>
Text: "T`oday is `2018`, `I` am `20` years old.`"


## Quantifiers

Quantifiers allow to declare quantities of data as part of pattern. For instance, ability to match exactly six spaces, or locate every numeric string that is between four and eight digits in length.

`?` - matches `0` or `1` of the preceding character or set

RegEx: /br?eak/g<br>
Text: "`break` and `beak`"

RegEx: /Jan(uary)?/g<br>
Text: "`Jan` and `January`"

RegEx: /Jan(uary)? 5(th)?/g<br>
Text: "`Jan 5th` and `Jan 5` and `January 5th` and `January 5`"

`+` - matches `1` or more instances of the preceding character or set

RegEx: /[0-9]+/g<br>
Text: "`123`abc`456`"
Text: "aa`1234`bb"
Text: "+`1001234`"

`*` - matches `0` or more instances of the preceding character or set

RegEx: /abc[0-9]*/g<br>
Text: "`abc`"
Text: "`abc0`"
Text: "`abc123`"


### Overmatching

`+` and `*` metacharacters are **greedy** and by default will try to match maximum they can

RegEx: /<[Bb]>.*<\/[Bb]>/<br>
Text: "`<b>First</b> and <b>Second</b>` words bold"

Lazy matching on the other hand tries to match the minimum it can.
RegEx: /<[Bb]>.*?<\/[Bb]>/<br>
Text: "`<b>First</b>` and `<b>Second</b>` words bold"

`*` (greedy) vs `*?` (lazy)
`+` (greedy) vs `+?` (lazy)
`?` (greedy) vs `??` (lazy)
`{x,}` (greedy) vs `{x,}?` (lazy)


## Anchors

Anchors and boundaries allow to describe text in terms of where it's located. Anchors specify **an exact position and this position only**, in the string or text where an occurence of a match is necessary.

Caret (`^`) is a start of string anchor which specifies that a match must occur at the beginning of the line/string.

RegEx: /^www/g
Text: "Check out those two websites - `www`<span>.wp.pl and `www`<span>.google.pl."

Dollar (`$`) is the end of string anchor, that indicates that a match must occur at the end of the line/string.

RegEx: /pl$/g<br>
Text: "Check out those two websites - www<span>.wp.`pl` and www<span>.google.`pl`."

A single character before the caret or after the dollar sign causes the match to fail:
- /^Begin/ will not match " Begin"
- /end$/ will not match "end."
- /^A$/ will not match "AA"


## Boundaries

`\b` - word boundary matches pattern if it is at the beggining or the end of a word
`\B` - non-word boundary matches pattern if it is not at the beginning or end of the word

RegEx: /\bnumber\b/<br>
Text: "I declared a `number` variable named my_number_var."

RegEx: /\Bnumber\B/<br>
Text: "I declared a number variable named my_`number`_var."
Explanation: It is important to use the \b on both sides of the pattern. E.g. if used only at the beginning (\bnumber) it would match both occurences - "I declared a `number` variable named my_`number`_var." ,because regex only validates the starting word. Meanwhile, the ending one (number\b) will match anything ending with the word number.

`<\` - matches pattern only if it is at the beginning of a word
`>\` - matches pattern only if it is at the end of a word

RegEx: /<\var/<br>
Text: "I declared a number `var`iable named my_number_var."

RegEx: />\var/<br>
Text: "I declared a number variable named my_number_`var`."


## Intervals

Intervals are specified between `{` and `}` metacharacters. They can take either one argument for exact interval matching `{X}`, or two arguments for range interval matching `{min, max}`. If the comma is present but max is omitted, the maximum number of matches is **infinite** and the minimum number of matches is **at least min**.

`?` metacharacter is equivalent to `{0,1}`
`+` metacharacter is equivalent to `{1,}`


# Grouping

Grouping allows treating another expression as a single unit. To group expressions following metacharacters should be used - `(` and `)`.

RegEx: /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/
Text: "This is a valid IP address: `127.0.0.1`"

Above example can be simplified using grouping metacharacters.

RegEx: /(\d{1,3}\.){3}\d{1,3}/
Text: "This is a valid IP address: `127.0.0.1`"


# Escaping

To escape metacharacters they must be preceded with a backslash. Backslash itself must be preceded with another backslash.

`\` -> `\\`
`^` -> `\^`
`$` -> `\$`
`.` -> `\.`
`*` -> `\*`
`[` -> `\[`
`]` -> `\]`


## Examples

`/((?<=\/).*){2}/` - This will match whatever is written after second occurance of `/` (without the sign itself) sign till the end of the string
