#!/bin/bash
# An improved version of getFNA from Caleb Cornett.

# Checks if dotnet is installed
function checkDotnet()
{
	# || { echo >&2 "ERROR: dotnet is not installed. Please install dotnet to download the t4 tool."; exit 1; }
	command -v dotnet > /dev/null 2>&1
    if [ ! $? -eq 0 ]; then
        echo >&2 "ERROR: dotnet is not installed. Please install dotnet to download the t4 tool."
        exit 1
    fi
}

# Checks if t4 is installed and installs it if it isnt
function installT4()
{
	checkDotnet
	command -v t4 > /dev/null 2>&1
    if [ ! $? -eq 0 ]; then
		dotnet tool install -g dotnet-t4
    fi
}

# Checks if git is installed
function checkGit()
{
    git --version > /dev/null 2>&1
    if [ ! $? -eq 0 ]; then
        echo -e >&2 "\033[1;31mERROR:\033[0;31m Git is not installed. Please install git to download FNA.\033[0m"
        exit 1
    fi
}

# Clones FNA from the git master branch
function downloadFNA()
{
    checkGit
	echo "Downloading FNA..."
	git -C $MY_DIR clone https://github.com/FNA-XNA/FNA.git --depth 1 --recursive
	if [ $? -eq 0 ]; then
		echo -e "\033[32mFinished downloading! \033[0m"
	else
        echo -e >&2 "\033[1;31mERROR:\033[0;31m Unable to download successfully. Maybe try again later?\033[0m"
	fi
}

# Pulls FNA from the git master branch
function updateFNA()
{
    checkGit
    echo "Updating to the latest git version of FNA..."
	git -C "$MY_DIR/FNA" pull --recurse-submodules
	if [ $? -eq 0 ]; then
		echo "Finished updating!"
	else
		echo >&2 "ERROR: Unable to update."
		exit 1
	fi
}


# Downloads and extracts prepackaged archive of native libraries ("fnalibs")
function getLibs()
{
    # Downloading
    echo "Downloading latest fnalibs..."
    curl https://fna.flibitijibibo.com/archive/fnalibs.tar.bz2 > "$MY_DIR/fnalibs.tar.bz2" # http doesnt work anymore in flibitijibibo.com. So use https instead
    if [ $? -eq 0 ]; then
        echo "Finished downloading!"
    else
        >&2 echo "ERROR: Unable to download successfully."
        exit 1
    fi

    # Decompressing
    echo "Decompressing fnalibs..."
    mkdir -p $MY_DIR/fnalibs
    tar xjC $MY_DIR/fnalibs -f $MY_DIR/fnalibs.tar.bz2
    if [ $? -eq 0 ]; then
        echo "Finished decompressing!"
        echo ""
        rm $MY_DIR/fnalibs.tar.bz2
    else
        >&2 echo "ERROR: Unable to decompress successfully."
        exit 1
    fi
}

# Get the directory of this script
MY_DIR=$(dirname "$BASH_SOURCE")


# gather input

# FNA
if [ ! -d "$MY_DIR/FNA" ]; then
    echo -e "\033[36mDownload FNA \033[36;1m(y/n)\033[0;36m? \033[0m"
    read shouldDownload
else
    echo -e "\033[36mUpdate FNA \033[36;1m(y/n)\033[0;36m? \033[0m"
    read shouldUpdate
fi

if [ ! -d "$MY_DIR/fnalibs" ]; then
    echo -e "\033[36mDownload fnalibs \033[36;1m(y/n)\033[0;36m? \033[0m"
    read shouldDownloadLibs
else 
    echo -e "\033[36mRedownload fnalibs \033[36;1m(y/n)\033[0;36m? \033[0m"
    read shouldDownloadLibs
fi


# act on the input#!/bin/bash
# An improved version of getFNA from Caleb Cornett.

# Checks if dotnet is installed
function checkDotnet()
{
	# || { echo >&2 "ERROR: dotnet is not installed. Please install dotnet to download the t4 tool."; exit 1; }
	command -v dotnet > /dev/null 2>&1
    if [ ! $? -eq 0 ]; then
        echo >&2 "ERROR: dotnet is not installed. Please install dotnet to download the t4 tool."
        exit 1
    fi
}

# Checks if t4 is installed and installs it if it isnt
function installT4()
{
	checkDotnet
	command -v t4 > /dev/null 2>&1
    if [ ! $? -eq 0 ]; then
		dotnet tool install -g dotnet-t4
    fi
}

# Checks if git is installed
function checkGit()
{
    git --version > /dev/null 2>&1
    if [ ! $? -eq 0 ]; then
        echo -e >&2 "\033[1;31mERROR:\033[0;31m Git is not installed. Please install git to download FNA.\033[0m"
        exit 1
    fi
}

# Clones FNA from the git master branch
function downloadFNA()
{
    checkGit
	echo "Downloading FNA..."
	git -C $MY_DIR clone https://github.com/FNA-XNA/FNA.git --depth 1 --recursive
	if [ $? -eq 0 ]; then
		echo -e "\033[32mFinished downloading! \033[0m"
	else
        echo -e >&2 "\033[1;31mERROR:\033[0;31m Unable to download successfully. Maybe try again later?\033[0m"
	fi
}

# Pulls FNA from the git master branch
function updateFNA()
{
    checkGit
    echo "Updating to the latest git version of FNA..."
	git -C "$MY_DIR/FNA" pull --recurse-submodules
	if [ $? -eq 0 ]; then
		echo "Finished updating!"
	else
		echo >&2 "ERROR: Unable to update."
		exit 1
	fi
}


# Downloads and extracts prepackaged archive of native libraries ("fnalibs")
function getLibs()
{
    # Downloading
    echo "Downloading latest fnalibs..."
    curl https://fna.flibitijibibo.com/archive/fnalibs.tar.bz2 > "$MY_DIR/fnalibs.tar.bz2" # http doesnt work anymore in flibitijibibo.com. So use https instead
    if [ $? -eq 0 ]; then
        echo "Finished downloading!"
    else
        >&2 echo "ERROR: Unable to download successfully."
        exit 1
    fi

    # Decompressing
    echo "Decompressing fnalibs..."
    mkdir -p $MY_DIR/fnalibs
    tar xjC $MY_DIR/fnalibs -f $MY_DIR/fnalibs.tar.bz2
    if [ $? -eq 0 ]; then
        echo "Finished decompressing!"
        echo ""
        rm $MY_DIR/fnalibs.tar.bz2
    else
        >&2 echo "ERROR: Unable to decompress successfully."
        exit 1
    fi
}

# Get the directory of this script
MY_DIR=$(dirname "$BASH_SOURCE")


# gather input

# FNA
if [ ! -d "$MY_DIR/FNA" ]; then
    echo -e "\033[36mDownload FNA \033[36;1m(y/n)\033[0;36m? \033[0m"
    read shouldDownload
else
    echo -e "\033[36mUpdate FNA \033[36;1m(y/n)\033[0;36m? \033[0m"
    read shouldUpdate
fi

if [ ! -d "$MY_DIR/fnalibs" ]; then
    echo -e "\033[36mDownload fnalibs \033[36;1m(y/n)\033[0;36m? \033[0m"
    read shouldDownloadLibs
else 
    echo -e "\033[36mRedownload fnalibs \033[36;1m(y/n)\033[0;36m? \033[0m"
    read shouldDownloadLibs
fi


# act on the input

# FNA
if [[ $shouldDownload =~ ^[Yy]$ ]]; then
    downloadFNA
elif [[ $shouldUpdate =~ ^[Yy]$ ]]; then
    updateFNA
fi

# FNALIBS
if [[ $shouldDownloadLibs =~ ^[Yy]$ ]]; then
    getLibs
fi


# install t4 engine
installT4

# Only proceed from here if we have not yet renamed the project
if [ ! -d "$MY_DIR/#project#" ]; then
	# old project_name folder already renamed so we are all done here
	exit 1
fi

echo -e "\033[32mEnter the project name to use for your folder and csproj file or 'exit' to quit:\033[0m "
read newProjectName
if [[ $newProjectName = 'exit' || -z "$newProjectName" ]]; then
    exit 1
fi

files=$(grep -rl "#project#" $MY_DIR)
for file in "${files[@]}"; do
    sed -i "s/#project#/$newProjectName/g" $file
done

mv "#project#.sln" "$newProjectName.sln"
mv "#project#/#project#.sln" "#project#/$newProjectName.sln"
mv "#project#/#project#.csproj" "#project#/$newProjectName.csproj"
mv "#project#/#project#.csproj.user" "#project#/$newProjectName.csproj.user"
mv "#project#" "$newProjectName"

git init
git submodule add --depth 1 https://github.com/prime31/Nez.git
cd Nez
git submodule init
git submodule update --depth 1

command -v pbcopy > /dev/null 2>&1
if [ ! $? -eq 0 ]; then
	echo -e "\n\n\033[35;1mManually run the following command:\033[0m\n\n\033[1m\tnuget restore Nez/Nez.sln && msbuild Nez/Nez.sln && msbuild /t:restore $newProjectName && msbuild $newProjectName.sln\033[0m\n\n"
else
	echo -e "\033[1mnuget restore Nez/Nez.sln && msbuild Nez/Nez.sln && msbuild /t:restore $newProjectName && msbuild $newProjectName.sln\033[0m" | pbcopy
	echo ""
	echo -e "\033[1mA build command was copied to your clipboard. Paste and run it now.\033[0m\n\n"
fi


# FNA
if [[ $shouldDownload =~ ^[Yy]$ ]]; then
    downloadFNA
elif [[ $shouldUpdate =~ ^[Yy]$ ]]; then
    updateFNA
fi

# FNALIBS
if [[ $shouldDownloadLibs =~ ^[Yy]$ ]]; then
    getLibs
fi


# install t4 engine
installT4

# Only proceed from here if we have not yet renamed the project
if [ ! -d "$MY_DIR/#project#" ]; then
	# old project_name folder already renamed so we are all done here
	exit 1
fi

echo -e "\033[32mEnter the project name to use for your folder and csproj file or 'exit' to quit:\033[0m "
read newProjectName
if [[ $newProjectName = 'exit' || -z "$newProjectName" ]]; then
    exit 1
fi

files=$(grep -rl "#project#" $MY_DIR)
for file in "${files[@]}"; do
    sed -i "s/#project#/$newProjectName/g" $file
done

mv "#project#.sln" "$newProjectName.sln"
mv "#project#/#project#.sln" "#project#/$newProjectName.sln"
mv "#project#/#project#.csproj" "#project#/$newProjectName.csproj"
mv "#project#/#project#.csproj.user" "#project#/$newProjectName.csproj.user"
mv "#project#" "$newProjectName"

git init
git submodule add --depth 1 https://github.com/prime31/Nez.git
cd Nez
git submodule init
git submodule update --depth 1

command -v pbcopy > /dev/null 2>&1
if [ ! $? -eq 0 ]; then
	echo -e "\n\n\033[35;1mManually run the following command:\033[0m\n\n\033[1m\tnuget restore Nez/Nez.sln && msbuild Nez/Nez.sln && msbuild /t:restore $newProjectName && msbuild $newProjectName.sln\033[0m\n\n"
else
	echo -e "\033[1mnuget restore Nez/Nez.sln && msbuild Nez/Nez.sln && msbuild /t:restore $newProjectName && msbuild $newProjectName.sln\033[0m" | pbcopy
	echo ""
	echo -e "\033[1mA build command was copied to your clipboard. Paste and run it now.\033[0m\n\n"
fi
