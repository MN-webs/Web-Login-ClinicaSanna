FROM tomcat:10.1-jdk17-temurin

# 1. Limpiamos las aplicaciones por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# 2. Copiamos los archivos directamente desde la ruta real de tu proyecto
COPY WebLogin/build/web/ /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080
CMD ["catalina.sh", "run"]
