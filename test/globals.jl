using Performance
using Test

@testset "globals" begin
    @test getchar(5) == 'e'                # this should pass from the beginning
    # The next test will fail. Use Cthulhu's `@descend getchar(5)` from the REPL to discover the problem.
    # Tip: you can use `@descend iswarn=true getchar(5)` if you want to turn on the red highlighting
    # in the initial view (otherwise, you can hit 'w' to toggle "warn" mode).
    # In this case, make sure you know the inferred types for `idx` and `charset`.
    # Once diagnosed, fix the code in src/globals.jl. To fix it, read
    # https://docs.julialang.org/en/v1/manual/performance-tips/#Avoid-untyped-global-variables
    # Here you can assume that the value of `charset` never needs to change.
    @test @inferred(getchar(5)) == 'e'   # see `?@inferred`
    # Check `@descend` again at the end to see that you've fixed it!
    # (Chances are you'll have to restart Julia even if you're using Revise; there are some changes
    #  Julia & Revise can't track, and this is one of them.)

    # The next two tests should pass even at the outset
    @test get_homedir() == "wrong"
    set_homedir(ENV["HOME"])
    @test get_homedir() == ENV["HOME"]
    # The next one will fail.
    # Be sure you follow the link on global-value type annotations in
    #   https://docs.julialang.org/en/v1/manual/performance-tips/#Avoid-untyped-global-variables
    @test @inferred(get_homedir()) == ENV["HOME"]   # again, this will likely require restarting Julia to test your fix
end
