#!/usr/bin/env python3

import sys
import signal
import subprocess


###
# GLOBALS
###

AWS_REGION  = 'ap-southeast-2'


###
# MAIN METHOD
###

def main():
    # Check args
    cluster_name, command_line = check_args()

    # Configure access to cluster
    update_kube_config(cluster_name)

    # Execute
    execute_command(command_line)


####
# SUB METHODS
####

# Usage info
def usage():
    script_name = sys.argv[0]
    print(f'usage: {script_name} cluster_name "some command"')
    print()
    print('examples:')
    print(f'       {script_name} cluster_name "k9s"')
    print(f'       {script_name} cluster_name "kubectl get nodes"')
    print(f'       {script_name} cluster_name "helm -n product list"')
    sys.exit(1)


# Check command line
def check_args():
    # Show usage
    if len(sys.argv) <= 2:
        usage()

    # Get cluster and command
    cluster_name = sys.argv[1]
    command_line = ' '.join(sys.argv[2:])

    return cluster_name, command_line



# Cluster login
def update_kube_config(cluster_name):
    # Create command
    cmd = f'aws eks update-kubeconfig --name {cluster_name} --region {AWS_REGION}'

    # Execute
    p = subprocess.Popen(cmd, shell=True)
    p.communicate()


# Run command
def execute_command(cmd):
    p = subprocess.Popen(cmd, shell=True)
    p.communicate()


# Die nicely
def signal_handler(signal, frame):
    print(' ')
    sys.exit(0)


####
# MAIN
####

# Set up Ctrl-C handler
signal.signal(signal.SIGINT, signal_handler)

# Invoke main method
if __name__ == '__main__':
    main()
