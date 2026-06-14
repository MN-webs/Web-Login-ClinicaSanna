FROM tomcat:10.1-jdk17-temurin

# Limpiamos aplicaciones por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiamos el contenido de tu carpeta web directamente a la raíz de Tomcat
COPY web/ /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080
CMD ["catalina.sh", "run"]
