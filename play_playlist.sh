#!/bin/bash

while true; do
  # Set the channel to transmit on
  channel=87.5

  # Get the folder of audio files
  folder=<path_to_folder>

  # Get a list of all audio files in the folder
  files=($folder/*)

  cd <path_to_fm_transmitter>

  # Loop through all audio files
  for file in "${files[@]}"; do
    # Transmit the current audio file using fm_transmitter
    sudo ./fm_transmitter -f $channel "$file" &

    # Wait for the current audio file to finish playing
    wait $!

    # Check if the transmission was successful
    if [ $? -eq 0 ]; then
      # Transmission was successful, move on to the next audio file
      continue
    else
      # Transmission failed, exit the script
      echo "Transmission of $file failed."
      exit 1
    fi
  done
done
