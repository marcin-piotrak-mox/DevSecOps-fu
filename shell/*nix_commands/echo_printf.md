- [echo](#paragraph1)
- [printf](#paragraph2)

# echo <a name="paragraph1"></a>


### Synopsis

`echo [-n] [string ...]`


### Description

The echo utility writes any specified operands, separated by single blank `(' ')` characters and **followed by a newline `(\n)`** character, to the standard output.


### Base execution

`echo Welcome to $0!` - evaluates variables but not special signs<br>
`echo "Welcome to $0\!"` - evaluates variables and special signs<br>
`echo 'Welcome to $0!'` - does not evaluate variables and special signs


#### Multiline, color-formatted echo command

```bash
echo -e "\e[1;37m============================================================"
echo -e "\e[1m|\e[0m                    \e[1;32mSTARTING MINIKUBE                     \e[0m|"
echo -e "\e[1;37m============================================================"
```

`\e[x;ym` – indicates the beginning of color formatting<br>
`x;ym` – color code<br>
`\e[0m` – resets color formatting to shell's default

:bulb: [Colors and formating](https://misc.flogisoft.com/bash/tip_colors_and_formatting "Bash tips: Colors and formatting")


#### Line-breaking options

`echo "Printing text with newline"` - creates a newline after executing the command<br>
`echo -n "Printing text without newline"` - does NOT create a newline after executing the command<br>
`echo -e "\nRemoving \t backslash \t characters\n"` - places a newline white sign `(\n)` before the actual echoed test and right after it in addtion to default newline

<a name="printf1.png"><img align="center" src="../../../_screenshots/printf1.png"  width="600px" alt="printf1.png"></a>

:exclamation: Differences in line braking between `echo` and `printf`. Unlike `bash` `zsh` automatically adds newline to `printf`.


# printf <a name="paragraph2"></a>


### Synopsis

`printf format [arguments ...]`


### Description

The printf utility formats and prints its arguments, after the first, under control of the format. Unlike echo command it is **NOT followed by a newline `(\n)`** character, to the standard output. The format is a character string which contains three types of objects: plain characters, which are simply copied to standard output, character escape sequences which are converted and copied to the standard output, and format specifications, each of which causes printing of the next successive argument.


### Base execution

```bash
printf "%-6s %-10s %-4s\n" Number Name Score
printf "%-6s %-10s %-4.2f\n" 1 John 80.1234
printf "%-6s %-10s %-4.2f\n" 1 Anabelle 34.4567
```
<a name="printf2.png"><img align="center" src="../../../_screenshots/printf2.png"  width="300px" alt="printf2.png"></a>


#### Format specifiers

`%s` - string (default), also interpreted as a first placeholder in this example<br>
`%-5s` - **left-alligned** (defaults to right-side allignement) string with *widght=5* digits (if value passed has more than 10 digits it will print only first 10, if less than 10, missing digits will be replaced with ' ')<br>
`%f` - float<br>
`%-4.2f` - left-alligned float with *widght=4* digits and value passed **rounded** to 2 places after coma<br>
`%d` - decimal number


#### Examples

`printf "My name is %s and my shell is "%s\n" $USER $SHELL` - passing values to two placeholders used by printf<br>
`printf("%-3d", 0)` - minimum width of three spaces, left-alligned (unless explicitly specified, right-allignment is used) - (`'0  '`)<br>
`printf("%03d", 1)` - _zero-fills_ integer output - (`'001'`); especially usefull when converting unusual format values for comparison purposes<br>
`printf("'%+5d'", 10)` - at least five-wide, with a plus sign - (`'  +10'`)<br>
`printf("'%8.2f'", 10.3456)` - eight-wide, two positions after the decimal - (`'   10.35'`)

:bulb: [printf formatting - additional documentation](https://alvinalexander.com/programming/printf-format-cheat-sheet/ "printf formatting")
