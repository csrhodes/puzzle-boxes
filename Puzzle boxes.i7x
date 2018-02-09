Puzzle boxes by Christophe Rhodes begins here.

"Functional code for puzzle box objects."

"based on productions and descriptions by Matthew Deline, Tommy Graven, Raymond Vermeulen, Doruk Hasdogan, Ece Hasdogan, Wichaya Karnchanapee, Alex Fletcher"

Book 1 - helpful functionality

Part 1 - helpful extensions

Include Bitwise Operators by Bart Massey.

Include Glulx Text Effects by Emily Short.

Part 2 - LEDs

An LED is a kind of thing.  An LED can be on or off.  An LED is usually off.

Does the player mean pushing an LED: it is very unlikely.

Part 3 - Keyboards

A keyboard is a kind of thing.

Typing it on is an action applying to one topic and one touchable thing and requiring light.

Check typing the topic understood on something which is not a keyboard:
	say "[The second noun] is not a keyboard." instead.

Understand "type [text] into/on [something]" as typing it on.

Rule for supplying a missing second noun when typing the topic understood on:
	If the player can touch a keyboard (called target):
		now the second noun is the target;
		say "(on [the second noun])[command clarification break]";
	otherwise:
		say "Specify what to type on!"

Understand "type [text]" as typing it on.  Understand the commands "key" and "input" as "type".

[ we might also want to understand "enter ..." as typing, but the default parser has "enter ..." to enter enterable containers and/or doors.  We can override the default parser with 'understand the command "enter" as something new' ]

Part 4 - Dials

A dial is a kind of thing.  A dial has a number called the minimum setting.  A dial has a number called the maximum setting.  A dial has a number called the setting.

Clockwise is a direction.  The printed name is "clockwise".
Anticlockwise is a direction.  The printed name is "anticlockwise".  Understand "counterclockwise/widdershins" as anticlockwise.

Instead of setting a dial to:
	if the topic understood matches "[number]":
		let N be the number understood;
		if N is greater than the maximum setting of the noun, say "too high!" instead;
		if N is less than the minimum setting of the noun, say "too low!" instead;
		now the setting of the noun is N.

Turning it is an action applying to one touchable thing and one visible thing.

Understand "turn [something] [direction]" as turning it.

Check turning it when the noun is not a dial (this is the can't turn non-dials rule):
	say "[The noun] does not turn.".

Check turning it when the noun is a dial (this is the can't turn dials in non-rotations rule):
	if the second noun is clockwise or the second noun is anticlockwise, continue the action;
	say "I don't think turning [the noun] [second noun] makes sense." instead.

Check turning it when the noun is a dial (this is the can't turn past extreme settings rule):
	if the second noun is clockwise:
		if the setting of the noun is the maximum setting of the noun:
			say "[The noun] is already at its most [second noun] setting." instead;
	otherwise:
		if the setting of the noun is the minimum setting of the noun:
			say "[The noun] is already at its most [second noun] setting." instead.

Carry out turning it when the noun is a dial:
	if the second noun is clockwise:
		now the setting of the noun is 1 + the setting of the noun;
	otherwise:
		now the setting of the noun is the setting of the noun - 1.

Report turning it when the noun is a dial:
	say "You turn [the noun] [second noun].".

Part 5 - Resetting

Resetting is an action applying to one touchable thing and requiring light.  Understand "reset [something]" as resetting.

Check resetting:
	if the noun is not a puzzle box, say "You don't know how to reset [the noun]." instead. 

Part 6 - Puzzle boxes

A puzzle box is a kind of container.

Rule for printing room description details of a puzzle box (this is the don't print status for puzzle box in room descriptions rule): stop.
Rule for printing the name of a puzzle box while taking inventory (this is the don't print status for puzzle box in inventory rule):
	say "[printed name of the noun]";
	omit contents in listing.

Does the player mean doing something with a puzzle box: it is very likely.

Check opening a puzzle box (this is the puzzle boxes aren't that easy to open rule):
	say "This puzzle box does not simply open!  You will have to find a way to convince it to let you open it." instead.

Book 2 - Puzzle boxes

Part 1 - the Mario puzzle box

[ Matthew Deline and Tommy Graven ]

The Mario puzzle box is a closed openable puzzle box.  The description is "[Mario puzzle box description].".  The indefinite article is "the".

Check opening the Mario puzzle box:
	say "Try as you might, you can't see how to open the box straightforwardly, and it looks too precious to use brute force." instead.

To say Mario puzzle box description:
	if the Mario puzzle box is closed:
		say "[The Mario puzzle box] is a cube, about the width of a cubit.  Five of the six faces are painted in a strong yellow, with an embossed question mark lacquered with a glossy white; on the top face, below the question mark, is printed [Mario puzzle box question description]  The sixth face presents a keypad with the numbers 0 to 9; three LEDs; and an OLED display.  [Mario puzzle box display description]";
	else:
		say "There is a conspicuous lack of princess in the remnants of the box.  [Mario puzzle box display description]"

The Mario puzzle box question is part of the Mario puzzle box.  The description is "[Mario puzzle box question description]".

To say Mario puzzle box question description:
	say "'You may have seen me before; in what year was I born?'[run paragraph on]"

The Mario puzzle box display is part of the Mario puzzle box.  The description is "[Mario puzzle box display description].".  The Mario puzzle box display has a text called charstate.  The charstate of the puzzle box display is "".

To say Mario puzzle box display description:
	say "[if the number of characters in the charstate of the Mario puzzle box display > 0]The display currently reads '[Mario puzzle box display characters]'[else]The display is currently empty[end if]".

To say Mario puzzle box display characters:
	repeat with I running from 1 to the number of characters in the charstate of the Mario puzzle box display:
		say "*".
		
The Mario puzzle box red LED is an LED.  It is part of the Mario puzzle box.  The printed name is "red LED on the Mario puzzle box".  The description is "a [if the Mario puzzle box red LED is on]lit [end if]red LED".

The Mario puzzle box yellow LED is an LED.  It is part of the Mario puzzle box.  The printed name is "yellow LED on the Mario puzzle box".  The description is "a [if the Mario puzzle box yellow LED is on]lit [end if]yellow LED".

The Mario puzzle box green LED is an LED.  It is part of the Mario puzzle box.  The printed name is "green LED on the Mario puzzle box".  The description is "a [if the Mario puzzle box green LED is on]lit [end if]green LED".

The Mario puzzle box keypad is part of the Mario puzzle box.  The description is "A standard key pad with the digits 0 to 9."

The Mario puzzle box keypad is a keyboard.  It is part of the Mario puzzle box.

Check typing the topic understood on the Mario puzzle box keypad (this is the only digits on the keypad rule):
	if the topic understood exactly matches the regular expression "\d+":
		continue the action;
	say "You can't type [the topic understood] into [the Mario puzzle box keypad], as it has only decimal digits." instead.

Check typing the topic understood on the Mario puzzle box keypad (this is the don't type when it's open rule):
	if the Mario puzzle box is open:
		say "Typing more on the open box keypad is fruitless." instead.

Carry out typing the topic understood on the Mario puzzle box keypad:
	let n be the number of characters in the topic understood;
	let charstate be "[the charstate of the Mario puzzle box display]";
	repeat with i running from 1 to n:
		now charstate is "[charstate][character number i in the topic understood]";
		if charstate matches the text "1985":
			now the Mario puzzle box green LED is on;
		else if the number of characters in charstate is 4:
			now charstate is "";
			now the Mario puzzle box yellow LED is off;
			now the Mario puzzle box red LED is on;
		else:
			now the Mario puzzle box yellow LED is on;
			now the Mario puzzle box red LED is off;
	now the charstate of the Mario puzzle box display is charstate.
	
Report typing the topic understood on the Mario puzzle box keypad:
	let n be the number of characters in the topic understood;
	let charstate be "[the charstate of the Mario puzzle box display]";
	if n is 1:
		if charstate matches the text "1985":
			say "the very moment you type, the green LED lights up and the box springs open!";
			now the Mario puzzle box is open;
		else if the number of characters in charstate is 0:
			say "the very moment you type, the red LED lights up and the display clears.";
		else:
			say "[if the number of characters in charstate is 1]the yellow LED lights up, and [end if]the display now has one[if the number of characters in charstate > 1] more[end if] asterisk.";
	else:
		say "with each digit that you type, the yellow LED lights up briefly.  You type, character by character, until ";
		if charstate matches the text "1985":
			say "you type a 5, whereupon the box suddenly springs open!";
			now the Mario puzzle box is open;
		else if the number of characters in charstate is 0:
			say "the red LED lights up and the display clears as you type the final digit.";
		else:
			say "as you type the final digit you notice the yellow LED is lit, and the display shows '[Mario puzzle box display characters]'".

An Arduino UNO is a thing in the Mario puzzle box.  The description is "you admire the neatly cabled wires surrounding this mystical piece of hardware.".

Check taking the Arduino UNO for the first time:
	say "You reach for the Arduino, then hesitate... to disturb the neatness of the cables would be tantamount to a crime." instead.

Check taking the Arduino UNO:
	say "You resist the temptation to disturb the UNO from its tidy nest of cables." instead.

Bowser is an animal in the Mario puzzle box.  The description is "a sharp-shelled yellow turtle.".

Check resetting the Mario puzzle box (this is the don't reset an already reset Mario box rule):
	if the Mario puzzle box is closed and the charstate of the Mario puzzle box display exactly matches the text "":
		say "[The Mario puzzle box] is already in its initial state." instead;
	continue the action.

After resetting the Mario puzzle box:
	if the Mario puzzle box is open:
		say "You close [the Mario puzzle box]";
		if the charstate of the Mario puzzle box display exactly matches the text "":
			do nothing;
		else:
			say ", and type on the keypad to clear the display.";
	else:
		say "You type on [the Mario puzzle box keypad] to clear the display.";
	now the Mario puzzle box is closed;
	now the charstate of the Mario puzzle box display is "".

Part 2 - the Simon Says puzzle box

[ Raymond Vermeulen ]

The Simon Says puzzle box is a closed puzzle box.  The description is "A small, grey cube, with four LEDs arranged in a line.  Parallel to that line is a row of four buttons, each aligned with the respective LED.  There is also, set to the side, a power switch and a button marked 'reset'.".  The Simon Says puzzle box can be switched on or switched off.  It is switched off.  It has a list of numbers called target.  It has a list of numbers called state.

The Simon Says puzzle box first LED is an LED.  It is part of the Simon Says puzzle box.
The Simon Says puzzle box second LED is an LED.  It is part of the Simon Says puzzle box.
The Simon Says puzzle box third LED is an LED.  It is part of the Simon Says puzzle box.
The Simon Says puzzle box fourth LED is an LED.  It is part of the Simon Says puzzle box.

The Simon Says puzzle box first button is part of the Simon Says puzzle box.  The Simon Says puzzle box second button is part of the Simon Says puzzle box.  The Simon Says puzzle box third button is part of the Simon Says puzzle box.  The Simon Says puzzle box fourth button is part of the Simon Says puzzle box.  The Simon Says puzzle box reset button is part of the Simon Says puzzle box.

Table 2.1 - Simon Says components
Name	ID	Button							LED
"first"	1	Simon Says puzzle box first button	Simon Says puzzle box first LED
"second"	2	Simon Says puzzle box second button	Simon Says puzzle box second LED
"third"	3	Simon Says puzzle box third button	Simon Says puzzle box third LED
"fourth"	4	Simon Says puzzle box fourth button	Simon Says puzzle box fourth LED

To reset the Simon Says puzzle box:
	now the target of the Simon Says puzzle box is {};
	now the state of the Simon Says puzzle box is {};
	repeat with i running from 1 to 4:
		let j be a random number between 1 and 4;
		add j to the target of the Simon Says puzzle box;
	say "As you do so, the LEDs briefly light up in sequence: ";
	repeat with i running from 1 to the number of entries in the target of the Simon Says puzzle box:
		let j be entry i in the target of the Simon Says puzzle box; 
		say "[name in row j of the Table of Simon Says components][if i < 4], [else].[end if]".

Check resetting the Simon Says puzzle box (this is the can't reset a box that's switched off rule):
	if the Simon Says puzzle box is switched off, say "You can't reset it; it's not on!" instead.

After resetting the Simon Says puzzle box:
	say "You push the reset button.  [run paragraph on]";
	reset the Simon Says puzzle box.

Instead of pushing the Simon Says puzzle box reset button:
	try resetting the Simon Says puzzle box.

After switching on the Simon Says puzzle box:
	say "You turn the power on to the Simon Says puzzle box.  [run paragraph on]";
	reset the Simon Says puzzle box.

To win the Simon Says puzzle box:
	say "As you do, all the LEDs on the box light up at once!";
	repeat through the Table of Simon Says components:
		let L be the LED entry;
		now L is on.

After pushing when the noun is part of the Simon Says puzzle box:
	say "You push [the noun], with a [one of]quiet[or]sharp[or]resounding[at random] click";
	let n be the ID corresponding to a button of the noun in the Table of Simon Says components;
	add n to the state of the Simon Says puzzle box;
	let l be the number of entries in the state of the Simon Says puzzle box;
	if the number of entries in the target of the Simon Says puzzle box is l:
		repeat with i running from 1 to l:
			if entry i in the target of the Simon Says puzzle box is not entry i in the state of the Simon Says puzzle box:
				say ".";
				stop the action;
		say ".  [run paragraph on]";
		win the Simon Says puzzle box;
	else:
		say ".".

Part 3 - the 3x3 puzzle box

[ Wichaya Karnchanapee, Doruk Hasdogan, Ece Hasdogan ]

The 3x3 puzzle box is a closed openable puzzle box.  The 3x3 puzzle box has a number called 3x3state.  The 3x3state of the 3x3 puzzle box is 511.  The description is "The small box has a 3x3 keypad, and a corresponding 3x3 display.  The display currently reads:[line break][state of the 3x3 puzzle box][paragraph break]".  The 3x3 puzzle box display is part of the 3x3 puzzle box.  The description is "The display on [the 3x3 puzzle box] reads:[line break][state of the 3x3 puzzle box][paragraph break]".

To say state of the 3x3 puzzle box:
	say "[conditional paragraph break][fixed letter spacing]";
	let B be 512;
	repeat with i running from 1 to 9:
		now B is B / 2;
		if B bit-and the 3x3state of the 3x3 puzzle box is not 0:
			say "*";
		otherwise:
			say ".[run paragraph on]";
		if i is 3 or i is 6:
			say "[line break]";
	say "[variable letter spacing]".

Some things which are parts of the 3x3 puzzle box are defined by the table of 3x3 buttons.

Table 3.1 - 3x3 buttons
Button					Bitmask
3x3 puzzle box button 11	484
3x3 puzzle box button 12	466
3x3 puzzle box button 13	457
3x3 puzzle box button 21	316
3x3 puzzle box button 22	186
3x3 puzzle box button 23	121
3x3 puzzle box button 31	295
3x3 puzzle box button 32	151
3x3 puzzle box button 33	79

Instead of pushing when the noun is part of the 3x3 puzzle box and the 3x3 puzzle box is open:
	say "The buttons on [the 3x3 puzzle box] are inoperative while the box is open."

Carry out pushing when the noun is part of the 3x3 puzzle box:
	let B be the Bitmask corresponding to a Button of the noun in the table of 3x3 buttons;
	now the 3x3state of the 3x3 puzzle box is B bit-xor the 3x3state of the 3x3 puzzle box;
	if the 3x3state of the 3x3 puzzle box is 0:
		now the 3x3 puzzle box is open.

After pushing when the noun is part of the 3x3 puzzle box:
	say "You push [the noun], and the display changes to:[line break][state of the 3x3 puzzle box][paragraph break]";
	if the 3x3state of the 3x3 puzzle box is 0:
		say "There is a whirr, a click, and [the 3x3 puzzle box] opens!".

After resetting the 3x3 puzzle box:
	repeat with i running from 1 to 6:
		choose a random row in the table of 3x3 buttons;
		let B be the Bitmask entry;
		now the 3x3state of the 3x3 puzzle box is B bit-xor the 3x3state of the 3x3 puzzle box;
	if the 3x3state of the 3x3 puzzle box is 0:
		now the 3x3state of the 3x3 puzzle box is 79;
	say "[if the 3x3 puzzle box is open]You close the 3x3 puzzle box, and as you do the display changes to read:[else]You give the box a gentle shake, and the display rearranges itself to read:[end if][line break][state of the 3x3 puzzle box]";
	if the 3x3 puzzle box is open:
		now the 3x3 puzzle box is closed.

Part 4 - the "Audio Frequency" Hangul syllable block puzzle box

[ Alex Fletcher.  Special prize for making me render audio chords as Hangul syllable blocks. ]

Table of User Styles (continued)
style name		justification		relative size
special-style-1	center-justified	10

The Hangul syllable puzzle box is a closed openable puzzle box.  It has a number called code.  The code is 44567.  The description is "On the top of the box are a button labelled 'open', and three dials labelled 'choseong', 'jungseong' and 'jongseong', each with a display showing a glyph: [reading of the choseong dial], [reading of the jungseong dial], and [reading of the jongseong dial] respectively.  The side of the box displays a larger glyph:[line break][first custom style][Unicode char number code of the Hangul syllable puzzle box][roman type]".  It has a number called attempts.  The attempts is 0.

The choseong dial is a dial.  It is part of the Hangul syllable puzzle box.  The minimum setting is 4352.  The maximum setting is 4370.  The setting is 4352.

The jungseong dial is a dial.  It is part of the Hangul syllable puzzle box.  The minimum setting is 4449.  The maximum setting is 4469.  The setting is 4449.

The jongseong dial is a dial.  It is part of the Hangul syllable puzzle box.  The minimum setting is 4520.  The maximum setting is 4546.  The setting is 4520.

The Hangul syllable puzzle box open button is part of the Hangul syllable puzzle box.

To say reading of (D - a dial which is part of the Hangul syllable puzzle box):
	let N be the setting of D;
	say Unicode char number N.

To decide what Unicode character is Unicode char number (N - a number): (- {N} -).

Check pushing the Hangul syllable puzzle box open button:
	if the Hangul syllable puzzle box is open:
		say "[The Hangul syllable puzzle box] is already open, so pushing the button isn't going to help matters." instead.

Carry out pushing the Hangul syllable puzzle box open button:
	now the attempts of the Hangul syllable puzzle box is 1 + the attempts of the Hangul syllable puzzle box;
	let C be the code of the Hangul syllable box;
	let L be the setting of the choseong dial;
	let V be the setting of the jungseong dial;
	let T be the setting of the jongseong dial;
	let CP be 44032 + (T - 4519) + ((V - 4449) * 28) + ((L - 4352) * 588);
	if C is CP:
		now the Hangul syllable puzzle box is open;
	else:
		maybe blow up the Hangul syllable puzzle box.

Report pushing the Hangul syllable puzzle box open button:
	if the Hangul syllable puzzle box is open:
		say "The three glyphs by the dials light up in succession, then all together, producing a calming, sonorous chord.  The large glyph on the side of the puzzle box glows a deep orange, pulsating, and you hear a whirr as the box opens to reveal [if the Hangul syllable puzzle box contains nothing]an empty space[else]its contents: [list of things contained by the Hangul syllable puzzle box with indefinite articles][end if].";
	else if the attempts of the Hangul syllable puzzle box is 5:
		say "As you press the button, as the dials emit a discordant chord and the glyph on the side of the puzzle box glows deep red, you hear a faint crump from inside the box.";
	else:
		say "As you press the button, each dial emits a chime, discordant in their combination, and the large glyph on the side of the puzzle box glows red.";
	stop the action.
	
To maybe blow up the Hangul syllable puzzle box:
	if the attempts of the Hangul syllable puzzle box is 5:
		repeat with C running through things contained by the Hangul syllable puzzle box:
			now C is nowhere.

After resetting the Hangul syllable puzzle box:
	now the Hangul syllable puzzle box is closed;
	let L be a random number between 1 and 19;
	let V be a random number between 1 and 21;
	let T be a random number between 1 and 27;
	let C be T + (V * 28) + (L * 588) + 44032;
	now the code of the Hangul syllable puzzle box is C.

Puzzle boxes ends here.
