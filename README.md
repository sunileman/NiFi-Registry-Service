## Docker Instance for NiFi Registry Service

This docker instance will launch a NiFi Registry

1.  Git Clone
2.  Build a docker image
  * `docker build --no-cache -t nifiregistry .`
3.  Run the image
  * `docker run --name nifiregistry -p 10080:10080 -d nifiregistry:latest`