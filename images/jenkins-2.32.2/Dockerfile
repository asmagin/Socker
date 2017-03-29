FROM openjdk:windowsservercore

# $ProgressPreference will disable download progress info and speed-up download
SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; "]

ENV JENKINS_HOME c:/jenkins
ENV JENKINS_SLAVE_AGENT_PORT 50000

# Jenkins home directory is a volume, so configuration and build history
# can be persisted and survive image upgrades
VOLUME c:/jenkins

ENV JAVA_OPTS -Dhudson.footerURL=https://www.epam.com

# jenkins version being bundled in this docker image
ENV JENKINS_VERSION 2.32.3

# jenkins.war checksum, download will be validated using it
ENV JENKINS_SHA 3eb599dd78ecf00e5f177ec5c4b1ba4274be4e5f63236da6ac92401a66fa91e8
# Can be used to customize where jenkins.war get downloaded from
ENV JENKINS_URL https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war

ADD ${JENKINS_URL} /jenkins.war

ENV JENKINS_UC https://updates.jenkins.io

# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 50000

CMD [ "java", "-jar", "c:/jenkins.war" ]