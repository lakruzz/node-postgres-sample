# node-postgres-sample

This is repo that serves the purpose of showcasing a really simple companionship between **node** and **postgress**

It takses offset in the postgress devcontainer template in [devcontainers/templates](https://github.com/devcontainers/templates/tree/main/src/postgres/.devcontainer)[^devcontainer]. That template is a Postgres+Python example so here it's just **node** (and type scripts) instead.

[^devcontainer]:Official organization for the Development Containers Specification and dev container resources.

It demonstarates theuse of a devcontainer, with two images started up by a `docker-compose.yml`.

There is an `app` and and a `db` container. The `db` container uses the community maintained image. It doesn'te ven make use af a docker file, as this image is really all that's needed. The `app` container does have a Dockerfile, but that too uses a standard community maintianed image. It's located in a seperate Dockerfile to demnostrate the use of bote approaches and to preinstall soem useful tools. In this case the `postresql-client` package that offest the `psql` CLI is installed. so you can do maintanance nad manipulations of the database from the terminal and scrips in the `app`container.

The two containers share the same workspace.

You git repo is mounted into the `app` container. from the parent-folder og your git repo. This was a new experience to me, the template i took offset in was the first time i saw it. Soooo simple and yet so elegant and practical - it means that i have ease access to all my sibling git repos on my host PC from within the container.

The `db` container demonstrates some postgres features that are kind of exclusive to docker containers, that is features that are espetially well suited for runnig a development db in a container. But standard in a way that they are similar to how both `MariaDB` and `MySQL` also operates. and it's smooth:

It mounts two volumes into the db container:

```yaml
    volumes:
      - ../postgres/init:/docker-entrypoint-initdb.d:ro 
      - ../postgres-data:/var/lib/postgresql/data
```
The first is how the Postgres community (similar to `MySQL`and `MariaDB`) tied the standard entry-point `docker-entrypoint.sh` to this particular dedicated folder `/docker-entrypoint-initdb.d` to mean somthing like. 

>_"I there already is a database in the container then we do noting, but if theres isn't any database, then we look for executables (e.g  `.sh` and `.sql` files) in `/docker-entrypoint-initdb.d` and if we find any, we run them in alphaanumeric sortorder.

This is a brilliant way for a team to setup and provide a dev database in the dev environment. In my example here in this repo I added three `.sql` files; a schema file, a data file and a smoke test. they are automatically run when the images is created. 

The second  mount is the database storage itself, so this is in the workspace as a folder, ignored by git so it shouldn't bather you. But having access to this in your workspace means that if you stop you container, delete the storage and restart the container, then it will effectively have reset the database to the state defiend by the `.sql` files - very convenient.

The database in this repo is a superhere directory. and I've added a simple, small (and probably buggy) GrapQL interface around it utilizing Apollo server. I just wanted to demonstrate some good use of node. The  

As soon as the devcontainer is done loading the interface starts up on `localhost.4000` 

You can also try running the following from the terminal

```shell
curl --request POST \
    --header 'content-type: application/json' \
    --url http://localhost:4000/ \
    --data '{"query":"{\n     superhero(id: 1) {\n       heroId\n       heroName\n       realName\n        creationYear\n }\n   }","variables":{}}' 
```

The purpose is mostly to demonstrate the devcontainer and the postgress db features when run in a Docker container, so security was never an issue here 🤷‍♀️

Oh - and by the way, debugging is set-up to work out-of-the-box.

So try the following: Make breakpoint in the resolver function in `server.js` (e.g. [line #42](https://github.com/lakruzz/node-postgres-sample/blob/95e3253217265050ac32b4786c2e6444184a00f2/server.js#L42)). Start the server from the debugger and execute the `curl` statement above. You are not in control 🎆

_Happy DevX and Happy Hacking_
