VAR_SOURCE=""
VAR_DESTINATION=""
VAR_ACCOUNTNAME=""
VAR_USERNAME=""
VAR_PASSWORD=""

for arg in "$@"; do
  case $arg in
    SOURCE=*)
      VAR_SOURCE="${arg#*=}"
      shift
      ;;
    DESTINATION=*)
      VAR_DESTINATION="$(realpath "${arg#*=}")"
      shift
      ;;
    ACCOUNTNAME=*)
      VAR_ACCOUNTNAME="${arg#*=}"
      shift
      ;;
    USERNAME=*)
      VAR_USERNAME="${arg#*=}"
      shift
      ;;
    PASSWORD=*)
      VAR_PASSWORD="${arg#*=}"
      shift
      ;;
  esac
done

echo "MODULE INFO:"
echo
echo "Module:      silverlps.email.sync"
echo "Path:        $(pwd)"
echo "SOURCE:      $VAR_SOURCE"
echo "DESTINATION: $VAR_DESTINATION"
echo "ACCOUNTNAME: $VAR_ACCOUNTNAME"
echo "USERNAME:    $VAR_USERNAME"
if [[ -n "$VAR_PASSWORD" ]]; then
  echo "PASSWORD:    MD5=$(echo -n $VAR_PASSWORD | md5sum | awk '{print $1}')"
else
  echo "PASSWORD: "
fi
echo
OFFIMAP_CONFIGFILE=$(mktemp)
cat > "$OFFIMAP_CONFIGFILE" <<EOF
[general]
accounts = $VAR_ACCOUNTNAME

[Account $VAR_ACCOUNTNAME]
localrepository = $VAR_ACCOUNTNAME-local
remoterepository = $VAR_ACCOUNTNAME-remote

[Repository $VAR_ACCOUNTNAME-local]
type = Maildir
localfolders = $VAR_DESTINATION/$VAR_ACCOUNTNAME

[Repository $VAR_ACCOUNTNAME-remote]
type = IMAP
remotehost = $VAR_SOURCE
remoteuser = $VAR_USERNAME
remotepass = $VAR_PASSWORD
ssl = yes
sslcacertfile = /etc/ssl/certs/ca-certificates.crt
readonly = true
EOF

#cat "$OFFIMAP_CONFIGFILE"
offlineimap -c "$OFFIMAP_CONFIGFILE" -o
rm -f "$OFFIMAP_CONFIGFILE"
