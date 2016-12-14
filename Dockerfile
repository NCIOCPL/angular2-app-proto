FROM microsoft/dotnet:1.0-sdk-projectjson

RUN apt-get update
RUN wget -qO- https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y build-essential nodejs

WORKDIR /app

COPY project.json .
RUN ["dotnet", "restore"]
RUN ["npm", "install"]

COPY . /app
RUN ["dotnet", "build"]

EXPOSE 8080/tcp

ENTRYPOINT ["dotnet", "run", "--server.urls", "http://0.0.0.0:8080"]
