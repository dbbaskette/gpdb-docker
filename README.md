# gpdb-docker
Greenplum Database Base Docker image

# Building the Docker Image
cd [docker working directory]

docker build -t [tag] .

# Running the Docker Image
docker run -i -p 5432:5432 [tag]
