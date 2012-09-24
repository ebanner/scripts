#!/bin/bash

# allows the user to easily create a story

echo -n "Story Name: "
read
story_name=$REPLY

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

echo
echo "Story Name: ${story_name}"
echo "As a ${as_a},"
echo "I want $i_want"
echo "So that ${so_that}."
echo
echo "Acceptance Criteria:"
echo "Given ${given},"
echo "When ${when}"
echo "Then ${Then}."

exit 0
