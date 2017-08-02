FROM lambdalinux/baseimage-amzn:2017.03-003

CMD ["/sbin/my_init"]

COPY [ \
  "./extras/etc-mock-default.cfg", \
  "./extras/etc-sudoers.d-docker", \
  "/tmp/docker-build/" \
]

RUN \
  # yum
  yum update && \
  \
  # install mock
  yum install git && \
  yum install sudo && \
  yum install tree && \
  yum install vim && \
  yum install which && \
  # setup epll repository
  curl -X GET -o /tmp/docker-build/RPM-GPG-KEY-lambda-epll https://lambda-linux.io/RPM-GPG-KEY-lambda-epll && \
  rpm --import /tmp/docker-build/RPM-GPG-KEY-lambda-epll && \
  curl -X GET -o /tmp/docker-build/epll-release-2017.03-1.2.ll1.noarch.rpm https://lambda-linux.io/epll-release-2017.03-1.2.ll1.noarch.rpm && \
  yum install /tmp/docker-build/epll-release-2017.03-1.2.ll1.noarch.rpm && \
  yum -y --enablerepo=epll install mock mock-scm && \
  \
  # setup symbolic link
  ln -s /home/ll-user/mock-builder/git-blobs /tmp/git-blobs.lambda-linux.io && \
  \
  # copy mock configuration file
  cp /tmp/docker-build/etc-mock-default.cfg /etc/mock/default.cfg && \
  \
  # setup sudo
  usermod -a -G wheel ll-user && \
  cp /tmp/docker-build/etc-sudoers.d-docker /etc/sudoers.d/docker && \
  chmod 440 /etc/sudoers.d/docker && \
  \
  # cleanup
  rm -rf /tmp/docker-build
