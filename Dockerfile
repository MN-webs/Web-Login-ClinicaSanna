FROM tomcat:10.1-jdk17-temurin

# Limpiamos las aplicaciones de ejemplo que vienen con Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiamos absolutamente TODO lo que hay en tu repositorio a la raíz de Tomcat
COPY . /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080
CMD ["catalina.sh", "run"]
