using Performance
using BenchmarkTools
using Test

@testset "structs" begin
    ##
    ## https://docs.julialang.org/en/v1/manual/performance-tips/#Type-declarations
    ##
    # This problem uses an AbstractArray type as an example, but the lessons
    # apply to almost any `struct`. One specific feature, though, is that
    # `AbstractArray` has a standard
    # [interface](https://docs.julialang.org/en/v1/manual/interfaces/#man-interface-array)
    # that you may need to learn for this problem. Not very many types in Julia are this well
    # standardized, but it's a good model for how to think about composability
    # and extensability more generally, two key goals for "good" code.
    #
    # This example may be challenging. There are quite a few details to get right,
    # although it remains true that creating new array types in Julia is still quite a lot
    # simpler than many other languages.
    # Unfortunately, this problem is also not Revise-friendly. You'll have to restart your
    # Julia session when you make substantive changes to the source code.

    a = DefaultArray([10, 20, 30], 0)
    @test @inferred(a[2]) === 20
    @test @inferred(a[4]) === 0
    # Depending on how you implemented the above, you may find yourself changing your implementation
    # to make the tests below pass (simultaneously with passing the tests above).
    # See https://docs.julialang.org/en/v1/manual/constructors/#Parametric-Constructors
    # for help. See `?promote_type` as a hint for crafting your solution.
    a = DefaultArray(Float32[10, 20, 30], 0)
    @test @inferred(a[2]) === 20.0f0
    @test @inferred(a[4]) === 0.0f0
    # And here it gets even trickier! If you're taking the class at WashU, feel free to reach
    # out to the instructor for help. If this one is too hard, you can also skip it and go on to the next.
    a = DefaultArray(Float32[10, 20, 30], nothing)
    @test eltype(a) === Union{Nothing, Float32}
end
