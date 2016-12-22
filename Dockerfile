FROM jenkinsci/slave
LABEL version="2.0"

############################################
# Configure Jenkins Slave
############################################
# Jenkins Slave settings
# COPY config/*.xml ${JENREF}/

COPY jenkins-slave /usr/local/bin/jenkins-slave

ENTRYPOINT ["jenkins-slave"]
