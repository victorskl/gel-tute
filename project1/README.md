# project1

- https://docs.geldata.com/reference/running/local
- https://docs.geldata.com/reference/using/projects

```shell
gel info
gel project --help
```

```shell
gel project init
```

```txt
No `gel.toml` (or `edgedb.toml`) found in `/Users/<abc>/Projects/github/gel-tute/project1` or above
Do you want to initialize a new project? [Y/n]
> Y
Specify the name of the Gel instance to use with this project [default: project1]:
> project1
Checking Gel versions...
Specify the version of the Gel instance to use with this project [default: 6.10]:
> 6.10
Specify branch name: [default: main]:
> main
┌─────────────────────┬─────────────────────────────────────────────────────────┐
│ Project directory   │ /Users/<abc>/Projects/github/gel-tute/project1          │
│ Project config      │ /Users/<abc>/Projects/github/gel-tute/project1/gel.toml │
│ Schema dir (empty)  │ /Users/<abc>/Projects/github/gel-tute/project1/dbschema │
│ Installation method │ portable package                                        │
│ Version             │ 6.10+b1cf2e4                                            │
│ Instance name       │ project1                                                │
│ Branch              │ main                                                    │
└─────────────────────┴─────────────────────────────────────────────────────────┘
Downloading package...
00:00:15 [====================] 52.43 MiB/52.43 MiB 3.49 MiB/s | ETA: 0s
Successfully installed 6.10+b1cf2e4
Initializing Gel instance 'project1'...
Applying migrations...
Everything is up to date. Revision initial
Project initialized.
To connect to project1, run `gel`
```

```shell
gel
```

```txt

                     ▄██▄
   ▄▄▄▄▄      ▄▄▄    ████
 ▄███████▄ ▄███████▄ ████
 ▀███████▀ ▀███▀▀▀▀▀ ████
   ▀▀▀▀▀      ▀▀▀     ▀▀
  ▀▄▄▄▄▄▀
    ▀▀▀

Gel 6.10+b1cf2e4 (repl 7.4.0+bb0c441)
Type \help for help, \quit to quit.
project1:main>
project1:main> \h
project1:main> \q
```

```shell
gel project help
gel project info
```

```shell
gel instance help
gel instance list
gel instance status
gel instance status --service
gel instance stop
gel instance start
```

```shell
gel server --help
gel server list-versions
gel server info --latest
```

```shell
gel ui
```

```shell
gel list branches
gel describe schema
```

```shell
gel instance destroy -I project1 --force
```
