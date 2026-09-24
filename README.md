# GABE
"GABE isn't bytecode execution"

An esolang that really sucks to write in

This esolang technically only has 3 usable inputs, R, A, and E
<pre>
R -- Moves the pointer right
A -- Adds to where the pointer currently is
E -- Ends the script
</pre>

So how is this turing complete you ask? well...

To make this useful, the tape is the actual logic, example:
<pre>
Cell 1: 1
Cell 2: 2
Cell 3: 1
</pre>

This script sets register 2 to 1, here's how you would write it

RA RAA RA

It looks like you're screaming at someone in plaintext.

Here's what each opcode does in this forbidden assembly
<pre>
1: Set Register/ SET <reg> <arg> -- Sets register <reg> to <arg>, if this register does not exist, creates it
2: Remove Register / REM <reg> -- Removes a register from the table
3: Add To Register/ ADD <reg> <arg> -- Adds <arg> to <reg>
4: Subtract From Register/ SUB <reg> <arg> -- Subtracts <arg> from <reg>
5: Marker / MRK -- Leaves a marker at that location in memory
6: Jump / JMP <mrk> -- Jumps to <mrk> location, <mrk> must be the marker number
7: Compare / CMP <arg1> <arg2> -- Compares these two values and sets the compflag to true or false, true if <arg1> is greater than <arg2>, else is false
8: Branch If Compflag / BCP <mrk> -- If the compflag is true, jump to <mrk>
9: Branch If Not Compflag / NCP <mrk> -- If the compflag is false, jump to <mrk>
10: Compare Include Equal / CIE <arg1> <arg2> -- Compare instruction, difference being instead of greater than, it's greater than or equal to that will return true
11: Compare Only Equal / CEQ <arg1> <arg2> -- Compare instruction, but checks only if arg2 is equal to arg1
12: Remove Marker / RMM <mrk> -- Removes a marker
13: Output Register / OUT <reg> -- Outputs a register to the terminal
14: Output Register In ASCII / OAS <reg> -- Outputs a register to the terminal as an ASCII character
15: Takes a single user input
</pre>

== Examples ==

Hello World
RA RA RAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

RA RAA RAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

RA RAAA RAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

RA RAAAA RAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

RA RAAAAA RAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

RA RAAAAAA RAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

RA RAAAAAAA RAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

RA RAAAAAAAA RAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

RA RAAAAAAAAA RAAAAAAAAAA


RAAAAAAAAAAAAAA RA
RAAAAAAAAAAAAAA RAA
RAAAAAAAAAAAAAA RAAA
RAAAAAAAAAAAAAA RAAA
RAAAAAAAAAAAAAA RAAAA
RAAAAAAAAAAAAAA RAAAAA
RAAAAAAAAAAAAAA RAAAAAA
RAAAAAAAAAAAAAA RAAAA
RAAAAAAAAAAAAAA RAAAAAAA
RAAAAAAAAAAAAAA RAAA
RAAAAAAAAAAAAAA RAAAAAAAA

RAAAAAAAAAAAAAA RAAAAAAAAA

E

Alphabet Printer
A RAAA RAAAAAAAAAA -- line feed register

RA RA RA
RA RAA RAAAAAAAAAAAAAAAAAAAAAAAAAA
RA RAAAA RAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

RAAAAA -- this is the marker for bcp

RAAAAAAA RAA RA
RAAAAAAAAAAAAAA RAAAA -- prints register 4
RAAA RA RA -- increments reg 1
RAAA RAAAA RA

RAAAAAAAAAAAAAA RAAA -- this prints line feed

RAAAAAAAA RA

E
