include("map.jl")

struct t_exchanger_jl
	cptr::Ptr{Cvoid}
end

function new_exchanger(map  :: t_map_jl    ,
                       type :: MPI.Datatype)
	hw :: Int32 = 0
	return t_exchanger_jl( @ccall libdistdir.new_exchanger(map.cptr :: Ptr{Cvoid}  ,
	                                                       type     :: MPI.Datatype,
	                                                       hw       :: Cint        )::Ptr{Cvoid} )
end

function exchanger_go(exchanger :: t_exchanger_jl ,
                      src_data  :: Vector{T},
                      dst_data  :: Vector{T}) where T
	@ccall libdistdir.exchanger_go(exchanger.cptr :: Ptr{Cvoid},
	                               src_data       :: Ptr{Cvoid},
	                               dst_data       :: Ptr{Cvoid})::Cvoid
end

function exchanger_go(exchanger     :: t_exchanger_jl ,
	                  src_data      :: Vector{T}      ,
	                  dst_data      :: Vector{T}      ,
	                  transform_src :: Vector{Int32}  ,
	                  transform_dst :: Vector{Int32}  ) where T
	@ccall libdistdir.exchanger_go_with_transform(exchanger.cptr :: Ptr{Cvoid},
	                                              src_data       :: Ptr{Cvoid},
	                                              dst_data       :: Ptr{Cvoid},
	                                              transform_src  :: Ptr{Cint} ,
	                                              transform_dst  :: Ptr{Cint} )::Cvoid
end

function delete_exchanger(exchanger :: t_exchanger_jl)
	@ccall libdistdir.delete_exchanger(exchanger.cptr::Ptr{Cvoid})::Cvoid
end