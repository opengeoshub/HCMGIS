# Script to remove all __pycache__ directories from the project
# This script will recursively find and remove all Python cache directories

Write-Host "Starting cleanup of __pycache__ directories..." -ForegroundColor Green

# Get all __pycache__ directories
$pycacheDirs = Get-ChildItem -Path . -Recurse -Directory -Name "__pycache__"

if ($pycacheDirs.Count -eq 0) {
    Write-Host "No __pycache__ directories found." -ForegroundColor Yellow
    exit 0
}

Write-Host "Found $($pycacheDirs.Count) __pycache__ directories:" -ForegroundColor Cyan
foreach ($dir in $pycacheDirs) {
    Write-Host "  - $dir" -ForegroundColor Gray
}

Write-Host "`nRemoving __pycache__ directories..." -ForegroundColor Green

$removedCount = 0
foreach ($dir in $pycacheDirs) {
    try {
        Remove-Item -Path $dir -Recurse -Force
        Write-Host "  ✓ Removed: $dir" -ForegroundColor Green
        $removedCount++
    }
    catch {
        Write-Host "  ✗ Failed to remove: $dir - $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nCleanup completed!" -ForegroundColor Green
Write-Host "Successfully removed $removedCount out of $($pycacheDirs.Count) __pycache__ directories." -ForegroundColor Cyan

# Verify cleanup
$remainingDirs = Get-ChildItem -Path . -Recurse -Directory -Name "__pycache__"
if ($remainingDirs.Count -eq 0) {
    Write-Host "✓ All __pycache__ directories have been successfully removed." -ForegroundColor Green
} else {
    Write-Host "⚠ Warning: $($remainingDirs.Count) __pycache__ directories still remain:" -ForegroundColor Yellow
    foreach ($dir in $remainingDirs) {
        Write-Host "  - $dir" -ForegroundColor Gray
    }
}
