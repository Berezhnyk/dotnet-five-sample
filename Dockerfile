FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ./dotnet-five-sample.csproj ./dotnet-five-sample.csproj
COPY ./src ./
RUN dotnet build "dotnet-five-sample.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "dotnet-five-sample.csproj" -c Release -o /app/publish --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:5.0 as base
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "dotnet-five-sample.dll"]