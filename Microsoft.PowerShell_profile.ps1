# Use this as:
# $repoProfile = 'C:\repositories\GitHub\RichardBenes\rb-ps-profile\Microsoft.PowerShell_profile.ps1'
#
# if (Test-Path $repoProfile) {
#     . $repoProfile
# }
# in the $PROFILE file.

function Prompt {
    "PS $($executionContext.SessionState.Path.CurrentLocation)$("`n>" * ($nestedPromptLevel + 1)) ";
}

function gitl {
	param(
		[int] $n = 10
	)
	
	if ($n -le 0) {
		$n = 10
	} elseif ($n -lt 10) {
		$n *= 10	
	}
	
	git log --oneline --all --graph -n $n
}

function gits {
	git status
}

function gitb {
	param (
		[int]$n
	)
	
	if ($PSBoundParameters.ContainsKey('n')) {
		
		git checkout $branches[$n]
	} else {
		
		$branches = (git branch --quiet --no-color --format '%(refname:short)')
		Set-Variable -Name branches -Value $branches -Scope Global
		
		$i = 0
		foreach ($branch in $branches) {
			Write-Host "$i $branch"
			$i += 1
		}
	}
}

function gitbl {
	param (
		[int]$n
	)
	return $branches[$n]
}

function gitm {
	git checkout master
}

# Disable the history-based "intellisense" which PowerShell provides by default
Set-PSReadLineOption -PredictionSource None
