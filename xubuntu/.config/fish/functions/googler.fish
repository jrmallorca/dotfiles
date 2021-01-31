function __fish_googler_non_option_argument
    not string match -- "-*" (commandline -ct)
end

function __fish_googler_complete_query
    googler --complete (commandline -ct) ^/dev/null
end
