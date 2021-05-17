import os
import sys
import json
import subprocess
import tempfile

def find_vm(name):
    cmd = ["multipass", "list", "--format=json"]
    out = subprocess.check_output(cmd)
    vms = json.loads(out)
    for vm in vms["list"]:
        if vm["name"] == name:
            return {
                "name": name,
                "ip": vm["ipv4"][0],
                "release": vm["release"],
                "state": vm["state"]
            }
    return None

def delete_vm(name):
    cmd = ["multipass", "delete",
             name,"--purge"]
    res = subprocess.check_output(cmd)

name = os.environ['MULTIPASS_NAME']
mem = os.environ['MULTIPASS_MEM']
disk = os.environ['MULTIPASS_DISK']
cpu = os.environ['MULTIPASS_CPU']


res = delete_vm(name)
    