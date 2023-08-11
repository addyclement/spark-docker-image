FROM bitnami/spark 

LABEL maintainer="addyclement@gmail.com"
# install dependencies

USER root
RUN pip install pandas PyMySQL boto3 requests pymongo
RUN pip install mysql-connector-python
RUN apt-get update && apt-get install -y curl 

RUN curl https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.12.528/aws-java-sdk-1.12.528.jar --output /opt/bitnami/spark/jars/aws-java-sdk-1.12.528.jar
RUN curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.6/hadoop-aws-3.3.6.jar --output /opt/bitnami/spark/jars/hadoop-aws-3.3.6.jar


#make script directory
RUN mkdir -p /opt/bitnami/spark/scripts

# set work directory
WORKDIR /opt/bitnami/spark/scripts

#copy jars mysql, hadoop s3 etc
ADD https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.30/mysql-connector-java-8.0.30.jar  /opt/bitnami/spark/jars/mysql-connector-java-8.0.30.jar
ADD https://s3.amazonaws.com/redshift-downloads/drivers/jdbc/2.1.0.18/redshift-jdbc42-2.1.0.18.jar  /opt/bitnami/spark/jars/redshift-jdbc42-2.1.0.18.jar

# copy local script directory to container script directory
COPY ./docker_python_scripts/ /opt/bitnami/spark/scripts/

