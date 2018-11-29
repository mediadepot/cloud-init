# Usage

1. Download bootable CoreOS image from https://coreos.com/os/docs/latest/booting-with-iso.html
2. Create bootable USB/CD with contents of CoreOS image
3. Start server and boot from CoreOS USB/CD.
4. Determine the OS installation disk
    ```bash
    sudo fdisk -l

    # note, the boot disk will probably be /dev/loop0
    ```
5. Copy the ignition remote config bootstrap file to the file system
    ```bash
    curl -O https://mediadepot.github.io/ignition/ignition-remote.json
    ```
6. Begin CoreOS installation on specified disk, **NOTE: specified disk will be reformatted**
    ```bash
    sudo coreos-install -d /dev/sda -C stable -i ignition-remote.json
    ```

7. On installation completion, remove bootable USB/CD
8. Restart server
9. Wait for CoreOS to start and `cloud-init` process to complete.
10. Go to `http://depot:50000` to see Rancher v2 dashboard and begin setup.




# References


## CoreOS configuration
- https://coreos.com/os/docs/latest/booting-with-iso.html
- https://davranetworks.atlassian.net/wiki/spaces/MAN/pages/80936975/Bare+metal+install+of+CoreOS
- https://coreos.com/os/docs/latest/installing-to-disk.html
- https://gist.github.com/phumpal/d0007d314a12ee9c015e
- https://coreos.com/ignition/docs/latest/
- https://coreos.com/ignition/docs/latest/examples.html
- https://coreos.com/validate/
- https://github.com/coreos/ignition/blob/master/doc/configuration-v2_2.md
- `journalctl --identifier=ignition`


# SystemD
- https://container-solutions.com/running-docker-containers-with-systemd/
- https://developer.atlassian.com/blog/2015/03/docker-systemd-socket-activation/
- https://karlstoney.com/2017/03/03/docker-containers-as-systemd-services/
- https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux_atomic_host/7/html/managing_containers/using_systemd_with_containers
- https://forums.docker.com/t/running-docker-containers-with-systemd-question/52681
- https://forums.docker.com/t/any-simple-and-safe-way-to-start-services-on-centos7-systemd/5695/11
- https://fardog.io/blog/2017/12/30/running-docker-containers-with-systemd/
- https://blog.marcnuri.com/docker-container-as-linux-system-service/
- https://unix.stackexchange.com/questions/441894/wait-to-start-transmission-daemon-until-after-usb-drive-has-mounted
- `systemctl list-units --all`
-

## MergerFS
- https://github.com/mitre/fusera/wiki/FUSE-and-Docker
- https://serverfault.com/questions/632075/convert-an-fstab-entry-to-a-systemd-mount-unit-on-coreos
- https://hynek.me/articles/docker-signals/
- https://blog.packagecloud.io/eng/2015/10/13/inspect-extract-contents-rpm-packages/
- https://github.com/coreos/bugs/issues/641
- https://github.com/coreos/bugs/issues/358
- http://webcache.googleusercontent.com/search?q=cache:NVzT88tLQD0J:www.ulabs.uservers.net/howtos/glusterfs-coreos.php+&cd=6&hl=en&ct=clnk&gl=us
- https://www.mikenowak.org/working-around-read-file-systems-coreos-overlay/


```
docker run -it -v `pwd`:/mounted centos /bin/bash
curl -O -L https://github.com/trapexit/mergerfs/releases/download/2.25.1/mergerfs-2.25.1-1.el7.x86_64.rpm
rpm2cpio mergerfs-2.25.1-1.el7.x86_64.rpm | cpio -idmv
cp -r bin/ /mounted/files/
```

- `mount -o "lowerdir=/usr/sbin,upperdir=/opt/sbin,workdir=/opt/sbin.workdir" -t overlay overlay /usr/sbin`

## Samba


## Rancher Config
- https://github.com/jmreicha/awesome-rancher
- https://rancher.com/docs/rancher/v2.x/en/upgrades/rollbacks/single-node-rollbacks/
- https://rancher.com/docs/rancher/v2.x/en/installation/single-node/
- https://rancher.com/docs/rancher/v2.x/en/backups/backups/single-node-backups/