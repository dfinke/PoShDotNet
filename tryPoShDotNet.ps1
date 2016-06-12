# Create Hello World
New-Dotnet

# remove all frameworks
Get-DotnetFx | Remove-DotNetFx

# add .NET 4.0 and .Net Cor 1.0 frameworks
echo net40 netcoreapp1.0 | Add-DotNetFx 

# Nuget Restore
Restore-Dotnet

# Build 
Invoke-DotnetBuild

ls .\bin\debug

.\bin\Debug\net40\HelloWorld.exe