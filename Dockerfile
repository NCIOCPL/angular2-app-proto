FROM microsoft/dotnet:1.0-sdk-projectjson

RUN apt-get update
RUN wget -qO- https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y build-essential nodejs

COPY . /app
WORKDIR /app

RUN ["dotnet", "restore"]
RUN ["pwd"]

COPY . /app
RUN ["dotnet", "build"]
RUN ["npm", "install"]
RUN ["node", "./node_modules/webpack/bin/webpack.js", "--config", "webpack.config.vendor.js", "--env.prod"]
RUN ["node", "./node_modules/webpack/bin/webpack.js", "--env.prod"]

EXPOSE 8080/tcp

RUN ["pwd"]
ENTRYPOINT ["dotnet", "run", "--server.urls", "http://0.0.0.0:8080"]
