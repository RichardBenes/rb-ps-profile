# Once I hit whole package of files with autoformatter.
# That infested my branch with a huge number of formatting changes.
# So I had to undo that for all the files that weren't subject of the branch topic.
# And this have I written to ease that.
# It is an example of how one can leverage some basic scripting
# when it is necessary to go through a lot of files, quickly inspect each,
# and make a decision of whether its changes should be kept, or whether
# it should be restored to some branch version.

if ($Null -eq $i) {
    $i = 0
}

if ($Null -eq $files) {
    $files = (git diff master --name-only)
}

function stat { Write-Host "Remains $($files.Length - $i) of $($files.Length)" }
function nx {
    $global:i += 1
    df
}
function pr { $global:i -= 1 }
function df { git diff master -- $files[$i] }
function rfs {
    git checkout master -- $files[$i]
    nx
    stat
}
function acp {
    nx
    stat
}