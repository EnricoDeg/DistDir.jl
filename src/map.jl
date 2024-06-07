include("idxlist.jl")

struct t_map_jl
	cptr::Ptr{Cvoid}
end

function new_map(src_idxlist :: t_idxlist_jl,
                 dst_idxlist :: t_idxlist_jl,
                 comm        :: MPI.Comm    )
	i :: Int32 = -1
	return t_map_jl( @ccall libdistdir.new_map(src_idxlist.cptr :: Ptr{Cvoid},
	                                           dst_idxlist.cptr :: Ptr{Cvoid},
	                                           i                :: Cint      ,
	                                           comm             :: MPI.Comm  )::Ptr{Cvoid} )
end

function new_map(src_idxlist :: t_idxlist_jl,
                 dst_idxlist :: t_idxlist_jl,
                 stride      :: Int32       ,
                 comm        :: MPI.Comm    )
	return t_map_jl( @ccall libdistdir.new_map(src_idxlist.cptr :: Ptr{Cvoid},
	                                           dst_idxlist.cptr :: Ptr{Cvoid},
	                                           stride           :: Cint      ,
	                                           comm             :: MPI.Comm  )::Ptr{Cvoid} )
end

function new_map(map2d   :: t_map_jl,
	             nlevels :: Int32   )
	return t_map_jl( @ccall libdistdir.extend_map_3d(map2d.cptr :: Ptr{Cvoid},
	                                                 nlevels    :: Cint      )::Ptr{Cvoid} )
end

function delete_map(map :: t_map_jl)
	@ccall libdistdir.delete_map(map.cptr::Ptr{Cvoid})::Cvoid
end
