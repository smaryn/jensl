FROM java:8-jdk
MAINTAINER Sergii Marynenko <marynenko@gmail.com>
LABEL version="1.1"

# ENV SLVER=2.52
# ENV SLVER=2.57
ENV SLVER=2.57 TERM=xterm HOME=/home/jenkins JENREF=/usr/share/jenkins/ref \
    SLURL=http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${SLVER}/remoting-${SLVER}.jar

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y htop mc net-tools sudo && \
    echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -c "Jenkins user" -d $HOME -m jenkins \
    && curl --create-dirs -sSLo /usr/share/jenkins/slave.jar ${SLURL} \
    && chmod 755 /usr/share/jenkins \
    && chmod 644 /usr/share/jenkins/slave.jar

COPY jenkins-slave /usr/local/bin/jenkins-slave

VOLUME /home/jenkins
WORKDIR /home/jenkins

USER jenkins
ENTRYPOINT ["jenkins-slave"]
# COPY plugins.txt ${JENKINS_HOME}/plugins.txt
# RUN /usr/local/bin/plugins.sh ${JENKINS_HOME}/plugins.txt
############################################
# Configure Jenkins Slave
############################################
# Jenkins settings
# COPY config/*.xml ${JENREF}/
