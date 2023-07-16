## SSH Tunnel Checker

This script checks if a specific port is listening and opens an SSH tunnel if it's not. It can be useful for setting up secure connections to remote services.

### Usage

The script accepts the following command line arguments:

```bash
./check_tunnel.sh <target_host> <target_port> [ssh_username] [identity_key_path]
```
target_host: The hostname or IP address of the target server.
target_port: The port number to check and open the SSH tunnel for.
ssh_username (optional): The SSH username to use for the tunnel. If not provided, the default username will be used.
identity_key_path (optional): The path to the identity key file for SSH authentication. If not provided, the default key path will be used.
To use the script, follow these steps:

Clone this repository navigate to the folder and add execution rights:
```bash
git clone https://github.com/your-username/ssh-tunnel-checker.git
cd ssh-tunnel-checker
chmod +x check_tunnel.sh
./check_tunnel.sh <target_host> <target_port> [ssh_username] [identity_key_path]
```
once active this can be added to a cron job to keep the tunnel alive
Running the Script as a Cron Job
To automate the execution of the script using a cron job, follow these steps:

Edit the crontab file using the crontab -e command:

```bash
crontab -e
Add an entry to the crontab file to specify the desired schedule and the script's absolute path:
```

```ruby
# Example cron job to run the script every 5 minutes
*/5 * * * * /path/to/ssh-tunnel-checker/check_tunnel.sh <target_host> <target_port> [ssh_username] [identity_key_path]
```
Adjust the schedule and script path according to your requirements.
Save and exit the crontab file. The cron job will now execute as per the specified schedule.
Make sure to replace <target_host>, <target_port>, [ssh_username], and [identity_key_path] with the actual values you want to use.
Note: When running the script using a cron job, ensure that the SSH key file permissions are appropriately set and accessible by the user executing the script.
