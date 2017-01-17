# Wrappers for Tensor type are defined by
# the math operation defined in tensorflow
# and the KB function in keras.
#
# Refs:
# - https://www.tensorflow.org/api_docs/python/framework/core_graph_data_structures#Tensor.__add__
#
# NOTE: Unfortunately, this needs to be largely written by hand as we don't have a perfect
# mapping of function names and we aren't performing inspection on the python KB code.
#
# TODO: Check that PyObject is an appropriate Tensor.
type Tensor
    o::PyObject
end


Base.abs(x::Tensor) = Tensor(x.o[:abs]())

Base.:-(x::Tensor) = Tensor(x.o[:__neg__](x.o))
Base.:~(x::Tensor) = Tensor(x.o[:__invert__]())
Base.:&(a::Tensor, b::Tensor) = Tensor(a.o[:__and__](b.o))
Base.:|(a::Tensor, b::Tensor) = Tensor(a.o[:__or__](b.o))
Base.mod(a::Tensor, b::Tensor) = Tensor(a.o[:__mod__](b.o))
Base.:.^(a::Tensor, b::Tensor) = Tensor(a.o[:__pow__](b.o))

Base.:.==(a::Tensor, b::Tensor) = Tensor(Keras._backend[:equal](a.o, b.o))
Base.:.!=(a::Tensor, b::Tensor) = Tensor(Keras._backend[:not_equal](a.o, b.o))
Base.:.>(a::Tensor, b::Tensor) = Tensor(Keras._backend[:greater](a.o, b.o))
Base.:.<(a::Tensor, b::Tensor) = Tensor(Keras._backend[:lesser](a.o, b.o))
Base.:.>=(a::Tensor, b::Tensor) = Tensor(Keras._backend[:greater_equal](a.o, b.o))
Base.:.<=(a::Tensor, b::Tensor) = Tensor(Keras._backend[:lesser_equal](a.o, b.o))

Base.:.+(a::Tensor, b::Tensor) = Tensor(a.o[:__add__](b.o))
Base.:.-(a::Tensor, b::Tensor) = Tensor(a.o[:__sub__](b.o))
Base.:.*(a::Tensor, b::Tensor) = Tensor(a.o[:__mul__](b.o))
Base.:./(a::Tensor, b::Tensor) = Tensor(a.o[:__div__](b.o))

Base.dot(a::Tensor, b::Tensor) = Tensor(Keras._backend[:dot](a.o, b.o))
Base.transpose(x::Tensor) = Tensor(Keras._backend[:transpose](x.o))
Base.maximum(x::Tensor, dims=nothing) = Keras._backend[:max](x.o, axis=dims)
Base.minimum(x::Tensor, dims=nothing) = Keras._backend[:min](x.o, axis=dims)
Base.sum(x::Tensor, dims=nothing) = Keras._backend[:sum](x.o, axis=dims)
Base.prod(x::Tensor, dims=nothing) = Keras._backend[:prod](x.o, axis=dims)
Base.var(x::Tensor, dims=nothing) = Keras._backend[:var](x.o, axis=dims)
Base.std(x::Tensor, dims=nothing) = Keras._backend[:std](x.o, axis=dims)
Base.mean(x::Tensor, dims=nothing) = Keras._backend[:mean](x.o, axis=dims)
Base.any(x::Tensor, dims=nothing) = Tensor(Keras._backend[:any](x.o, axis=dims))
Base.all(x::Tensor, dims=nothing) = Tensor(Keras._backend[:all](x.o, axis=dims))
Base.sqrt(x::Tensor) = Tensor(Keras._backend[:sqrt](x.o))
Base.exp(x::Tensor) = Tensor(Keras._backend[:exp](x.o))
Base.log(x::Tensor) = Tensor(Keras._backend[:log](x.o))
Base.round(x::Tensor) = Tensor(Keras._backend[:round](x.o))
Base.sin(x::Tensor) = Tensor(Keras._backend[:sin](x.o))
Base.cos(x::Tensor) = Tensor(Keras._backend[:cos](x.o))

clip(x::Tensor, min_val, max_val) = Tensor(Keras._backend[:clip](x.o, min_val, max_val))
square(x::Tensor) = Tensor(Keras._backend[:square](x.o))
variable(x::Tensor, name=nothing) = Keras._backend[:variable](x.o, name=name)
rand_uni(args...; kwargs...) = Keras._backend[:random_uniform_variable](args...; kwargs...)
rand_norm(args...; kwargs...) = Keras._backend[:random_normal_variable](args...; kwargs...)
cast(x::Tensor, dtype) =  Keras._backend[:cast](x.o, dtype)

# This is not a complete wrapping of the keras backend.

export Tensor, square, clip, variable, rand_uni, rand_norm, cast
