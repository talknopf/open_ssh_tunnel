#!/bin/bash

# Function to check if a port is open
is_port_open() {
  host=$1
  port=$2
  timeout=$3

  # Try to connect to the port and check the result
  (echo >/dev/tcp/$host/$port) >/dev/null 2>&1
  result=$?

  if [ $result -eq 0 ]; then
    echo "Port $port is open"
    return 0
  elif [ $result -eq 1 ]; then
    echo "Port $port is closed"
    return 1
  else
    echo "An error occurred while checking port $port"
    return 2
  fi
}

# Check if the required arguments are provided
if [ $# -lt 2 ]; then
  echo "Usage: $0 <target_host> <target_port> [ssh_username] [identity_key_path]"
  exit 1
fi

target_host=$1
target_port=$2

# Check if the target port is open
is_port_open $target_host $target_port

if [ $? -eq 0 ]; then
  echo "SSH tunnel is not required. Port $target_port is already open on $target_host."
else
  echo "SSH tunnel is required. Opening the tunnel..."

  ssh_command="ssh -L 127.0.0.1:$target_port:$target_host:$target_port -f -N"
  
  if [ $# -ge 3 ]; then
    ssh_username=$3
    ssh_command+=" -l $ssh_username"
  fi

  if [ $# -ge 4 ]; then
    identity_key_path=$4
    if [ -f "$identity_key_path" ]; then
      ssh_command+=" -i $identity_key_path"
    else
      echo "Identity key file '$identity_key_path' not found."
      exit 1
    fi
  fi

  # Run the SSH tunnel command
  $ssh_command $target_host
fi
