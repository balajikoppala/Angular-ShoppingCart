FROM openjdk:11.0.3-jre-slim-stretch
VOLUME /tmp
ADD target/shopping_cart-*.jar /shopping_cart.jar
EXPOSE 8080
RUN bash -c 'touch /shopping_cart.jar'
ENTRYPOINT ["java","-jar", "/shopping_cart.jar"]
