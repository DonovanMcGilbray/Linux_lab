#!/bin/bash
echo "What's your name?"
read NAME
if [ -z "$NAME" ]; then
echo "You didn't enter anything"
NAME="Student"
fi
echo "Hello $NAME"
echo "You are: $(whoami)"
echo "ln: $(pwd)"
