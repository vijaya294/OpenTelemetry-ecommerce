# syntax=docker/dockerfile:1

# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build

WORKDIR /source

# Copy everything into the container
COPY . .

# Restore and build the project
RUN dotnet restore Accounting.csproj
RUN dotnet build Accounting.csproj -c Release
RUN dotnet publish Accounting.csproj -c Release -o /app

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS final

WORKDIR /app

COPY --from=build /app .

# Optionally use a non-root user
# USER 1000

ENTRYPOINT ["dotnet", "Accounting.dll"]
