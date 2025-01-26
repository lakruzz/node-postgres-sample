# node-postgres-sample

This is repo that serves the purpose of showing a really simple companionsip bte node and postgress

It contains a devcontiner, with two images started up by a `docker-compose.yml`.

It mounts two volumes into the db container:

```yaml
    volumes:
      - ../postgres/init:/docker-entrypoint-initdb.d:ro 
      - ../postgres-data:/var/lib/postgresql/data
```
The first contains three sql files; a schema file, a data file and a smoke test. they are automatically run when the images is created and run for the first time.

The second is the database storage itself, having acces to this in your workspace means that if you stop you container, delete the storage and restart the container, then it will recreate your database - very convenient.

The data base is a superhere directory. and tere is build a small simple GrapQL interface around it utilizing Apollo server.

as soon as the environment is up and running you can try to run the following from the terminal

```shell
curl --request POST \
    --header 'content-type: application/json' \
    --url http://localhost:4000/ \
    --data '{"query":"{\n     superhero(id: 1) {\n       heroId\n       heroName\n       realName\n        creationYear\n }\n   }","variables":{}}' 
```

The purpose is mostly to demonstrate the devcontiner and the postgress features, so security was never an issue here 🤷‍♀️

Oh - nad by the way, debugging is set-up to work out-of-the-box.

Make breakpoint in the `server.js`. Start the server from the debugger and execute the `curl` statement above.
