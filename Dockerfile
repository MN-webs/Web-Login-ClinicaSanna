FROM tomcat:10.1-jdk17-temurin

# 1. Limpiar las aplicaciones por defecto del servidor Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# 2. Copiar el contenido de la carpeta web de tu proyecto a la raíz de Tomcat
COPY web/ /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080
CMD ["catalina.sh", "run"]
