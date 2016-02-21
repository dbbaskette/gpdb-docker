# gpdb-docker
Pivotal Greenplum Database Base Docker Image (4.3.7.1)

# Building the Docker Image
You will first need to download the Pivotal Greenplum Database 4.3.7.1 installer (.zip) located at https://network.pivotal.io/products/pivotal-gpdb and place it inside the docker working directory.

# Running the Docker Image
docker run -i -p 5432:5432 [tag]

cd [docker working directory]

docker build -t [tag] .

# Container Accounts
root/pivotal

gpadmin/pivotal

gpmon/pivotal

# Using psql in the Container
su - gpadmin

psql

# Using pgadmin outside the Container
Launch pgAdmin3

Create new connection using IP Address and Port # (5432)
