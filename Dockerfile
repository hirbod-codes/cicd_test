FROM mcr.microsoft.com/dotnet/sdk:7.0 AS dev

WORKDIR /app

COPY ./cicd_test.csproj ./
RUN dotnet restore -v d

COPY . .

RUN dotnet dev-certs https --trust

CMD dotnet watch run --no-restore

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS prod

WORKDIR /app

COPY . .

RUN dotnet publish -c Release -o /publish

WORKDIR /publish

CMD dotnet cicd_test.dll 
