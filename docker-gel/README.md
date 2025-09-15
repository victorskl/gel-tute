# docker-gel

REF:
- https://docs.geldata.com/reference/running/deployment/docker

```
mkdir -p data
docker compose up -d
docker compose logs -f gel
docker compose ps
```

```
docker compose exec gel gel --tls-security=insecure -P 5656 help
docker compose exec gel gel --tls-security=insecure -P 5656 info
docker compose exec gel gel --tls-security=insecure -P 5656 --help-connect
```

```
gel --help-connect
```

```
gel --docker -u gel -b main --password
main> \h
main> \l
main> \list branches
main> \lm
main> \q
```

```
gel --tls-ca-file ./data/edbtlscert.pem -H localhost -u gel --password
main> \h
main> \l
main> \list branches
main> \lm
main> \q
```

```
docker compose down
```
