export getchar, set_homedir, get_homedir

charset = 'a':'z'

getchar(idx) = charset[idx]

homedir = "/home/tim"

function set_homedir(path)
    homedir = path
end
get_homedir() = homedir

