property appNames : {"AfterEffects", "Audition", "Prelude", "Premiere", "SpeedGrade", "Story"}

tell application "Finder" to set theSelection to (choose folder with multiple selections allowed) -- fail, so let the user choose the folders

set chosenNames to (choose from list appNames with prompt "Which apps will you be using?" with multiple selections allowed)
if chosenNames is false then error number -128 -- cancel

tell application "Finder" to repeat with anItem in theSelection
	if (class of item anItem is folder) then repeat with aName in chosenNames -- just folders
		try
			make new folder at anItem with properties {name:aName}
		on error number -48
			-- skip error if folder already exists
		end try
	end repeat
end repeat

-- Additional Subfolders
tell application "Finder" to make new folder at folder theSelection with properties {name:"Final"}

tell application "Finder" to make new folder at folder "Premiere" of folder theSelection with properties {name:"Images"}
tell application "Finder" to make new folder at folder "Premiere" of folder theSelection with properties {name:"Project Files"}

-- Video Subfolders
tell application "Finder" to make new folder at folder "Premiere" of folder theSelection with properties {name:"Video"}
tell application "Finder" to make new folder at folder "Video" of folder "Premiere" of folder theSelection with properties {name:"Capture"}
tell application "Finder" to make new folder at folder "Video" of folder "Premiere" of folder theSelection with properties {name:"Additional"}

-- Audio Subfolders
tell application "Finder" to make new folder at folder "Premiere" of folder theSelection with properties {name:"Audio"}
tell application "Finder" to make new folder at folder "Audio" of folder "Premiere" of folder theSelection with properties {name:"Capture"}
tell application "Finder" to make new folder at folder "Audio" of folder "Premiere" of folder theSelection with properties {name:"Additional"}
