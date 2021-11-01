using Performance
using BenchmarkTools
using Test

@testset "structs" begin
    ##
    ## https://docs.julialang.org/en/v1/manual/performance-tips/#Type-declarations
    ##
    # Unfortunately, this problem is not Revise-friendly. You'll have to restart your
    # Julia session when you make substantive changes to the source code.
    #
    # Also, this problem uses an AbstractArray type as an example, but the lessons
    # apply to almost any `struct`. One specific feature, though, is that
    # `AbstractArray` has a standard
    # [interface](https://docs.julialang.org/en/v1/manual/interfaces/#man-interface-array)
    # that you may need to learn for this problem. Not very many types in Julia are this well
    # standardized, but it's a good model for how to think about composability
    # and extensability more generally, two key goals for "good" code.
    a = DefaultArray([10, 20, 30], 0)
    @test @inferred(a[2]) === 20
    @test @inferred(a[4]) === 0
    # This one is trickier. See https://docs.julialang.org/en/v1/manual/constructors/#Parametric-Constructors
    # for help. See `?promote_type` as a hint for crafting your solution.
    a = DefaultArray(Float32[10, 20, 30], 0)
    @test @inferred(a[2]) === 20.0f0
    @test @inferred(a[4]) === 0.0f0
    a = DefaultArray(Float32[10, 20, 30], nothing)
    @test eltype(a) === Union{Nothing, Float32}
end
