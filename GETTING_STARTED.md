# `mock-builder`

`mock-builder` is a docker container used by Lambda Linux Project to build and maintain RPMs for Amazon Linux.

## Building `mock-builder` container

```
$ cd ~/mock-builder

$ docker build -t mock-builder:latest .
```

## Running `mock-builder` container

```
$ cd ~/mock-builder

$ docker run --rm -h ll-builder-1.build --privileged=true -t -v `pwd`:/home/ll-user/mock-builder -i mock-builder /sbin/my_init -- /usr/bin/sudo -i -u ll-user
```

Once inside the container, set the `mock` environment

```
[ll-user@ll-builder-1] ~ $ source ~/mock-builder/bin/setpath
```

To build package

```
[ll-user@ll-builder-1] ~ $ mock --buildsrpm --scm-enable --scm-option package=<package_name> --scm-option branch=<branch_name>

[ll-user@ll-builder-1] ~ $ cd ~/mock-builder/builddir/amzn/build/SOURCES/
[ll-user@ll-builder-1] ~/mock-builder/builddir/amzn/build/SOURCES $ git fat init; git fat pull; cd ~/mock-builder/
[ll-user@ll-builder-1] ~/mock-builder $ mock --shell "chown -R mockbuild:mockbuild /builddir/build/SOURCES"

[ll-user@ll-builder-1] ~/mock-builder $ mock --rebuild <srpm_package>
[ll-user@ll-builder-1] ~/mock-builder $ mock --no-clean --rebuild <srpm_package>
```
