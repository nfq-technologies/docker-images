FROM nfqlt/debian-buster

EXPOSE 9000

env SONARQUBE_JDBC_USERNAME=project
env SONARQUBE_JDBC_PASSWORD=project
env SONARQUBE_JDBC_URL='jdbc:postgresql://postgres:5432/project?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance'

CMD exec /entrypoint.sh

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build

