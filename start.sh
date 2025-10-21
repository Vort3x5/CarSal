if docker ps -a | grep -q oracle-bdbt; then
	docker start oracle-bdbt
else
	docker run -d --name oracle-bdbt -p 1521:1521 -p 5500:5500 -e ORACLE_PWD=Pswd container-registry.oracle.com/database/express:latest
fi
