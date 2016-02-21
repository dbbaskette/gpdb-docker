# gpdb-docker
Greenplum Database Docker image

# Building the Image
cd <docker working directory>
docker build -t [tag] .

# Running the Image
docker run -i -p 5432:5432 [tag]
