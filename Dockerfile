# Step 1: Use the official .NET SDK image for building the app
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Step 2: Set the working directory inside the container
WORKDIR /src

# Step 3: Copy the .sln (Solution) file
COPY ["dotnet-hello-world.sln", "dotnet-hello-world/"]

# Step 4: Copy all the projects in the solution (project files)
COPY . .

# Step 5: Restore the NuGet packages for the solution
RUN dotnet restore "dotnet-hello-world.sln"

# Step 6: Copy the remaining files (source code) to the container
COPY . .

# Step 7: Build the solution in Release mode
RUN dotnet build "dotnet-hello-world.sln" -c Release -o /app/build

# Step 8: Publish the application to prepare it for deployment
RUN dotnet publish "dotnet-hello-world.sln" -c Release -o /app/publish

# Step 9: Use a smaller runtime image for the final image
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final

# Step 10: Set the working directory for the final image
WORKDIR /app

# Step 11: Copy the published app from the build image
COPY --from=build /app/publish .

# Step 12: Expose the port the app will run on (default is 80)
EXPOSE 80

# Step 13: Set the entry point to run the application
ENTRYPOINT ["dotnet", "dotnet-hello-world.sln.dll"]
