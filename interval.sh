#!/bin/sh

# Name of the process to monitor
PROCESS_NAME="docker-proxy"

# Initialize counter for intervals
interval=0

# Loop until the process is no longer found
while true; do
    # Check if the process is running
    if ps aux | grep -v grep | grep -q "$PROCESS_NAME"; then
        echo "Process $PROCESS_NAME is running. Waiting for 10 seconds..."
        sleep 10
        interval=$((interval + 1))  # Increment the interval counter

        # Check if interval is equal to 5
        if [ "$interval" -eq 5 ]; then
            echo "Interval reached 5. Running additional commands..."
            # Your additional commands here
            echo "Additional commands executed."
            interval=0  # Reset the interval counter
        fi
    else
        echo "Process $PROCESS_NAME not found. Executing other commands..."
        # Your other commands here
        echo "Other commands executed. Exiting loop."
        break
    fi
done

