# Lost and Found Inventory System

- A dockerized system for keeping track of lost items.
- Add an item with a specific category.
- Claim an item once the owner arrives.
- Keep track of the current items in storage and all claimed items.

## Required

- Docker / Docker Desktop
- Docker Compose

## Tech Stack

- Docker and docker-compose
- NestJS with GraphQL implementation
- Flutter Web
- Postgres and PgAdmin

## Setup the application

1. Make sure there is locally installed Docker and docker-compose
2. Open the root folder of the project in a terminal
3. Start and run all the docker services by running: `docker-compose up -d`
4. Wait for all services to start up

## Test the Flutter web application

1. After starting up all the Docker services, access the web admin portal: [http://localhost:8080/](http://localhost:8080/)
2. Register an account to test all the features of the application.

## Test the NestJS server application

1. After starting up all the Docker services, access the GraphQL playground: [http://localhost:3000/graphql](http://localhost:3000/graphql)
2. Refer to the sample GraphQL requests below to test the APIs:

### Sample API requests

#### Login API

```graphql
mutation {
  login(loginUserInput: { username: "user123", password: "password123" }) {
    user_id
    username
    name
    access_token
  }
}
```

#### Register User API

```graphql
mutation {
  registerUser(
    registerUserInput: {
      username: "user123"
      password: "password123"
      name: "Juan dela Cruz"
    }
  ) {
    user_id
    username
    name
    created_at
    updated_at
  }
}
```

#### List All Items

```graphql
query {
  findAll {
    item_id,
    category,
    item_type,
    description,
    brand,
    is_claimed,
    created_at,
    updated_at
  }
}

Headers:
{
   "Authorization": "Bearer <access_token>"
}
```

#### Get an Item

```graphql
query {
  findOne(item_id: 3) {
    item_id,
    category,
    item_id,
    description,
    is_claimed,
    created_at,
    updated_at
  }
}

Headers:
{
   "Authorization": "Bearer <access_token>"
}
```

#### Create an Item

```graphql
mutation {
  registerItem(registerItemInput: {
    category: "cat1",
    item_type: "typ1",
    brand: "br1",
    description: "desc1"
  }) {
    item_id,
    category,
    item_id,
    description,
    is_claimed,
    created_at,
    updated_at
  }
}

Headers:
{
   "Authorization": "Bearer <access_token>"
}
```

#### Update an Item

```graphql
mutation {
  updateItem(updateItemInput: {
    item_id: 2,
    category: "cat2",
    item_type: "typ2",
    brand: "br2",
    description: "desc1",
    is_claimed: true
  }) {
    item_id,
    category,
    item_id,
    description,
    is_claimed,
    created_at,
    updated_at
  }
}

Headers:
{
   "Authorization": "Bearer <access_token>"
}
```

## Access the Database

1. After starting up the Postgres and pgAdmin services, access the PgAdmin portal: [http://localhost:5050/](http://localhost:5050/)
2. Login using the default admin credentials:

```
Email: admin@admin.com
Password: admin
```

3. To view all the databases, create a new server with the following values:

```
Name: nest-postgres
Host Name/Address: localhost
Port: 5432
Maintenance database: laf
Username: admin
Password: postgres
```
