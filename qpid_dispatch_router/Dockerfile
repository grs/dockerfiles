FROM gordons/qpid-proton:0.21.0rc1
RUN dnf -y install gettext hostname iputils libwebsockets-devel

ADD qpid-dispatch-binary.tar.gz /
COPY ./qdrouterd.conf.template /etc/qpid-dispatch/
COPY ./run_qdr.sh /usr/sbin/

EXPOSE 5671 5672 55672
CMD ["/usr/sbin/run_qdr.sh"]
