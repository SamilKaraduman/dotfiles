#!/bin/bash

# Fetch the YouTube URL from the clipboard
url=$(pbpaste)

# Define the output directory
output_dir="$HOME/Downloads"

# Download the audio and convert to MP3 format
yt-dlp --extract-audio --audio-format mp3 "$url" -o "$output_dir/%(title)s.%(ext)s"

echo "Audio has been downloaded to your Downloads folder."

