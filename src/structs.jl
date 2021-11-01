export DefaultArray

# To solve this problem, you'll have to improve the `struct` definition and modify/add constructors
struct DefaultArray{N} <: AbstractArray{Any,N}
    parentarray::AbstractArray
    defaultvalue
end
DefaultArray(parentarray, defaultvalue) = DefaultArray{ndims(parentarray)}(parentarray, defaultvalue)

@inline Base.getindex(a::DefaultArray{N}, i::Vararg{Int,N}) where N = checkbounds(Bool, a, i...) ? a.parentarray[i...] : a.defaultvalue
Base.size(a::DefaultArray) = size(a.parentarray)
