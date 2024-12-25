# Use the official .NET SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the csproj file and restore the dependencies (via NuGet)
COPY *.csproj ./
RUN dotnet restore

# Copy the entire source code into the container
COPY . ./

# Publish the application to the /out folder in the container
RUN dotnet publish -c Release -o /out

# Use the official .NET runtime image to run the application
FROM mcr.microsoft.com/dotnet/aspnet:7.0

# Set the working directory for the runtime image
WORKDIR /app

# Copy the published output from the build stage to the runtime container
COPY --from=build /out .

# Expose the port the app will run on (e.g., 80 or 5000)
EXPOSE 80

# Set the entry point for the container
ENTRYPOINT ["dotnet", "hello-world-api"]
