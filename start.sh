display_help() {
    echo "Usage: $0 [-i][-s path]" >&2
    echo
    echo "start docker container vovacher/seq2seq with port forwarding 8888:8888 and jupyter launched on it"
    echo
    echo "Options:"
    echo "   -i, --interactive          start container in bash mode (no jupyter launched)"
    echo "   -s, --shared               start container with the shared folder on given path"
    echo
    exit 1
}

filename=
interactive=

while [ "$1" != "" ]; do
	case $1 in
		-s | --shared )           shift
					  filename=$1
					  ;;
		-i | --interactive )	  interactive=1
					  ;;
		-h | --help )		  display_help
					  exit 0
	esac
	shift
done

IDS=$(docker ps -a -q --filter ancestor=vovacher/seq2seq --format="{{.ID}}")
if [ -z "$IDS" ]; then
	if [ "$interactive" = "1" ]; then
		docker run -p 8888:8888 -i -t vovacher/seq2seq bash
	else
		if [ -n "$filename" ]; then
			docker run -d -p 8888:8888 -v $filename:/root/shared vovacher/seq2seq
		else
			docker run -d -p 8888:8888 vovacher/seq2seq
		fi
	fi
else
	echo "Another instance is running."
fi
