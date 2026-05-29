<#
.SYNOPSIS
    AutoReport-CLI Core - High-Performance Local Data Extractor.
.DESCRIPTION
    A zero-dependency, single-threaded pipeline utility designed to parse local text targets 
    and isolate structured data matching specific Regular Expression patterns.
.PARAMETER InputFolder
    The absolute path to the target directory containing document files.
.PARAMETER Pattern
    The Regular Expression pattern used to filter and capture required string groups.
.EXAMPLE
    ./Extract-LocalData.ps1 -InputFolder "C:\Invoices" -Pattern "\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b"
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, HelpMessage = "Path to input directory.")]
    [ValidateScript({ Test-Path $_ -PathType Container })]
    [string]$InputFolder,

    [Parameter(Mandatory = $true, HelpMessage = "Regex pattern for data isolation.")]
    [string]$Pattern
)

Write-Host "--- AUTOREPORT CLI: INITIALIZING PIPELINE ---" -ForegroundColor Cyan

try {
    # Isolate targets with strict pipeline memory consumption O(N)
    $TargetFiles = Get-ChildItem -Path $InputFolder -File -Recurse | Where-Object { $_.Extension -match '\.(txt|log|csv|json)$' }

    if ($null -eq $TargetFiles -or $TargetFiles.Count -eq 0) {
        Write-Host "[WARNING] No compatible text targets detected in the specified folder." -ForegroundColor Yellow
        exit
    }

    Write-Host "[INFO] Ingesting $($TargetFiles.Count) targets. Parsing data layers..." -ForegroundColor Gray

    # Sequential Processing Pipeline: O(N * M) performance matrix
    $TargetFiles | ForEach-Object {
        $CurrentFile = $_
        $LineNumber = 0
        
        Get-Content -Path $CurrentFile.FullName -ErrorAction SilentlyContinue | ForEach-Object {
            $LineNumber++
            if ($_ -match $Pattern) {
                [PSCustomObject]@{
                    Timestamp   = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
                    SourceFile  = $CurrentFile.Name
                    LineSegment = $LineNumber
                    Extracted   = $Matches[0]
                }
            }
        }
    } | Format-Table -AutoSize

} catch {
    Write-Host "[FATAL ERROR] Pipeline disrupted: $_" -ForegroundColor Red
} finally {
    Write-Host "--- PIPELINE EXECUTION COMPLETED ---" -ForegroundColor Cyan
}
