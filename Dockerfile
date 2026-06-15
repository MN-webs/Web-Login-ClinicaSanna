FROM tomcat:10.1-jdk21-temurin

# 1. Limpiamos las aplicaciones por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# 2. Copiamos los archivos usando tu ruta real descubierta
COPY WebLogin/build/web/ /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080
CMD ["catalina.sh", "run"]
