function __fish_brownie_needs_command
    set -l cmd (commandline -opc)
    if test (count $cmd) -eq 1
        return 0
    end
    return 1
end

function __fish_brownie_using_command -a current_command
    set -l cmd (commandline -opc)
    if test (count $cmd) -gt 1
        if test $current_command = $cmd[2]
            return 0
        end
    end
    return 1
end

function __fish_brownie_having_arg -a arg
    set -l cmd (commandline -opc)
    if test (count $cmd) -gt 0
        if test "--$arg" = $cmd[(count $cmd)]
            return 0
        end
    end
    return 1
end

function __fish_brownie_arg_number -a number
    set -l cmd (commandline -opc)
    test (count $cmd) -eq $number
end

function __fish_brownie_arg_at -a number
    set -l cmd (commandline -opc)
    echo $cmd[$number]
end

function __fish_brownie_list_networks
    cat ~/.brownie/network-config.yaml | grep '\sid' | cut -d':' -f2 | sed 's/^ //'
end

complete -f -c brownie -n '__fish_brownie_needs_command' -a init               -d "Initialize a new brownie project"
complete -f -c brownie -n '__fish_brownie_needs_command' -a bake               -d "Initialize from a brownie-mix template"
complete -f -c brownie -n '__fish_brownie_needs_command' -a pm                 -d "Install and manage external packages"
complete -f -c brownie -n '__fish_brownie_needs_command' -a compile            -d "Compile the contract source files"
complete -f -c brownie -n '__fish_brownie_needs_command' -a console            -d "Load the console"
complete -f -c brownie -n '__fish_brownie_needs_command' -a run                -d "Run a script in the scripts/ folder"
complete -f -c brownie -n '__fish_brownie_needs_command' -a accounts           -d "Manage local accounts"
complete -f -c brownie -n '__fish_brownie_needs_command' -a networks           -d "Manage network settings"
complete -f -c brownie -n '__fish_brownie_needs_command' -a gui                -d "Load the GUI to view opcodes and test coverage"
complete -f -c brownie -n '__fish_brownie_needs_command' -a analyze            -d "Find security vulnerabilities using the MythX API"


complete -f -c brownie -l help -d "displays help"

complete -f -c brownie -n '__fish_brownie_having_arg network' -a '(__fish_brownie_list_networks)'

# test
complete -f -c brownie -n '__fish_brownie_needs_command' -a test -d "Run test cases in the tests/ folder"
complete -f -c brownie -n '__fish_brownie_using_command test' -l update -d "Only run tests where changes have occurred"
complete -f -c brownie -n '__fish_brownie_using_command test' -l coverage -d "Evaluate contract test coverage"
complete -f -c brownie -n '__fish_brownie_using_command test' -l interactive -d "Open an interactive console each time a test fails"
complete -f -c brownie -n '__fish_brownie_using_command test' -l stateful -d "Only run stateful tests, or skip them"
complete -f -c brownie -n '__fish_brownie_using_command test' -l failfast -d "Fail hypothesis tests quickly (no shrinking)"
complete -f -c brownie -n '__fish_brownie_using_command test' -l revert-tb -d "Show detailed traceback on unhandled transaction reverts"
complete -f -c brownie -n '__fish_brownie_using_command test' -l gas -d "Display gas profile for function calls"
complete -f -c brownie -n '__fish_brownie_using_command test' -l network -d "Use a specific network (default development)"
complete -f -c brownie -n '__fish_brownie_using_command test' -l showinternal -d "Include Brownie internal frames in tracebacks"
complete -f -c brownie -n '__fish_brownie_using_command test' -l capture -d "Enables or disables capture"
complete -f -c brownie -n '__fish_brownie_using_command test; and __fish_brownie_having_arg capture' -a 'yes no'
