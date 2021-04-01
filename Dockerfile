#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
WORKDIR /src
COPY ["CustomerManagementProject1.csproj", ""]
RUN dotnet restore "./CustomerManagementProject1.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "CustomerManagementProject1.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "CustomerManagementProject1.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "CustomerManagementProject1.dll"]