using Performance
using BenchmarkTools
using Test

@testset "arrays" begin
    ##
    ## Arrays are good examples of containers for illustrating:
    ## https://docs.julialang.org/en/v1/manual/performance-tips/#man-performance-abstract-container
    ##
    seq3 = sequence_of_three(17)
    @test seq3 == [17, 18, 19]
    @test @inferred(seq3[2]) == 18    # to diagnose this failure, look at the type of `seq3` and then `@descend sequence_of_three(17)` (with Cthulhu)
    seq3 = sequence_of_three(17.5)
    @test seq3 == [17.5, 18.5, 19.5]
    @test @inferred(seq3[2]) == 18.5

    # Here's a "bad" implementation. The starter code in `src/arrays.jl`,
    # `alternate_items`, is the one you should improve (don't fix `alternate_items_bad`,
    # we need it for benchmarking).
    function alternate_items_bad(nrepeats::Integer, item1, item2)
        out = []
        for _ = 1:nrepeats
            push!(out, item1, item2)
        end
        return out
    end
    vbad = alternate_items_bad(10^4, 3, 4)
    bbad = @benchmark(sum($vbad), samples=100, evals=10)
    vgood = alternate_items(10^4, 3, 4)
    @test vbad == vgood
    @test isconcretetype(eltype(vgood))
    bgood = @benchmark(sum($vgood), samples=100, evals=10)
    @test 10*minimum(bgood).time < minimum(bbad).time
    # Let's see what the actual performance ratio is (probably a *lot* better than 10x):
    println("arrays.jl: actual performance ratio: ", minimum(bbad).time / minimum(bgood).time)
    # Now you decide you also want to support `missing` items. Modify your implementation, if necessary,
    # to handle the cases below.
    # If you need a hint, see https://julialang.org/blog/2018/08/union-splitting/
    v = alternate_items(10^4, missing, 4)
    vbadm = alternate_items_bad(10^4, missing, 4)
    @test isequal(v, vbadm)
    @test @inferred(sum(skipmissing(v))) == 4*10^4
    # Note: while this example is artificial, there turn out
    # to be *many* cases where you want to create a struct that can hold
    # one of two types in a given field, or an array that can store
    # `nothing` or `missing` in addition to a concrete type.
    # So while the setup for the problem is entirely artificial,
    # the underlying task is very common.

end
