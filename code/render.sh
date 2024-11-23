#!/bin/sh -ex

# Split transcription columns into lines
python3 split_mdc_lines.py

# Render each transcription line
mdc2png/mdc2png ../lines/*.txt

# Build the website
python3 generate_webpage.py
