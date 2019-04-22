#ensure there is a blank index.txt file
#echo '01' > rootCA.srl


# CA
openssl genrsa -des3 -out rootCA.key
openssl req -x509 -new -days 750 -key rootCA.key -sha256 -out rootCA.crt

openssl genrsa -out api.fazio.com.key 2048
openssl req -new -key api.fazio.com.key -out api.fazio.com.csr -config openssl_cert.cnf -extensions v3_req

#sign the cert
openssl ca -config ca.cnf -cert rootCA.crt -out api.fazio.com.crt -extfile v3.ext -in api.fazio.com.csr

# print cert
openssl x509 -in api.fazio.com.crt -text -noout

#verify cert
openssl verify -CAfile rootCA.crt -CApath /home/srinandans/workspace/tls -no-CAfile -no-CApath api.fazio.com.crt  
