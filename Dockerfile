FROM lambdalinux/amzn-2015.09:004

CMD ["/sbin/my_init"]

VOLUME ["/tmp/docker-build"]
COPY [ \
  "./extras/RPM-GPG-KEY-lambda-epll", \
  "./extras/epll-release-2015.09-1.1.ll1.noarch.rpm", \
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
  rpm --import /tmp/docker-build/RPM-GPG-KEY-lambda-epll && \
  yum install /tmp/docker-build/epll-release-2015.09-1.1.ll1.noarch.rpm && \
  yum -y --enablerepo=epll install mock mock-scm && \
  rm -f /tmp/docker-build/RPM-GPG-KEY-lambda-epll && \
  rm -f /tmp/docker-build/epll-release-2015.09-1.1.ll1.noarch.rpm && \
  \
  # setup symbolic link
  ln -s /home/ll-user/mock-builder/git-blobs /tmp/git-blobs.lambda-linux.io

COPY [ \
  "./extras/mockconfig", \
  "/etc/mock/default.cfg" \
]

VOLUME ["/home/ll-user/mock-builder"]
