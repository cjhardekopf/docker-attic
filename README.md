docker-attic
============

Attic deduplicating backup program. You can specify ssh configuration using volumes:
* /ssh_config
* /known_hosts
* /id_rsa

If you want to use sshfs so that a remote machine does not need to have attic installed you can specify the sshfs mount using an environment variable SSHFS and it will be mounted at /sshfs. Of course, in order to use sshfs the docker container must be privileged.
