import os
import sys
import json
import subprocess
import tempfile



def create_vm(name, cpu, mem, disk, data):
    cmd = ["multipass", "launch",
            "--name", name,
            "--cpus", cpu,
            "--disk", disk,
            "--mem", mem,
            "--cloud-init", 'scripts/init/cloud_init_'+name+'.yaml',
            image
            ]
    res = subprocess.check_output(cmd)
    
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

name = os.environ['MULTIPASS_NAME']
mem = os.environ['MULTIPASS_MEM']
disk = os.environ['MULTIPASS_DISK']
cpu = os.environ['MULTIPASS_CPU']
image = os.environ['MULTIPASS_IMAGE']

data=(os.path.dirname(__file__)+'/init/cloud-init_'+name+'.yaml')
create_vm(name, cpu, mem, disk, data)
print(json.dumps(find_vm(name)))