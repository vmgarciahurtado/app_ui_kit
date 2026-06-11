# Etapa 1: compilar el showcase (example/) con el SDK de Flutter.
# El contexto debe ser la raíz del repo porque example/ depende del
# paquete por path (../).
FROM ghcr.io/cirruslabs/flutter:3.44.0 AS build

WORKDIR /app
COPY . .

WORKDIR /app/example
RUN flutter pub get && flutter build web --release

# Etapa 2: servir los estáticos con nginx.
FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/example/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
