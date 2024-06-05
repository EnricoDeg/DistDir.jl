include("system.jl")

struct t_idxlist_jl
	cptr::Ptr{Cvoid}
end

function new_idxlist(list :: Vector{Int32})
	return t_idxlist_jl( @ccall libdistdir.new_idxlist(list :: Ptr{Cint}, length(list) :: Cint)::Ptr{Cvoid} )
end

function new_idxlist()
	return t_idxlist_jl( @ccall libdistdir.new_idxlist_empty()::Ptr{Cvoid} )
end

function delete_idxlist(idxlist::t_idxlist_jl)
	@ccall libdistdir.delete_idxlist(idxlist.cptr::Ptr{Cvoid})::Cvoid
end
