IDS=$(docker ps -a -q --filter ancestor=vovacher/seq2seq --format="{{.ID}}")
if [ -z "$IDS" ]; then
	echo "No instance is running"
else
	docker rm $(docker stop $IDS)
fi
