FROM tomcat:10.1-jdk17-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

# Cambia "TuCarpetaAqui/" por el nombre exacto que ves en GitHub
COPY TuCarpetaAqui/ /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080
CMD ["catalina.sh", "run"]
