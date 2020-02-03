FROM centos

COPY epel.repo /etc/yum.repos.d/epel.repo
COPY haproxy-wi.conf /etc/httpd/conf.d/haproxy-wi.conf
COPY wrapper.sh /wrapper.sh

RUN dnf -y install git nmap-ncat net-tools dos2unix httpd \
        gcc-c++ gcc gcc-gfortran openldap-devel
RUN dnf -y install platform-python platform-python-pip python3-pip
RUN git clone https://github.com/Aidaho12/haproxy-wi.git /var/www/haproxy-wi && \
        mkdir /var/www/haproxy-wi/keys/ && \
        mkdir -p /var/www/haproxy-wi/configs/hap_config/ && \
        mkdir -p /var/www/haproxy-wi/configs/kp_config/ && \
        chown -R apache:apache /var/www/haproxy-wi/
RUN dnf -y install platform-python-devel redhat-rpm-config
RUN pip3 install -r /var/www/haproxy-wi/requirements.txt --no-cache-dir && \
        chmod +x /var/www/haproxy-wi/app/*.py && \
        chmod +x /var/www/haproxy-wi/app/tools/*.py && \
        chmod +x /wrapper.sh && \
        chown -R apache:apache /var/log/httpd/
# RUN dnf -y remove --skip-broken git python3-pip platform-python-devel \
#        redhat-rpm-config gcc-c++ gcc-gfortran gcc && \
#        dnf clean all
RUN rm -rf /var/cache/dnf && \
        rm -f /etc/yum.repos.d/*
RUN cd /var/www/haproxy-wi/app && \
        ./create_db.py && \
        chown -R apache:apache /var/www/haproxy-wi/

EXPOSE 80
VOLUME /var/www/haproxy-wi/

CMD /wrapper.sh
