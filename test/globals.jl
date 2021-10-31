using Performance
using Test

@testset "globals" begin
    ##
    ## https://docs.julialang.org/en/v1/manual/performance-tips/#Avoid-global-variables
    ##
    @test getchar(5) == 'e'                # this should pass from the beginning
    # The next test will fail. Use `@code_warntype getchar(5)` from the REPL to see the problem
    # and then fix it.
    # Tip: sometimes you have to determine types via the process of elimination (TODO: fix that in Julia)
    # In this case, make sure you see that:
    # - `idx` has known, concrete type
    # - that Julia knows that `getindex` refers to `Base.getindex`
    # - that Julia knows that `charset` refers to `Performance.charset`
    # but notice it doesn't show you any type info for `charset`. By the process of elimination,
    # that must be the source of the poor type-inference.
    # (If you pass an argument of unknown type to a function, generally you also can't predict the type it
    # will return.)
    @test @inferred(getchar(5)) == 'e'   # see `?@inferred`
    # Check `@code_warntype` again at the end to see that you've fixed it!

    # The next two tests should pass even at the outset
    @test get_homedir() == "/home/tim"
    set_homedir(ENV["HOME"])
    @test get_homedir() == ENV["HOME"]
    # This one will fail. But you can't make the value constant and still update it.
    # Find a way to fix it! Hint: `?Ref` or use an array (Refs are like single-element arrays)
    # Explanation: the *container* is constant, but the *contents* can be modified.
    # (Think of the container like a box, which is distinct from the things inside it.)
    # If the container type specifies the type of the contents, Julia's type-inference will be happy.
    @test @inferred(get_homedir()) == ENV["HOME"]
end
