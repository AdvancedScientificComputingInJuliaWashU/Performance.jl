using Performance
using Test

ntests_finished = 3   # increment this counter to run the next set of tests

@testset "Performance.jl" begin
    ntests = ntests_finished
    if ntests > 0
        ntests -= 1
        include("globals.jl")
    end
    if ntests > 0
        ntests -= 1
        include("arrays.jl")
    end
    if ntests > 0
        ntests -= 1
        include("structs.jl")
    end
end
