using Performance
using Test

@testset "type abuse" begin
    ##
    ## Sometimes when people start getting excited about multiple dispatch, they start trying to
    ## to solve every problem as a dispatch problem. This works well in some circumstances and badly
    ## in others. This problem will illustrate that dispatch is not "magic": when types can't
    ## be predicted in advance, you're better off doing more at runtime and less via the type system.
    ##

    numbers = [15, 3, 6, 11, 4]
    ops = Operator[Plus(), Divide(), Times(), Minus()]
    opsstr = "+/*-"
    @test calculate_typed(numbers, ops) == 29
    @test calculate_branch(numbers, opsstr) == 29
    btyped = @benchmark(calculate_typed($numbers, $ops), samples=100, evals=10)
    bbranch = @benchmark(calculate_branch($numbers, $opsstr), samples=100, evals=10)
    println("type_abuse.jl: actual performance ratio: ", minimum(btyped).time / minimum(bbranch).time)

    # The other thing about excessive use of the type system is that it can increase compile-time latency,
    # since code has to be compiled for each different type. In some cases, it has been observed that one
    # can go from tens of minutes to a few seconds of compile time:
    # https://discourse.julialang.org/t/understanding-and-optimizing-compiler-time-just-a-bit/51759/13?u=tim.holy
    # Bottom line: types are great when they are predictable, but they can get in your way when not.
    # Ask yourself, "will the compiler be able to predict the next type in this computation?"
    # If the answer is "no," consider using branches or more conventional programming logic.
end
