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
