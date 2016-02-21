# gpdb-docker
Greenplum Database Docker image

# Building the Image
cd <docker working directory>
docker build -t [image_tag] .

# Running the Image
docker run -i -p 5432:5432 [image_tag]
