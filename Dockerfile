FROM baseimage-amzn:2016.03-001

CMD ["/sbin/my_init"]

COPY [ \
  "./extras/RPM-GPG-KEY-lambda-epll", \
  "./extras/epll-release-2016.03-1.1.ll1.noarch.rpm", \
  "./extras/etc-mock-default.cfg", \
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
  yum install /tmp/docker-build/epll-release-2016.03-1.1.ll1.noarch.rpm && \
  yum -y --enablerepo=epll install mock mock-scm && \
  \
  # setup symbolic link
  ln -s /home/ll-user/mock-builder/git-blobs /tmp/git-blobs.lambda-linux.io && \
  \
  # copy mock configuration file
  cp /tmp/docker-build/etc-mock-default.cfg /etc/mock/default.cfg && \
  # cleanup
  rm -rf /tmp/docker-build
