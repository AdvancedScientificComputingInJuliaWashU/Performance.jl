export Operator, Plus, Minus, Times, Divide
export calculate_typed, calculate_branch

abstract type Operator end
struct Plus  <: Operator end
struct Minus <: Operator end
struct Times <: Operator end
struct Divide <: Operator end

(::Plus)(a, b) = a + b
(::Minus)(a, b) = a - b
(::Times)(a, b) = a * b
(::Divide)(a, b) = a / b

"""
    calculate_typed(numbers, operations)

`calculate_typed` performs the computations decribed by `operations` on the values in `numbers`.
`numbers[1]` and `numbers[2]` get combined via `operations[1]`, and the result is then kept and updated
with additional elements of each.

# Examples

```julia
julia> numbers = [1, 2, 5];

julia> operations = Operator[Plus(), Divide()]

julia> calculate_typed(numbers, operations)
0.6
```

This corresponds to the calculation: `1 Plus() 2 -> 3`, followed by `3 Divide() 5 -> 0.6`.
The `3` in the second calculation is the result of the first calculation.
"""
function calculate_typed(numbers::AbstractVector{<:Real}, operations::AbstractVector{Operator})
    a = Float64(numbers[1])
    for i = 1:length(operations)
        b = numbers[i+1]
        op = operations[i]
        a = op(a, b)
    end
    return a
end

"""
calculate_typed(numbers, operations)

`calculate_branch` does the same job as `calculate_typed`, except the operations are encoded as a string.

# Examples

```julia
julia> numbers = [1, 2, 5];

julia> operations = "+/";

julia> calculate_branch(numbers, operations)
0.6
```
"""
function calculate_branch(numbers::AbstractVector{<:Real}, operations::AbstractString)
    # Duplicate the function above, except instead of iterating through Operators,
    # iterate through the characters in `operations` (which will all be one of `+`, `-`, `*`, `/`)
    # Do not create an Operator from the character, instead just use a set of `if...elseif...end`
    # conditionals.
    error("you have to implement this function")
end
