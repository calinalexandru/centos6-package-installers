#!/usr/bin/env bash
source "$( cd "${BASH_SOURCE[0]%/*}" && pwd )/lib/oo-bootstrap.sh"

## MAIN ##
import util/log util/exception util/tryCatch util/namedParameters util/class

try {
    # something...
    cp ~/test ~/test2
    # something more...
} catch {
    echo "The hard disk is not connected properly!"
    echo "Caught Exception:$(UI.Color.Red) $__BACKTRACE_COMMAND__ $(UI.Color.Default)"
    echo "File: $__BACKTRACE_SOURCE__, Line: $__BACKTRACE_LINE__"

    ## printing a caught exception couldn't be simpler, as it's stored in "${__EXCEPTION__[@]}"
    Exception::PrintException "${__EXCEPTION__[@]}"
}

# using colors:
echo "$(UI.Color.Blue)I'm blue...$(UI.Color.Default)"

# enable basic logging for this file by declaring a namespace
namespace myApp
# make the Log method direct everything in the namespace 'myApp' to the log handler called DEBUG
Log::AddOutput myApp DEBUG

# now we can write with the DEBUG output set
Log "Play me some Jazz, will ya? $(UI.Powerline.Saxophone)"

# redirect error messages to STDERR
Log::AddOutput error STDERR
subject=error Log "Something bad happened."

# reset outputs
Log::ResetAllOutputsAndFilters

# You may also hardcode the use for the StdErr output directly:
Console::WriteStdErr "This will be printed to STDERR, no matter what."

#
#testPassingParams() {
#
#    [string] hello
#    [string[4]] anArrayWithFourElements
#    l=2 [string[]] anotherArrayWithTwo
#    [string] anotherSingle
#    [reference] table   # references only work in bash >=4.3
#    [...rest] anArrayOfVariedSize
#
#    test "$hello" = "$1" && echo correct
#    #
#    test "${anArrayWithFourElements[0]}" = "$2" && echo correct
#    test "${anArrayWithFourElements[1]}" = "$3" && echo correct
#    test "${anArrayWithFourElements[2]}" = "$4" && echo correct
#    # etc...
#    #
#    test "${anotherArrayWithTwo[0]}" = "$6" && echo correct
#    test "${anotherArrayWithTwo[1]}" = "$7" && echo correct
#    #
#    test "$anotherSingle" = "$8" && echo correct
#    #
#    test "${table[test]}" = "works"
#    table[inside]="adding a new value"
#    #
#    # I'm using * just in this example:
#    test "${anArrayOfVariedSize[*]}" = "${*:10}" && echo correct
#}
#
#fourElements=( a1 a2 "a3 with spaces" a4 )
#twoElements=( b1 b2 )
#
#declare -A assocArray
#assocArray[test]="works"
#
#testPassingParams "first" "${fourElements[@]}" "${twoElements[@]}" "single with spaces" assocArray "and more... " "even more..."
#
#test "${assocArray[inside]}" = "adding a new value"

