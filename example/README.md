# Keycloak example app

This is a Keycloak example application showing a basic setup to start from

## Installation and start up

This example can be either tradtionally on your local machine or by using docker-compose. 

### Before installing

Head to the Keycloak web client you want to use to run the example against. Export the Keycloak 
installation by donwloading it or copying it and move/copy it to a file called keycloak.json in
the root folder of the example (example/keycloak.json). 

Note: If you have get a "Not found error" from the keycloak gem when running the example check the
"auth-server-url" attribute value. The url should not end with a "/"

### Running traditionallly

```
bundle install
rails s
```

### Running with docker-compose

```
docker-compose build
docker-compose run app bundle install
docker-compose up
```

### Open application

Open a browser of your choice and navigate to

htpp://localhost:8080