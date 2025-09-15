# project7

Linking Remote Instance

Consider Gel (EdgeDB) is running in remote. 

We shall [docker-gel](../docker-gel) compose stack to simulate this scenario.

See https://docs.geldata.com/reference/using/projects#using-projects-with-remote-instances

```shell
gel project init
gel project info
```

```shell
gel instance list
┌───────┬──────────┬─────────────────┬──────────────┬─────────┐
│ Kind  │ Name     │ Location        │ Version      │ Status  │
├───────┼──────────┼─────────────────┼──────────────┼─────────┤
│ local │ project7 │ localhost:10706 │ 6.10+b1cf2e4 │ running │
└───────┴──────────┴─────────────────┴──────────────┴─────────┘
```

```shell
(cd ../docker-gel && docker compose up -d)
(cd ../docker-gel && docker compose ps)
```

```shell
gel instance link --help
```

```shell
gel instance link --trust-tls-cert
```

```txt
Specify server host [default: localhost]:
> localhost
Specify server port [default: 10706]:
> 5656
Specify database user [default: admin]:
> gel
Specify database/branch (CTRL + D for default):
> main
Password for 'gel':
┌──────────────┬────────────────────┐
│ Host         │ localhost          │
│ Port         │ 5656               │
│ User         │ gel                │
│ Database     │ main               │
│ Password     │ <hidden>           │
│ TLS Security │ NoHostVerification │
│ TLS CA       │ <specified>        │
└──────────────┴────────────────────┘
Specify a new instance name for the remote server [default: localhost]:
> localhost
Successfully linked to remote instance. To connect run:
  gel -I localhost
```

```shell
gel instance status -I localhost
up
```

```shell
gel instance list
┌────────┬───────────┬─────────────────┬──────────────┬──────────┐
│ Kind   │ Name      │ Location        │ Version      │ Status   │
├────────┼───────────┼─────────────────┼──────────────┼──────────┤
│ local  │ project7  │ localhost:10706 │ 6.10+b1cf2e4 │ inactive │
│ remote │ localhost │ localhost:5656  │ 6.10+615f353 │ up       │
└────────┴───────────┴─────────────────┴──────────────┴──────────┘
```

```shell
gel -I localhost --password
localhost:main> \h
localhost:main> \q
```

```shell
gel instance unlink --help
```

```shell
gel instance unlink -I localhost
```

```shell
gel instance list
┌───────┬──────────┬─────────────────┬──────────────┬──────────┐
│ Kind  │ Name     │ Location        │ Version      │ Status   │
├───────┼──────────┼─────────────────┼──────────────┼──────────┤
│ local │ project7 │ localhost:10706 │ 6.10+b1cf2e4 │ inactive │
└───────┴──────────┴─────────────────┴──────────────┴──────────┘
```

```shell
gel instance destroy -I project7 --force
```

```shell
(cd ../docker-gel && docker compose down)
```
