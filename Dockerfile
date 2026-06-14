FROM tomcat:10.1-jdk17-temurin

# Limpiamos el directorio por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiamos el contenido de la carpeta 'web' de NetBeans directamente a ROOT
COPY web/ /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080
CMD ["catalina.sh", "run"]
