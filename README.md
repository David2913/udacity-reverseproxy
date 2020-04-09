# Udacity cloud developer course 3 reverse proxy service
This is the reverse proxy service of the Udagram app developed in the third course of the udacity cloud developer nanodegree

## How to run the repo locally using docker
1. Build the : `docker build -t <YOUR DOCKER HUB USER>/udacity-reverseproxy .`
2. Run the docker image: `docker run --rm --publish 8080:8080 --name feed <YOUR DOCKER HUB USER>/udacity-reverseproxy`

### Dependencies
The following services are needed to be able to run the complete app:
- [Frontend](https://github.com/David2913/udacity-c3-frontend)
- [Backend - User](https://github.com/David2913/udacity-c3-restapi-user)
- [Reverse - proxy](https://github.com/David2913/udacity-reverseproxy)

You may want to run everything at once using a docker compose file similar to this one after building your images:
```yaml
version: "3"
services:
  reverseproxy:
      image: <YOUR DOCKER HUB USER>/reverseproxy
      ports:
          - 8080:8080
      restart: always
      depends_on:
        - backend-user
        - backend-feed     
  backend-user:
    image: <YOUR DOCKER HUB USER>/udacity-restapi-user
    environment:
      POSTGRESS_USERNAME: $POSTGRESS_USERNAME
      POSTGRESS_PASSWORD: $POSTGRESS_PASSWORD 
      POSTGRESS_DB: $POSTGRESS_DB 
      POSTGRESS_HOST: $POSTGRESS_HOST 
      AWS_REGION: $AWS_REGION 
      AWS_PROFILE: $AWS_PROFILE 
      AWS_BUCKET: $AWS_BUCKET
      JWT_SECRET: $JWT_SECRET
      URL: "http://localhost:8100"
  backend-feed:
    image: <YOUR DOCKER HUB USER>/udacity-restapi-feed
    volumes:
      - $HOME/.aws:/root/.aws
    environment:
      POSTGRESS_USERNAME: $POSTGRESS_USERNAME
      POSTGRESS_PASSWORD: $POSTGRESS_PASSWORD 
      POSTGRESS_DB: $POSTGRESS_DB 
      POSTGRESS_HOST: $POSTGRESS_HOST 
      AWS_REGION: $AWS_REGION 
      AWS_PROFILE: $AWS_PROFILE 
      AWS_BUCKET: $AWS_BUCKET
      JWT_SECRET: $JWT_SECRET
      URL: "http://localhost:8100"
  frontend:
    image: <YOUR DOCKER HUB USER>/udacity-frontend:local
    ports:
      - "8100:80"

```

## Environment variables
The following environment variables are needed for the complete deployment:
- POSTGRESS_USERNAME
- POSTGRESS_PASSWORD
- POSTGRESS_DB
- POSTGRESS_HOST
- AWS_REGION
- AWS_PROFILE
- AWS_BUCKET
- JWT_SECRET

## Other dependencies
- Make sure you have a running Postrgress db either locally or on the cloud
- Make sure your AWS local user has access to a S3 bucket and the appropiate policies
