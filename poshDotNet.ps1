
function New-Dotnet         { dotnet new       }
function Restore-Dotnet     { dotnet restore   }
function Get-DotnetVersion  { dotnet --version }
function Get-DotnetInfo     { dotnet --info    }
function Invoke-DotnetBuild { dotnet build     }
function Invoke-DotnetRun   { dotnet run       }

function Get-DotnetFx { 
    gc .\project.json | ConvertFrom-Json | % frameworks
}


function Add-DotNetFx {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [ValidateSet("netcoreapp1.0","net20","net30","net35","net40","net45","net451","net452","net46","net461","net462")]
        $fx
    )

    Process {
        $projectJson = "$pwd\project.json"
        $prj=(gc $projectJson | ConvertFrom-Json)
    
        $value = (new-object pscustomobject)

        if($fx -eq 'netcoreapp1.0') {
            $value = [pscustomobject]@{imports='dnxcore50'}
        }
         
        $prj.frameworks |
            Add-Member -MemberType NoteProperty -Name $fx -Value $value
    
        $prj | ConvertTo-Json -Depth 5 | Set-Content $projectJson -Encoding UTF8
    }
}

function Remove-DotNetFx {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [ValidateSet("netcoreapp1.0","net20","net30","net35","net40","net45","net451","net452","net46","net461","net462")]
        $fx
    )

    Process {
        $projectJson = "$pwd\project.json"
        $prj=(gc $projectJson | ConvertFrom-Json)
    
        $prj.frameworks.psobject.properties.remove($fx)

        $prj | ConvertTo-Json -Depth 5 | Set-Content $projectJson -Encoding UTF8
    }
}

function Get-DotNetFx {
    $projectJson = "$pwd\project.json"
    gc $projectJson | ConvertFrom-Json | % frameworks | gm -MemberType NoteProperty | % Name
}
