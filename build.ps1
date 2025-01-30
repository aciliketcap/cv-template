param($Tags)

# no error checking for jq commands but I don't care, they'll be replaced eventually
if ($PSBoundParameters.ContainsKey('Tags')) {
    $TagsList = '[' + ($Tags.Split(",") | Join-String -DoubleQuote -Separator ',') + ']'
    Write-Host $TagsList
    (jq -r --argjson TagsList "${TagsList}" '.skills[] | select( any(.tags[]; IN($TagsList[]))) | if ((.subskills != null) and (.subskills | length) > 0) then (([.subskills[] | "\\item \(.)"] | join("\n")) as $subs_listed | "\\item \\begin{skill}{\(.name)}\n\($subs_listed)\n\\end{skill}") else ("\\item \\singleskill{\(.name)}") end' skills.json).Replace('#','\#').Replace('&','\&') > skills.tex
}
else
{
    (jq -r '.skills[] | if ((.subskills != null) and (.subskills | length) > 0) then (([.subskills[] | "\\item \(.)"] | join("\n")) as $subs_listed | "\\item \\begin{skill}{\(.name)}\n\($subs_listed)\n\\end{skill}") else ("\\item \\singleskill{\(.name)}") end' skills.json).Replace('#','\#').Replace('&','\&') > skills.tex
}

$CommitHash = (git rev-parse HEAD)
if (-Not $?) { $CommitHash = "0" }

$OverleafProjectName = (git rev-parse --abbrev-ref HEAD)
if (-Not $? -or $Branch -eq 'HEAD') { $OverleafProjectName = (Split-Path $PSScriptRoot -Leaf) }

(Get-Content main.tex) -replace 'CV version:.*}', "CV version: $CommitHash }" | Out-File main.tex

Write-Host $Branch
Compress-Archive -Path "main.tex", "params.tex", "personal-statement.tex", "experience.tex", "skills.tex" -DestinationPath "${OverleafProjectName}.zip" -Force

