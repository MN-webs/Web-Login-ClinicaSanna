FROM tomcat:10.1-jdk17-temurin

# 1. Limpiamos las aplicaciones por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# 2. Copiamos todo el contenido del repositorio a la raíz pública
COPY . /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080
CMD ["catalina.sh", "run"]
