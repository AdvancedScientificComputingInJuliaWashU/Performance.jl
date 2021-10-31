# Performance

[![Build Status](https://github.com/AdvancedScientificComputingInJuliaWashU/Performance.jl/workflows/CI/badge.svg)](https://github.com/AdvancedScientificComputingInJuliaWashU/Performance.jl/actions)

This assignment has two goals:
- it coaches you in good Julia practices, avoiding traps that can kill performance. By and large, this is an exercise in avoiding patterns that result in poor type inference, and in experimenting with tools that help you detect, diagnose, and resolve inference problems.
- it introduces a few concepts from the analysis of algorithms, specifically the "big-O" notation and its use in evaluating implementations.

For this homework, start from the `test/runtests.jl` file, which mostly just `include`s a number of individual test files.
Open them one-by-one and read the comments that describe the problems to be solved.
These individual test files start with one or more links, usually to sections of the Julia manual's [Performance tips](https://docs.julialang.org/en/v1/manual/performance-tips/) page. Start by reading those pages/sections for background information that will help in solving this problem.

Solve the problems by modifying the file of the same name in `src/`, *not* by modifying the tests.
One exception to this rule is the `ntests_finished` at the top of `runtests.jl`: if you're bothered by failures of the
tests you haven't yet fixed, just set this to the number of files whose tests you want to run. For example, to run
just the tests in `test/globals.jl`, set `ntests_finished = 1`. If you do modify `ntests_finished`,
make sure you put it back (or set `ntests_finished = typemax(Int)`) to ensure they all run before
you declare victory with this assignment.

Some problems might say "See `?somefunction`," which means you should read the help on `somefunction`.

Finally, a couple of notes about this repository:
- when creating it, I deliberately left out the `Documenter` and `Codecov` plugins since neither is needed
for this assignment.
- some packages like ProfileView are listed as depenencies of this repository. This is for your convenience, but
  any real package generally shouldn't include such dependencies. Put them in your default environment instead,
  reserving the package environment for things actually needed by the package.
