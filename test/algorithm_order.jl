using BenchmarkTools
using Random
using Test

@testset "algorithmic order" begin
    ##
    ## The goal of this problem is to get you thinking about algorithmic order.
    ##
    # There's no src/ code for this problem, write everything here.
    # Note that `@elapsed` is like time and is simple in that it just runs your operation once.
    # You may need to execute this file more than once in case compilation time complicates the interpretation.

    str = randstring(10^6)
    d = Dict{Char,Int}()
    t = @elapsed for c in ['a':'z'; 'A':'Z'; '0':'9']
        d[c] = count(==(c), str)
    end

    d2 = Dict{Char,Int}()
    t2 = @elapsed # ...
    @test t2 < t

    # Since it's a discrete list of values, can you do even better with an array?
    # Hint: try `Int('z')` for ideas.
    counter = zeros(Int, 26*2+10)
    t3 = @elapsed # ...
    @test t3 < t2
end
