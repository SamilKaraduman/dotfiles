#!/bin/bash

# Fetch the YouTube URL from the clipboard
url=$(pbpaste)

# Define the output directory
output_dir="$HOME/Downloads"

# Download the video in the highest quality and merge video and audio
yt-dlp -f bestvideo+bestaudio --merge-output-format mp4 "$url" -o "$output_dir/%(title)s.%(ext)s"

echo "Video has been downloaded to your Downloads folder."

