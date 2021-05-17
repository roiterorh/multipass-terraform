
### why

multipass for quick VM to create a testing env matching our production one

terraform for a simple declarative way to deploy the machines

### prepare

install terraform 
install mutipass
install libvirt (optional)

!!! to modify the driver all machines must be stopped 

```sh
multipass stop --all

```

to use libvirt
```sh
sudo multipass set local.driver=libvirt

```
to revert to default engine
```sh
sudo multipass set local.driver=qemu
```

### Config
create `config.yaml` and set the desired config

### Deploy 

simply run
```sh
tf apply 
```
### !!! Danger !!!

scripts now modify `/etc/hosts/` be sure of what you are doing 


### TODO
add switch for DNS
update on cloud init change instead of recreate
update on ressources change
