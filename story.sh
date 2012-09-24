#!/bin/bash

# allows the user to easily create a story

TD='<td>'
ETD='</td>'

echo -n "Story Name: "
read
story_name=$REPLY

echo -n "Size: "
read
size=$REPLY

echo -n "Priority: "
read
priority=$REPLY

echo -n "As a: "
read
as_a=$REPLY

echo -n "I want: "
read
i_want=$REPLY

echo -n "So that: "
read
so_that=$REPLY

echo
echo -n "Acceptance Criteria: "
read
acceptance_criteria=$REPLY

echo -n "Given: "
read
given=$REPLY

echo -n "When: "
read
when=$REPLY

echo -n "Then: "
read
Then=$REPLY

echo '<tr>'
echo "$TD${story_name}$ETD"
echo "$TD${size}$ETD"
echo "$TD${priority}$ETD"
echo "$TD${as_a}$ETD"
echo "$TD${i_want}$ETD"
echo "$TD${so_that}$ETD"
echo "$TD${acceptance_criteria}$ETD"
echo "$TD${given}$ETD"
echo "$TD${when}$ETD"
echo "$TD${Then}$ETD"
echo '</tr>'

exit 0
