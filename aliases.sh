#!/bin/bash

alias tree="tree -a -I '.git'"

container() {
	# Turn the arguments into a path relative to `.docker`
	local IFS="/"
	local PROJECT_DIR=$(realpath "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")")
	local TARGET="${PROJECT_DIR}/.docker/$*.sh"
	
	# Good old help message
	if [ "$1" == "help" -o "$1" == "--help" -o "$1" == "-h" ]; then
		echo -e "usage: container <command>"
		echo -e ""
		echo -e "\tlist | ls | tree : Show available container scripts"
		echo -e "\thelp   : Show this help message"
		echo -e "\t<name> : Execute the named container script. For example, 'container dev build'"
		echo -e "\t\t will execute the script at '.docker/dev/build.sh'. If no such script"
		echo -e "\t\t exists,an error will be returned."
		echo -e "\n"

		return
	fi
	
	# If the first argument is `list` then tree the directory
	if [ "$1" == "list" -o "$1" == "ls" -o "$1" == "tree" ]; then
		tree -a "${PROJECT_DIR}/.docker"
		return
	fi
	
	# If the built path is an executable file, execute it!
	if [ -f "${TARGET}" -a -x "${TARGET}" ]; then
		eval "${TARGET}"
		return
	else
		echo "${TARGET#${PROJECT_DIR}/} is not an executable file"
		echo
		container help
		return
	fi

	# Default: show usage
	container help
}
